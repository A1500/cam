function init(){
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	fisPriceGoodsServiceDS.load(true);
}
function getParam(tag){
	var value = document.getElementById(tag).value;
	//if (value == "")
	//	value = undefined;
	return value;
}
function querys(){
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	fisPriceGoodsServiceDS.setParameter("funeralName",getParam("qName"));
	fisPriceGoodsServiceDS.setParameter("serviceName",getParam("qSName"));
	fisPriceGoodsServiceDS.setParameter("priceDescQ",getParam("qBZQ"));//收费标准开始
	fisPriceGoodsServiceDS.setParameter("priceDescZ",getParam("qBZZ"));//收费标准结束
	fisPriceGoodsServiceDS.setParameter("invoiceCodeType",getParam("qXZ"));//收费性质
	fisPriceGoodsServiceDS.setParameter("priceStandard",getParam("qDJ"));//定价形式
	fisPriceGoodsServiceDS.setParameter("priceExeTime",getParam("qtime"));
	fisPriceGoodsServiceDS.setParameter("JMQ",getParam("qJMQ"));//减免标准开始
	fisPriceGoodsServiceDS.setParameter("JMZ",getParam("qJMZ"));//减免标准结束
	fisPriceGoodsServiceDS.load();
}

function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("workId",records[0].get("WORK_ID"));
	data.put("funeralCode",records[0].get("FUNERAL_CODE"));
	var url="jsp/cams/fis/ex/fisDetailsDetail.jsp";
	L5.forward(url,'',data);
}
function CheckTxt(ObjNum, ChnName) {
	var regExp = /^\d+(\.\d+)?$/;
	var elementTxt = document.getElementById(ObjNum);
	if (regExp.test(elementTxt.value)) {
		return true;
	} else {
		L5.Msg.alert("提示","【"+ChnName + "】请输入阿拉伯数字!");
		elementTxt.focus();
		elementTxt.value = "";
		return false;
	}
}
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();	
	L5.dataset2excel(dataset, "/jsp/cams/fis/ex/fisPriceGoodsServiceQueryExcel.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}