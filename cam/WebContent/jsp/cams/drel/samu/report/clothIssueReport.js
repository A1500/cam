function init(){
	geroApplyDs.setParameter("manaLevel",organCode);
	var ds=L5.DatasetMgr.lookup("geroApplyDs");
	ds.on('load',function(){
		document.getElementById('label1').innerHTML=ds.sum("TOTAL_NUM");
		document.getElementById('label2').innerHTML=ds.sum("APPLY_CLOTHNUM");
		document.getElementById('label3').innerHTML=ds.sum("SPRING_CLOTH");
		document.getElementById('label4').innerHTML=ds.sum("SUMMER_CLOTH");
		document.getElementById('label5').innerHTML=ds.sum("AUTUMN_CLOTH");
		document.getElementById('label6').innerHTML=ds.sum("WINTER_CLOTH");
	});
}

function query(){
	var geroApplyDs = L5.DatasetMgr.lookup("geroApplyDs");
    var queryYear=document.getElementById("queryYear").value;
	if(queryYear==""||queryYear==null){
		L5.Msg.alert("提示","查询年度不能为空");
		return;
		}
	geroApplyDs.setParameter("queryYear",queryYear);
	geroApplyDs.setParameter("manaLevel",organCode);
	geroApplyDs.load();
	document.getElementById("statisticsTime").innerText=queryYear+"年";
	document.getElementById("reDiv").style.display = "";
}
/**
 *  事件处理：点击地区链接跳转下级明细数据
 * 零花钱信息列表
 *  @tr
 */
function queryNextLevel(obj){
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
    var queryYear=document.getElementById("queryYear").value;
	if(queryYear==""||queryYear==null){
		L5.Msg.alert("提示","查询年度不能为空");
		return;
		}
	
	if(organCode.indexOf('000')==-1){
		return;
	}
	var geroApplyDs=L5.DatasetMgr.lookup("geroApplyDs");
	geroApplyDs.setParameter("queryYear",queryYear);		
	geroApplyDs.setParameter("manaLevel",organCode);
	geroApplyDs.load();
	document.getElementById("statisticsTime").innerText=queryYear+"年";
	document.getElementById("reDiv").style.display = "";
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
	L5.dataset2excel(dataset,"/jsp/cams/drel/samu/reportExcel/clothIssueExcel.jsp?statisticsTime="+statisticsTime);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}