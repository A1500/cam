function init(){
	document.getElementById("pocketYm").value=getCurDate().substring(0,7);
	geroApplyDs.setParameter("pocketArea",organCode);
	var ds=L5.DatasetMgr.lookup("geroApplyDs");
	ds.on('load',function(){
		document.getElementById('label1').innerHTML=ds.sum("TOTAL_NUM");
		document.getElementById('label2').innerHTML=getMoneyFormat(ds.sum("APPLY_MONEYNUM"));
		document.getElementById('label3').innerHTML=getMoneyFormat(ds.sum("AVERAGE_MONEY"));
	});
}

function query(){
	var geroApplyDs = L5.DatasetMgr.lookup("geroApplyDs");
    var pocketYm = document.getElementById("pocketYm").value;
    if(pocketYm=="") {
		L5.Msg.alert("提示","请填写统计年月！");
		return;
	}
	geroApplyDs.setParameter("pocketYm",pocketYm);
	geroApplyDs.setParameter("pocketArea",organCode);
	geroApplyDs.load();
	document.getElementById("statisticsTime").innerText=pocketYm;
	document.getElementById("reDiv").style.display = "";
}
/**
 *  事件处理：点击地区链接跳转下级明细数据
 * 零花钱信息列表
 *  @tr
 */
function queryNextLevel(obj){
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
    var pocketYm = document.getElementById("pocketYm").value;//查询年月
    
    if(pocketYm=="") {
		L5.Msg.alert("提示","请填写统计年月！");
		return;
	}
	
	if(organCode.indexOf('000')==-1){
		return;
	}
	var geroApplyDs=L5.DatasetMgr.lookup("geroApplyDs");
	geroApplyDs.setParameter("pocketYm", pocketYm);	
	geroApplyDs.setParameter("pocketArea",organCode);
	geroApplyDs.load();
	document.getElementById("statisticsTime").innerText=pocketYm;
	document.getElementById("reDiv").style.display = "";
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("geroApplyDs");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var statisticsTime=document.getElementById("statisticsTime").innerText;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset,"/jsp/cams/drel/samu/reportExcel/checkBodyExcel.jsp?statisticsTime="+statisticsTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}