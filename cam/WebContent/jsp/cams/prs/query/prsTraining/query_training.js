var orgName;
function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+xzqu+"'");
	ds.setParameter("xzqu", xzqu);
	if("00000000"!=(xzqu.substring(4,12))){
		ds.setParameter("one_line","1");//只查询县一行，供dao层组装sql用
	}
	if (cxsjq != null) {
		ds.setParameter("cxsjq", cxsjq);
	}
	if (cxsjz != null) {
		ds.setParameter("cxsjz", cxsjz);
	}
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
	var title = "";
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		document.getElementById("statisticsTime").innerText = times[0]+"年"+times[1]+"月"+times[2]+"日";
		title =times[0]+"年度"+orgName+"退役士兵培训统计表";
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日 至 "+ timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
		if(timesq[0]==timesz[0]){
			title =timesq[0]+"年度"+orgName+"退役士兵培训统计表";
		}else{
			title =timesq[0]+"-"+timesz[0]+"年度"+orgName+"退役士兵培训统计表";
		}
	}
	document.getElementById("reportTitle").innerHTML=title;
}

function test(value) {
	var xzqh = value.nextSibling.innerHTML;
	if(xzqh==xzqu){
		return;
	}
	var data = new L5.Map();
	if (cxsjq != null) {
		data.put("cxsjq", cxsjq);
	}
	if (cxsjq != null) {
		data.put("cxsjz", cxsjz);
	}
	data.put("xzqu", xzqh);
	data.put("pageflag","2");
	var url = "jsp/cams/prs/query/prsTraining/query_training.jsp";
	L5.forward(url, null, data);
}
function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/prs/query/prsTraining/page_Training.jsp";
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
	var url='retiredsodiersquery.jsp?cxsjq='+cxsjq+'&cxsjz='+cxsjz+'&xzqu='+xzqu;
//	if(type=='1'){
//		url+='&flag=0';//0:为安置
//	}else if(type =='2'){
//		url+='&flag=1&type=1';
//	}else if(type =='3'){
//		url+='&flag=1&type=0';
//	}
	if(type=='1'){
		url+="&trainingflag=0";//0：未参加培训
	}
	if(type=='2'){
		url+="&trainingflag=1&training_type=1";//1.技能培训 0.职业教育
	}
	if(type=='3'){
		url+="&trainingflag=1&training_type=0";//1.技能培训 0.职业教育
	}
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function exportCSV(){
	var ds = L5.DatasetMgr.lookup("ds");
	if(ds.getTotalCount()==0) {
		return;
	}
	var pageSize = ds.pageInfo.pageSize;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["ifAll"]="ifAll";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var fileName = "";//+orgName;
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		fileName =times[0]+"年度"+orgName;
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		if(timesq[0]==timesz[0]){
			fileName =timesq[0]+"年度"+orgName;
		}else{
			fileName =timesq[0]+"-"+timesz[0]+"年度"+orgName;
		}
	}
	var title=document.getElementById("reportTitle").innerHTML;
	var statisticsTime= document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds, "/jsp/cams/prs/query/prsTraining/page_TrainingExcel.jsp?fileName="+fileName+"&statisticsTime="+statisticsTime+"&title="+title);
}
