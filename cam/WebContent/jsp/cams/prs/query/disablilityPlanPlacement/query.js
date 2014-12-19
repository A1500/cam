var orgName;
function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+xzqu+"'");
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
	});
	ds.setParameter("xzqu", xzqu);
	ds.setParameter("planYear", planYear);
	ds.load();
	ds.on('load', function(){
		OrgNameDataset.load();
	});
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
	 	showDiv();
	});
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
	setStatisticsTime();
}
function setStatisticsTime(){
	if(planYear!=null){
		document.getElementById("statisticsTime").innerText = planYear+"年01月01日-"+planYear+"年12月31日";
		document.getElementById("reportTitle").innerText = planYear+"年度"+orgName+"计划内伤病残士兵接收安置情况统计表";
	}
}
function test(value) {
	var xzqh = value.nextSibling.innerHTML;
	if(xzqu==xzqh){
		return;
	}
	var data = new L5.Map();
	if (planYear != null) {
		data.put("planYear", planYear);
	}
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqh);
	data.put("pageflag","2");
	var url = "jsp/cams/prs/query/disablilityPlanPlacement/query.jsp";
	L5.forward(url, null, data);
}
function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("planYear",planYear);
		var url = "jsp/cams/prs/query/disablilityPlanPlacement/page.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
}

function querydetail(value,type){
	if(value.innerHTML=='0'){
		return;
	}
	var xzqu = value.nextSibling.innerHTML;
	var url;
	if(type =='2'){
		url='receivedsodiers.jsp?planYear='+planYear+'&xzqu='+xzqu+'&type=1';
	}else if(type =='3'){
		url='unReceivedsodiers.jsp?planYear='+planYear+'&xzqu='+xzqu+'&type=0';
	}
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
/**
 * 导出Excel
 */
function excel(){
	var ds = L5.DatasetMgr.lookup("ds");//获取dataset
	if(ds.getTotalCount()==0) {
		alert();
		return;
	}
	var fileName = "";//导出Excel文件时的文件名的定义;
	fileName = planYear+"年度"+orgName+"计划内伤病残士兵接收安置情况统计表";//导出Excel文件时的文件名
	var pageSize = ds.pageInfo.pageSize;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["ifAll"]="ifAll";
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置，0
	ds.baseParams["limitExcel"]=ds.getTotalCount();//查询到的记录数
	var title=document.getElementById("reportTitle").innerHTML;
	var statisticsTime= document.getElementById("statisticsTime").innerText;
	var url = "/jsp/cams/prs/query/disablilityPlanPlacement/export_page.jsp?fileName="+fileName+"&statisticsTime="+statisticsTime+"&title="+title;
	L5.dataset2excel(ds,url);//L5导出Excel方法
}