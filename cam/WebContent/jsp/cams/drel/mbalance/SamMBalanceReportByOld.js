var age;
function init() {
    ds.on("load",flushPie);
    //ds.load();
    L5.QuickTips.init();
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function flushPie() {
	document.getElementById("svgDiv").innerHTML = "<embed id=\"svg\" src=\"SamMBalanceReportByOld.svg\" width=\"100%\" height=\"100%\" type=\"image/svg+xml\" pluginspage=\"SVGView.exe\"/>";
}
function query() {
    ds.setParameter("organArea",organArea);
	age = getParam("age");
	if(age!=null){	
	    ds.setParameter("age", age);
	}else{
		L5.Msg.alert("提示","必须填写老年人年龄！");
		return;
	}
	ds.load();
}