var orgName;
function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+organCode+"'");
	ds.setParameter("xzqu", organCode);
	ds.on('load', function(){
		OrgNameDataset.load();
	});
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
	 	showDiv();
	});
	if(planYear!='null'){
		document.getElementById("planYear").value  = planYear;
		ds.setParameter("planYear", planYear);
		ds.load();
	}
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
	setStatisticsTime();
}
function setStatisticsTime(){
	var planYear = _$("planYear");
	document.getElementById("statisticsTime").innerText = planYear+"年01月01日-"+planYear+"年12月31日";
	document.getElementById("reportTitle").innerText = planYear+"年度"+orgName+"计划内伤病残士兵接收安置情况统计表";
}
function query() {
	var planYear = _$("planYear");
	if (planYear == '') {
		L5.Msg.alert('提示', '计划年度不能为空！');
		return false;
	}
	ds.setParameter("planYear", planYear);
	ds.setParameter("xzqu", organCode);
	ds.load();
	noReclick(ds,"queryButton");
}

function test(value) {
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu == organCode){
		return;	
	}
	var data = new L5.Map();
	var planYear = _$("planYear");
	if (planYear == '') {
		L5.Msg.alert('提示', '计划年度不能为空！');
		return false;
	}
	data.put("planYear",planYear);
	data.put("pageflag","1");
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/prs/query/disablilityPlanPlacement/query.jsp";
	L5.forward(url, null, data);
}
function back() {
	history.go(-1);
}

function querydetail(value,type){
	if(value.innerHTML=='0'){
		return;
	}
	var planYear = _$("planYear");
	if (planYear == '') {
		L5.Msg.alert('提示', '计划年度不能为空！');
		return false;
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
	var planYear = _$("planYear");//统计时间的年份
	var tjTime = planYear+"年01月01日 至 "+planYear+"年12月31日";//统计时间
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