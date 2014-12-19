function init() {
    ds.on("load",flushPie);
    ds.load();
    L5.QuickTips.init();
};
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function flushPie() {
	document.getElementById("svgDiv").innerHTML = "<embed id=\"svg\" src=\"spendOfActivityAnalysis.svg\" width=\"100%\" height=\"100%\" type=\"image/svg+xml\" pluginspage=\"SVGView.exe\"/>";
}
function query() {
	var startDate = getParam("startDateQuery");
	var endDate = getParam("endDateQuery");
	var jzfaId = getParam("jzfaIdQuery");
    ds.setParameter("startDateQuery", startDate);
    ds.setParameter("endDateQuery", endDate);
    ds.setParameter("jzfaIdQuery", jzfaId);
	ds.load();
}