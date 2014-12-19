function init() {
	L5.QuickTips.init();
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	showMsg();
	var qReliefType = getParam("qReliefType");
	if(!qReliefType)
		qReliefType="DC,SW,YJ,GD,CJ"
	var url = "reliefRequestSumsListSub.jsp?disYear=" + getParam("qDisYear")
			+ "&reliefType=" + qReliefType;
	document.getElementById("subIframe").src = url;
}
function showMsg() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
}
function hideMsg() {
	L5.Msg.hide();
}