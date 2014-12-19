function init() {
	ds.setParameter("xzqu", xzqu);
	if (cxsjq != null) {
		ds.setParameter("cxsjq", cxsjq);
	}
	if (cxsjz != null) {
		ds.setParameter("cxsjz", cxsjz);
	}
	ds.load();
	ds.on("load", showDiv);
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
	setStatisticsTime();
}
function setStatisticsTime(){
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		document.getElementById("statisticsTime").innerText = times[0]+"年"+times[1]+"月"+times[2]+"日";
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日 至 "+ timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
	}
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
	var url = "jsp/cams/prs/query/prsDisability/query_disability.jsp";
	L5.forward(url, null, data);
}
function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/prs/query/prsDisability/page_disability.jsp";
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
	var url='retiredsodiersquery.jsp?cxsjq='+cxsjq+'&cxsjz='+cxsjz+'&xzqu='+xzqu+'&total='+value.innerHTML;
	if(type=='1'){
		url+='&disable=0';
	}else if(type =='2'){
		url+='&disable=1&grade=1&propertie=1';
	}else if(type =='3'){
		url+='&disable=1&grade=1&propertie=2';
	}else if(type =='4'){
		url+='&disable=1&grade=1&propertie=3';
	}else if(type =='5'){
		url+='&disable=1&grade=2&propertie=1';
	}else if(type =='6'){
		url+='&disable=1&grade=2&propertie=2';
	}else if(type =='7'){
		url+='&disable=1&grade=2&propertie=3';
	}else if(type =='8'){
		url+='&disable=1&grade=3&propertie=1';
	}else if(type =='9'){
		url+='&disable=1&grade=3&propertie=2';
	}else if(type =='10'){
		url+='&disable=1&grade=3&propertie=3';
	}else if(type =='11'){
		url+='&disable=1&grade=4&propertie=1';
	}else if(type =='12'){
		url+='&disable=1&grade=4&propertie=2';
	}else if(type =='13'){
		url+='&disable=1&grade=4&propertie=3';
	}
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}