function init(){
	document.getElementById("startMonth").value=getCurDate().substring(0,7);
	document.getElementById("endMonth").value=getCurDate().substring(0,7);
	document.getElementById("reDiv").style.display="none";
	ds.on('load',countTotle);
}
function countTotle(ds){
	document.getElementById('label1').innerHTML=getMoneyFormatNoPoint(ds.sum("NEW_COUNT"));
	document.getElementById('label2').innerHTML=getMoneyFormatNoPoint(ds.sum("END_COUNT"));
	document.getElementById('label3').innerHTML=getMoneyFormatNoPoint(ds.sum("ADD_COUNT"));
	document.getElementById('label4').innerHTML=getMoneyFormat(ds.sum("ADD_MON"));
	document.getElementById('label5').innerHTML=getMoneyFormatNoPoint(ds.sum("LOW_COUNT"));
	document.getElementById('label6').innerHTML=getMoneyFormat(ds.sum("LOW_MON"));
	document.getElementById('label7').innerHTML=getMoneyFormat(ds.sum("NEW_MON"));
	document.getElementById('label8').innerHTML=getMoneyFormat(ds.sum("END_MON"));
	
	document.getElementById('labela').innerHTML=getMoneyFormatNoPoint(ds.sum("NEW_PEO"));
	document.getElementById('labelb').innerHTML=getMoneyFormatNoPoint(ds.sum("END_PEO"));
	document.getElementById('labelc').innerHTML=getMoneyFormatNoPoint(ds.sum("ADD_PEO"));
	document.getElementById('labeld').innerHTML=getMoneyFormatNoPoint(ds.sum("LOW_PEO"));
	
	setButtonAble();
	document.getElementById("reDiv").style.display="block";
}
//按钮启用
function setButtonAble(){
	document.getElementById('queryB').disabled = false;
	document.getElementById('resetB').disabled = false;
	document.getElementById('excelB').disabled = false;
	
}
//按钮禁用
function setButtonUnAble(){
	document.getElementById('queryB').disabled = true;
	document.getElementById('resetB').disabled = true;
	document.getElementById('excelB').disabled = true;
}
//查询按钮
var startTime="";
function query(){
	document.getElementById("reDiv").style.display="none";
    var startMonth = document.getElementById("startMonth").value;//查询时间
    var endMonth = document.getElementById("endMonth").value;//查询时间
    var assistanceType=document.getElementById('assistanceType').value;
    if(assistanceType == '01'){
    	document.getElementById("titleLabel").innerHTML="城市低保变更情况";
    }else if(assistanceType == '02'){
    	document.getElementById("titleLabel").innerHTML="农村低保变更情况";
    }else if(assistanceType == '03'){
  		document.getElementById("titleLabel").innerHTML="农村五保变更情况";
    }
    if(startMonth==""  || endMonth=="" ) {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	setButtonUnAble();
	if(startMonth == endMonth){
		document.getElementById("statisticsTime").innerText =startMonth.substring(0,4)+"年"+startMonth.substring(5,7)+"月";
		startTime=startMonth.substring(0,4)+"年"+startMonth.substring(5,7)+"月";
	}else{
		document.getElementById("statisticsTime").innerText =
			startMonth.substring(0,4)+"年"+startMonth.substring(5,7)+"月"+"-"+
				endMonth.substring(0,4)+"年"+endMonth.substring(5,7)+"月";
		startTime=startMonth.substring(0,4)+"年"+startMonth.substring(5,7)+"月"+"-"+
				endMonth.substring(0,4)+"年"+endMonth.substring(5,7)+"月";
	}
	ds.setParameter("startMonth", startMonth);
	ds.setParameter("endMonth", endMonth);
	ds.setParameter("domicileCode",organCode);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
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
    var startMonth = document.getElementById("startMonth").value;//查询时间
    var endMonth = document.getElementById("endMonth").value;//查询时间
    var assistanceType=document.getElementById('assistanceType').value;
   if(startMonth==""  || endMonth=="" ) {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	
	ds.setParameter("startMonth", startMonth);
	ds.setParameter("endMonth", endMonth);
	ds.setParameter("domicileCode",organCode);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
}
//查询低保新增明细

function getDbMxxz(obj){
	var organCode =  obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML;
	
	
    var startMonth = document.getElementById("startMonth").value;//查询时间
    var endMonth = document.getElementById("endMonth").value;//查询时间
    var assistanceType=document.getElementById('assistanceType').value;
   if(startMonth==""  || endMonth=="" ) {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	var width = screen.width-100;
    var height = screen.height-140;
	var url="samBaseMonthChangeMx.jsp?organCode="+organCode+"&assistanceType="+assistanceType+"&startMonth="+startMonth+"&startMonth="+startMonth+"&endMonth="+endMonth+"&changeItem="+"new";
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
}
//查询低保停保户数明细
function getDbMxtb(obj){
	var organCode =  obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML;
    var startMonth = document.getElementById("startMonth").value;//查询时间
    var endMonth = document.getElementById("endMonth").value;//查询时间
    var assistanceType=document.getElementById('assistanceType').value;
   if(startMonth==""  || endMonth=="" ) {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	var width = screen.width-100;
    var height = screen.height-140;
	var url="samBaseMonthChangeMx.jsp?organCode="+organCode+"&assistanceType="+assistanceType+"&startMonth="+startMonth+"&startMonth="+startMonth+"&endMonth="+endMonth+"&changeItem="+"03";
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
}
//查询低保保障金减少明细
function getDbMxbzjjs(obj){
	var organCode =  obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML;
    var startMonth = document.getElementById("startMonth").value;//查询时间
    var endMonth = document.getElementById("endMonth").value;//查询时间
    var assistanceType=document.getElementById('assistanceType').value;
   if(startMonth==""  || endMonth=="" ) {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	var width = screen.width-100;
    var height = screen.height-140;
	var url="samBaseMonthChangeMx.jsp?organCode="+organCode+"&assistanceType="+assistanceType+"&startMonth="+startMonth+"&startMonth="+startMonth+"&endMonth="+endMonth+"&changeItem="+"02";
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
}
//查询低保保障金增加明细
function getDbMxbzjxz(obj){
	var organCode =  obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML;
    var startMonth = document.getElementById("startMonth").value;//查询时间
    var endMonth = document.getElementById("endMonth").value;//查询时间
    var assistanceType=document.getElementById('assistanceType').value;
   if(startMonth==""  || endMonth=="" ) {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	var width = screen.width-100;
    var height = screen.height-140;
	var url="samBaseMonthChangeMx.jsp?organCode="+organCode+"&assistanceType="+assistanceType+"&startMonth="+startMonth+"&startMonth="+startMonth+"&endMonth="+endMonth+"&changeItem="+"01";
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
}

//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}
function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}
//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("ds");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	L5.dataset2excel(dataset,"/jsp/cams/drel/report/samBaseMonthChangeToExcel.jsp?startTime="+startTime+"&assistanceType="+document.getElementById("assistanceType").value);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function reset(){

	
}