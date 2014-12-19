function init() {
//	L5.Ajax.timeout=300000;
	pageReset();
	L5.QuickTips.init();
};
function pageReset(){
	var time = new Date();
	var times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("ffsj_q").value=timeq;
	document.getElementById("ffsj_z").value=timez;
	document.getElementById("qReliefType").value="";
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	var ffsj_q = getParam("ffsj_q");
	var ffsj_z = getParam("ffsj_z");
	var data = new L5.Map();
	if (ffsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(ffsj_q!=''&&!validateDateFormat(ffsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	if (ffsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(ffsj_z!=''&&!validateDateFormat(ffsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	var qReliefType = getParam("qReliefType");
	if(!qReliefType)
		qReliefType = "DC,SW,YJ,GD,CJ";
	var url = "reliefCaseSumsListSub.jsp?ffsj_q=" + ffsj_q + "&ffsj_z="
			+ ffsj_z + "&reliefType=" + qReliefType;
	document.getElementById("subIframe").src = url;
}
function hideMsg() {
	L5.Msg.hide();
}
