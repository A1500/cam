function init() {
	ds.setParameter("xzqu", organCode);
	ds.on('load', showDiv);
	if(cxsjq!='null'&&cxsjz!='null'){
		document.getElementById("cxsj_q").value  = cxsjq;
		document.getElementById("cxsj_z").value  = cxsjz;
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
	setStatisticsTime();
}
function setStatisticsTime(){
	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
	if(cxsj_q==cxsj_z){
		var times = cxsj_q.split("-");
		document.getElementById("statisticsTime").innerText = times[0]+"年"+times[1]+"月"+times[2]+"日";
	}else{
		var timesq = cxsj_q.split("-");
		var timesz = cxsj_z.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日 至 "+ timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
	}
}
function query() {
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	ds.setParameter("cxsjq", cxsj_q);
	ds.setParameter("cxsjz",cxsj_z);
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
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	data.put("cxsjq",cxsj_q);
	data.put("cxsjz",cxsj_z);
	data.put("pageflag","1");
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/prs/query/prsDisability/query_disability.jsp";
	L5.forward(url, null, data);
}
function back() {
	history.go(-1);
}

function querydetail(value,type){
	if(value.innerHTML=='0'){
		return;
	}
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	var xzqu = value.nextSibling.innerHTML;
	var url='retiredsodiersquery.jsp?cxsjq='+cxsj_q+'&cxsjz='+cxsj_z+'&xzqu='+xzqu+'&total='+value.innerHTML;
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

function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}