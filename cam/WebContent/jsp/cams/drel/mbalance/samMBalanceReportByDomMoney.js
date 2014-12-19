function init() {
    ds.on("load",flushPie);
	ds.setParameter("currentJsp","dom");	
	ds.setParameter("domicileCode",organCode);
    ds.load();
    L5.QuickTips.init();
};
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function flushPie(ds) {
	document.getElementById("svgDiv").innerHTML = "<embed id=\"svg\" src=\"samMBalanceReportByDomMoney.svg\" width=\"100%\" height=\"100%\" type=\"image/svg+xml\" pluginspage=\"SVGView.exe\"/>";
}
function query() {
	var ds=L5.DatasetMgr.lookup('ds');
	if(getParam("qapanageCode")){
		ds.setParameter("domicileCode",getParam("qapanageCode"));
	}
	else{
		ds.setParameter("domicileCode",organCode);
	}
	ds.setParameter("beginTime",getParam("beginTime"));	
	ds.setParameter("maxPay",getParam("maxPay"));	
	ds.setParameter("minPay",getParam("minPay"));	
	ds.setParameter("currentJsp","dom");	
	ds.setParameter("endTime",getParam("endTime"));	
	ds.load();
}