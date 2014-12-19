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
	var timesq = cxsj_q.split("-");
	var timesz = cxsj_z.split("-");
	if(cxsj_q == "" && cxsj_z == ""){
		var dateTime=new Date();
	    var yy=dateTime.getFullYear();
	    var MM=dateTime.getMonth()+1;  //因为1月这个方法返回为0，所以加1
	    var dd=dateTime.getDate();
		document.getElementById("statisticsTime").innerText =  "---- 日 至"+yy+"年"+MM+"月"+dd+"日";
		return;
	}
	if(cxsj_q == "" && cxsj_z != ""){
		document.getElementById("statisticsTime").innerText = "---- 日 至 "+ timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
		return;
	}
	if(cxsj_q != "" && cxsj_z == ""){
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日 至 ----";
		return;
	}
	if(cxsj_q==cxsj_z){
		document.getElementById("statisticsTime").innerText = times[0]+"年"+times[1]+"月"+times[2]+"日";
	}else{
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日 至 "+ timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
	}
}
function query() {
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		//L5.Msg.alert('提示', '查询起始时间不能为空！');
		//return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		//L5.Msg.alert('提示', '查询结束时间不能为空！');
		//return false;
	}
	if (cxsj_q != '') {
		ds.setParameter("cxsjq", cxsj_q);
	}
	if (cxsj_z != '') {
		ds.setParameter("cxsjz",cxsj_z);
	}
	ds.setParameter("xzqu", organCode);
	ds.load();
	noReclick(ds,"queryButton");
}

function toShi(value) {
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu== organCode){
		return ;
	}
	var data = new L5.Map();
	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
	data.put("cxsjq",cxsj_q);
	data.put("cxsjz",cxsj_z);
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "jsp/cams/sorg/query/branchStatic/groupBranchStatic_shi.jsp";
	L5.forward(url, null, data);
}
function back() {
	history.go(-1);
}

function forExcel(){
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds, "/jsp/cams/sorg/query/branchStatic/groupBranchStaticExcel.jsp?statisticsTime="+statisticsTime);
}