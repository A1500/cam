function init(){
	if(organCode.substring(2) == "0000000000") {
		//省局
		document.getElementById("add").style.display='none';	
		document.getElementById("edit").style.display='none';
		document.getElementById("delete").style.display='none';
		document.getElementById("reject").style.display='none';
	}else if(organCode.substring(4) == "00000000"){
		//市局
		if(applyStatus=="0"||applyStatus=="2"||applyStatus=="5"){
			document.getElementById("yes").style.display='none';
		}else if(applyStatus=="1"||applyStatus=="3"){
			document.getElementById("add").style.display='none';	
			document.getElementById("edit").style.display='none';
			document.getElementById("delete").style.display='none';
		}else if(applyStatus=="9"){
			document.getElementById("yes").style.display='none';
			document.getElementById("add").style.display='none';	
			document.getElementById("edit").style.display='none';
			document.getElementById("delete").style.display='none';
		}
		document.getElementById("reject").style.display='none';
	}else if(organCode.substring(6) == "000000"){
		//区县
		if(method=="detail"){
			document.getElementById("add").style.display='none';	
			document.getElementById("edit").style.display='none';
			document.getElementById("delete").style.display='none';
		}
		if(applyStatus=="2"||applyStatus=="5"){
			document.getElementById("reject").style.display='';
		}else{
			document.getElementById("reject").style.display='none';
		}
		document.getElementById("yes").style.display='none';
	}
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	fisPriceGoodsServiceDS.setParameter("FEE_ITEM_ID",priceApplyId);//业务批次ID
	fisPriceGoodsServiceDS.setParameter("IN_USE","1");//有效标志
	fisPriceGoodsServiceDS.setParameter("sort","SCQ");	
	fisPriceGoodsServiceDS.setParameter("dir","asc");
	fisPriceGoodsServiceDS.load(true);
}
function getParam(tag){
	var value = document.getElementById(tag).value;
	if (value == "")
		value = undefined;
	return value;
}
function query(){
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	fisPriceGoodsServiceDS.setParameter("CREATE_ORGAN_NAME@LIKE",getParam("qName"));
	fisPriceGoodsServiceDS.setParameter("SERVICE_NAME@LIKE",getParam("qSName"));
	fisPriceGoodsServiceDS.setParameter("PRICE_STANDARD",getParam("qDJ"));
	fisPriceGoodsServiceDS.setParameter("FEE_ITEM_ID",priceApplyId);//业务批次ID
	fisPriceGoodsServiceDS.setParameter("IN_USE","1");//有效标志
	fisPriceGoodsServiceDS.setParameter("sort","SCQ");	
	fisPriceGoodsServiceDS.setParameter("dir","asc");
	fisPriceGoodsServiceDS.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	data.put("feeID",priceApplyId);//业务批次ID
	data.put("funeralCode",funeralCode);//馆编号
	data.put("funeralName",encodeURIComponent(encodeURIComponent(funeralName)));//馆名称
	var url="jsp/cams/fis/ex/fisDetailsList.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("feeID",priceApplyId);//业务批次ID
	data.put("workId",records[0].get("workId"));//服务项目ID
	data.put("funeralCode",funeralCode);
	//data.put("funeralName",funeralName);
	var url="jsp/cams/fis/ex/fisDetailsList.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","check");
	data.put("workId",records[0].get("workId"));
	data.put("funeralCode",funeralCode);
	var url="jsp/cams/fis/ex/fisCheckDetail.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceCommand");
			command.setParameter("workId",records[0].get("workId"));
			command.setParameter("feeItemId",records[0].get("feeItemId"));
			command.execute("delete");
			if (!command.error){
				L5.Msg.alert("提示","删除成功！",function(){
					init();
					});
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
	
}
function forReject(){
	if(applyStatus=="5"){
		L5.getCmp("rejectWin2").show(); //省级驳回意见
	}else if(applyStatus=="2"){
		L5.getCmp("rejectWin").show();//市级驳回意见
	}
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("PRICE_APPLY_ID",priceApplyId);
	queryDs.load();
}
function closeRejectWin(){
	if(applyStatus=="5"){
		L5.getCmp("rejectWin2").hide(); //省级驳回意见
	}else if(applyStatus=="2"){
		L5.getCmp("rejectWin").hide();//市级驳回意见
	}
}
function winShow(){
	if(organCode.substring(2) == "0000000000"){
		L5.getCmp("reasonWin2").show(); //省级意见
	}else if(organCode.substring(4) == "00000000"){
		L5.getCmp("reasonWin").show();//市级意见
	}
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("PRICE_APPLY_ID",priceApplyId);
	queryDs.load();
}
function closeWin(){
	if(organCode.substring(2) == "0000000000"){
		L5.getCmp("reasonWin2").hide(); //省级意见
	}else if(organCode.substring(4) == "00000000"){
		L5.getCmp("reasonWin").hide();//市级意见
	}
}
function confirm(){
	//0:未上报,1:已上报,2:已审核驳回,3:已审核,5:已备案驳回,9:已公示备案
	//alert((document.getElementById("batchType").value));//2:同意,3:退回 市级审核意见
	
	
	var queryDs1=L5.DatasetMgr.lookup("queryDs1");
	queryDs1.setParameter("PRICE_APPLY_ID",priceApplyId);
	queryDs1.load(true);
	var record = queryDs1.getCurrent();
	
	
	//省级审核意见不能为空
	if(organCode.substring(2) == "0000000000"){
		if(getParam("auditT")=="" || getParam("auditT")== undefined){
			L5.Msg.alert("提示","省级审核意见不能为空！");
			return;
		}
		if(getParam("auditT")=="2"){//省级同意
			record.set("applyStatus","9"); //已公示备案
			record.set("auditStatus","2");
		}
		if(getParam("auditT")=="3"){//省级驳回
			record.set("applyStatus","5"); //已备案驳回
			record.set("auditStatus","3");
		}
		record.set("auditTime",new Date());
		record.set("auditType",getParam("auditType"));
	}else if(organCode.substring(4) == "00000000"){//市级审核意见
		if(getParam("batchType")=="" || getParam("batchType")==undefined){
			L5.Msg.alert("提示","审核意见不能为空！");
			return;
		}
		if(getParam("batchType")=="2"){
			record.set("applyStatus","3");
			record.set("batchStatus","2");
		}
		if(getParam("batchType")=="3"){
			record.set("applyStatus","2");
			record.set("batchStatus","3");
		}
		record.set("checkTime",new Date());
		record.set("batchType",getParam("checkOppion"));
	}
	var his=L5.DatasetMgr.lookup("his");
	his.newRecord();
	var hisdRecord = his.getCurrent();
	hisdRecord.set("hisId",newHisId);
	hisdRecord.set("priceApplyId",priceApplyId);
	hisdRecord.set("dealOrgan",organCode);
	hisdRecord.set("dealOrganName",organName);
	if(organCode.substring(2) == "0000000000"){
		hisdRecord.set("dealTime",record.get("auditTime"));
		hisdRecord.set("dealOption",record.get("auditType"));
	}else if(organCode.substring(4) == "00000000"){
		hisdRecord.set("dealTime",record.get("checkTime"));
		hisdRecord.set("dealOption",record.get("batchType"));
	}
	
	L5.MessageBox.confirm("提示", "是否提交该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceApplyCommand");
			command.setParameter("record",record);
			command.setParameter("hisdRecord",hisdRecord);
			//command.execute("update");
			command.execute("updateAll");
			if (!command.error){
				L5.Msg.alert("提示","提交成功！",function(){
					closeWin();
					history.go(-1);
					});
			}else{
				L5.Msg.alert("提示","提交出错！");
			}
		}
	});
}
function returnBack(){
	history.go(-1);
} 
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/fis/ex/fisPriceGoodsServiceExcel.jsp");
}

function readPublic() {
	var dataset=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能预览!");
		return false;
	}	
	var url = '../../../ext/onlineService/fis/query/apply/fisServiceQuery.jsp?priceApplyId='+priceApplyId;
	var width = screen.width-50;
    var height = screen.height-50;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}