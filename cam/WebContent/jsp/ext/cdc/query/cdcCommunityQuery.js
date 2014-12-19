function init(){
	document.getElementById("reDiv").style.display="none";
	queryDataSet.on('load',countTotle);
}
function countTotle(ds){
	document.getElementById('label1').innerHTML=ds.sum("C_NUM");
	document.getElementById('label2').innerHTML=ds.sum("Y_POPULATE_NUM");
	document.getElementById('label3').innerHTML=ds.sum("N_NUM");
	document.getElementById('label4').innerHTML=ds.sum("Y_POP_NUM");
	document.getElementById('label5').innerHTML=ds.sum("C_NUM");
	document.getElementById('label6').innerHTML=ds.sum("Y_PEOPLE_NUM");
	document.getElementById('label7').innerHTML=ds.sum("N_NUM");
	document.getElementById('label8').innerHTML=ds.sum("Y_PEO_NUM");
	document.getElementById('label9').innerHTML=ds.sum("C_NUM");
	document.getElementById('label10').innerHTML=ds.sum("Y_SERVICE_NUM");
	document.getElementById('label11').innerHTML=ds.sum("N_NUM");
	document.getElementById('label12').innerHTML=ds.sum("Y_SER_NUM");
	document.getElementById('label13').innerHTML=ds.sum("C_NUM");
	document.getElementById('label14').innerHTML=ds.sum("Y_FUND_NUM");
	document.getElementById('label15').innerHTML=ds.sum("N_NUM");
	document.getElementById('label16').innerHTML=ds.sum("Y_FUN_NUM");
	document.getElementById('label17').innerHTML=ds.sum("C_NUM");
	document.getElementById('label18').innerHTML=ds.sum("Y_ECONOMY_NUM");
	document.getElementById('label19').innerHTML=ds.sum("N_NUM");
	document.getElementById('label20').innerHTML=ds.sum("Y_ECO_NUM");
	document.getElementById('label21').innerHTML=ds.sum("C_NUM");
	document.getElementById('label22').innerHTML=ds.sum("Y_ORGAN_NUM");
	document.getElementById('label23').innerHTML=ds.sum("N_NUM");
	document.getElementById('label24').innerHTML=ds.sum("Y_ORG_NUM");
	document.getElementById('label25').innerHTML=ds.sum("C_NUM");
	document.getElementById('label26').innerHTML=ds.sum("Y_ELECTION_NUM");
	document.getElementById('label27').innerHTML=ds.sum("N_NUM");
	document.getElementById('label28').innerHTML=ds.sum("Y_ELE_NUM");
	document.getElementById('label29').innerHTML=ds.sum("C_NUM");
	document.getElementById('label30').innerHTML=ds.sum("Y_DECISION_NUM");
	document.getElementById('label31').innerHTML=ds.sum("N_NUM");
	document.getElementById('label32').innerHTML=ds.sum("Y_DEC_NUM");
	document.getElementById('label33').innerHTML=ds.sum("C_NUM");
	document.getElementById('label34').innerHTML=ds.sum("Y_MANAGE_NUM");
	document.getElementById('label35').innerHTML=ds.sum("N_NUM");
	document.getElementById('label36').innerHTML=ds.sum("Y_MAN_NUM");
	document.getElementById('label37').innerHTML=ds.sum("C_NUM");
	document.getElementById('label38').innerHTML=ds.sum("Y_SUPERVISE_NUM");
	document.getElementById('label39').innerHTML=ds.sum("N_NUM");
	document.getElementById('label40').innerHTML=ds.sum("Y_SUP_NUM");
	document.getElementById('label41').innerHTML=ds.sum("C_NUM");
	document.getElementById('label42').innerHTML=ds.sum("Y_CONSTRUCT_NUM");
	document.getElementById('label43').innerHTML=ds.sum("N_NUM");
	document.getElementById('label44').innerHTML=ds.sum("Y_CON_NUM");
	document.getElementById('label45').innerHTML=ds.sum("C_NUM");
	document.getElementById('label46').innerHTML=ds.sum("Y_NATURE_NUM");
	document.getElementById('label47').innerHTML=ds.sum("N_NUM");
	document.getElementById('label48').innerHTML=ds.sum("Y_NAT_NUM");
	document.getElementById('label49').innerHTML=ds.sum("C_NUM");
	document.getElementById('label50').innerHTML=ds.sum("Y_ORGAN2_NUM");
	document.getElementById('label51').innerHTML=ds.sum("N_NUM");
	document.getElementById('label52').innerHTML=ds.sum("Y_ORG2_NUM");
	document.getElementById('label53').innerHTML=ds.sum("C_NUM");
	document.getElementById('label54').innerHTML=ds.sum("Y_TENEMENT_NUM");
	document.getElementById('label55').innerHTML=ds.sum("N_NUM");
	document.getElementById('label56').innerHTML=ds.sum("Y_TEN_NUM");
	document.getElementById('label57').innerHTML=ds.sum("C_NUM");
	document.getElementById('label58').innerHTML=ds.sum("Y_FACILITIES_NUM");
	document.getElementById('label59').innerHTML=ds.sum("N_NUM");
	document.getElementById('label60').innerHTML=ds.sum("Y_FAC_NUM");
}
//查询按钮
var startTime="";
function query(){
	var reportDate = document.getElementById("reportDate").value;//填报日期
    if(reportDate=="") {
		L5.Msg.alert("提示","请选择填报日期！");
		return;
	}
	document.getElementById("reDiv").style.display="block";
	queryDataSet.setParameter("reportDate",_$("reportDate"));
	queryDataSet.setParameter("releaseArea", organCode);
	queryDataSet.load();
}
/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  
 */
function queryNextLevel(obj){
	var organCode =  obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		return;
	}
   	var reportDate = document.getElementById("reportDate").value;//填报日期
    if(reportDate=="") {
		L5.Msg.alert("提示","请选择填报日期！");
		return;
	}
	queryDataSet.setParameter("reportDate",_$("reportDate"));
	queryDataSet.setParameter("releaseArea", organCode);
	queryDataSet.load();
}
//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("queryDataSet");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset,"/jsp/ext/cdc/query/cdcCommunityExcel.jsp?reportDate="+getSelected("reportDate"));
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}

function getSelected(selectedId){
   var ddl = document.getElementById(selectedId);  
   var index = ddl.selectedIndex;   
   //var Value = ddl.options[index].value;   
   return ddl.options[index].text;
}
