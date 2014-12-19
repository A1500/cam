var orgName;
function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+xzqu+"'");
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
		showDiv();
	});
	ds.setParameter("xzqu", xzqu);
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
		title =times[0]+"年度"+orgName+"退役士兵因战、因公5~8级伤残统计表";
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日 至 "+ timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
		if(timesq[0]==timesz[0]){
			title =timesq[0]+"年度"+orgName+"退役士兵因战、因公5~8级伤残统计表";
		}else{
			title =timesq[0]+"-"+timesz[0]+"年度"+orgName+"退役士兵因战、因公5~8级伤残统计表";
		}
	}
	document.getElementById("reportTitle").innerHTML=title;
}
function test(value) {
	var xzqh = value.nextSibling.innerHTML;
	if(xzqu==xzqh){
		return;
	}
	var data = new L5.Map();
	if (cxsjq != null) {
		data.put("cxsjq", cxsjq);
	}
	if (cxsjq != null) {
		data.put("cxsjz", cxsjz);
	}
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqh);
	data.put("pageflag","2");
	var url = "jsp/cams/prs/query/prsDisability/level5_8/query_disability.jsp";
	L5.forward(url, null, data);
}
function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/prs/query/prsDisability/level5_8/page_disability.jsp";
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
	if(type=='1'){
	}else if(type =='2'){
		url+='&disable=1&grade=5&propertie=1';
	}else if(type =='3'){
		url+='&disable=1&grade=5&propertie=2';
	}else if(type =='4'){
		url+='&disable=1&grade=6&propertie=1';
	}else if(type =='5'){
		url+='&disable=1&grade=6&propertie=2';
	}else if(type =='6'){
		url+='&disable=1&grade=7&propertie=1';
	}else if(type =='7'){
		url+='&disable=1&grade=7&propertie=2';
	}else if(type =='8'){
		url+='&disable=1&grade=8&propertie=1';
	}else if(type =='9'){
		url+='&disable=1&grade=8&propertie=2';
	}
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
//导出excel
function excel(){
	var ds = L5.DatasetMgr.lookup("ds");
	if(ds.getTotalCount()==0) {
		alert();
		return;
	}
	var fileName = "";//+orgName;
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		fileName =times[0]+"年度"+orgName+"退役士兵因战、因公5~8级伤残统计表";
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		if(timesq[0]==timesz[0]){
			fileName =timesq[0]+"年度"+orgName+"退役士兵因战、因公5~8级伤残统计表";
		}else{
			fileName =timesq[0]+"-"+timesz[0]+"年度"+orgName+"退役士兵因战、因公5~8级伤残统计表";
		}
	}
	var pageSize = ds.pageInfo.pageSize;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["ifAll"]="ifAll";
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();
	var title=document.getElementById("reportTitle").innerHTML;
	var statisticsTime= document.getElementById("statisticsTime").innerText;
	var url = "/jsp/cams/prs/query/prsDisability/level5_8/export_page_disability.jsp?fileName="+fileName+"&statisticsTime="+statisticsTime+"&title="+title;
	L5.dataset2excel(ds,url);
}