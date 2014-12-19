function init(){
	
}
function query(){
	var ds = L5.DatasetMgr.lookup("lowFamilyCountDataSet");
	var beginDate = document.getElementById("startDate").value;//查询结束时间止
    var endDate = document.getElementById("endDate").value;
    
    if(beginDate=="") {
		//L5.Msg.alert("提示","请填写统计起始日期！");
		//return;
	}
	if(endDate=="") {
		//L5.Msg.alert("提示","请填写统计截止日期！");
		//return;
	}
	if(beginDate!=""&&endDate!=""){
		countTime=beginDate.substring(0,4)+"年"+beginDate.substring(5,7)+"月"+beginDate.substring(8,10)+"日"
					+"~"+endDate.substring(0,4)+"年"+endDate.substring(5,7)+"月"+endDate.substring(8,10)+"日";
		
	}
	if(beginDate==""&&endDate==""){
		countTime=beginDate.substring(0,4)+"年"+beginDate.substring(5,7)+"月"+beginDate.substring(8,10)+"日"
					+"之后";
		
	}if(beginDate==""&&endDate!=""){
		countTime=endDate.substring(0,4)+"年"+endDate.substring(5,7)+"月"+endDate.substring(8,10)+"日之前";
		
	}if(beginDate==""&&endDate==""){
		beginDate="0000-00-00";
		endDate="9999-99-99";
		countTime="统计全部";
		
	}
	document.getElementById("statisticsTime").innerText =countTime;
	ds.setParameter("CODEUP",organCode);
	ds.setParameter("STARTDATE",beginDate);
	ds.setParameter("ENDDATE",endDate);
	ds.on("load",function (ds){
		
	});
	ds.load();

}
/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  licb
 */
function queryNextLevel(obj){
	
	var ds = L5.DatasetMgr.lookup("lowFamilyCountDataSet");
	
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		//是否展示村（街道）级的家庭信息
		L5.Msg.alert("提示","已经到达村（街道）级！");
		return;
	}
    var beginDate = document.getElementById("startDate").value;//查询结束时间止
    var endDate = document.getElementById("endDate").value;//行政区划
   	if(beginDate!=""&&endDate!=""){
		countTime=beginDate.substring(0,4)+"年"+beginDate.substring(5,7)+"月"+beginDate.substring(8,10)+"日"
					+"~"+endDate.substring(0,4)+"年"+endDate.substring(5,7)+"月"+endDate.substring(8,10)+"日";
		
	}
	if(beginDate!=""&&endDate==""){
		countTime=beginDate.substring(0,4)+"年"+beginDate.substring(5,7)+"月"+beginDate.substring(8,10)+"日"
					+"之后";
		
	}if(beginDate==""&&endDate!=""){
		countTime=endDate.substring(0,4)+"年"+endDate.substring(5,7)+"月"+endDate.substring(8,10)+"日之前";
		
	}if(beginDate==""&&endDate==""){
		beginDate="0000-00-00";
		endDate="9999-99-99";
		countTime="统计全部";
		
	}
	document.getElementById("statisticsTime").innerText =countTime;
	
	
	ds.setParameter("CODEUP",organCode);
	ds.setParameter("STARTDATE",beginDate);
	ds.setParameter("ENDDATE",endDate);
	ds.load();
}
//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("lowFamilyCountDataSet");
	
	
	var beginDate = document.getElementById("startDate").value;//查询结束时间止
    var endDate = document.getElementById("endDate").value;//行政区划
	
	L5.dataset2excel(dataset,"/jsp/cams/drel/application/cityLow/apply/exportCityLowExcel.jsp?countCol="+countCol+"&beginDate="+beginDate+"&endDate="+endDate);
	
}