function init() {
	if(sign==1){
		DmXzqhDataSetState.setParameter("filterSql"," leve='2' and substr(id,1,4)= '" + organArea.substring(0, 4) + "'");
    	L5.DatasetMgr.lookup("DmXzqhDataSetState").load();	
	}else{
		DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '" + organArea.substring(0, 6) + "'");
    	L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();
	}
	
    ds.on("load",flushPie);
    ds.load();
    L5.QuickTips.init();
};

function setXzqhStreet() {
   var county = document.getElementById("county").value;
	DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+county.substr(0,6)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function flushPie() {
	document.getElementById("svgDiv").innerHTML = "<embed id=\"svg\" src=\"knhByFolkAnalysisPie.svg\" width=\"100%\" height=\"100%\" type=\"image/svg+xml\" pluginspage=\"SVGView.exe\"/>";
}
function getDzCun() {
	var dzZhenquery = document.getElementById("dzZhenquery").value;
	DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and substr(id,1,9)= '"+dzZhenquery.substr(0,9)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
}
function query() {
	var county = getParam("county");
	var dzZhen = getParam("dzZhenquery");
    var dzCun = getParam("dzCunquery");
	var jzlx = getParam("jzlxquery");
	var folk = getParam("nation");
	ds.setParameter("countyquery", county);
    ds.setParameter("dzZhenquery", dzZhen);
    ds.setParameter("dzCunquery", dzCun);
    ds.setParameter("jzlxQuery", jzlx);
    ds.setParameter("folkQuery", folk);
	ds.load();
}