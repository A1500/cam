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
	document.getElementById("svgDiv").innerHTML = "<embed id=\"svg\" src=\"knhOfAreaAnalysisPie.svg\" width=\"100%\" height=\"100%\" type=\"image/svg+xml\" pluginspage=\"SVGView.exe\"/>";
}
function query() {
	var jzlx = getParam("jzlxquery");
    ds.setParameter("jzlxQuery", jzlx);
	ds.load();
}