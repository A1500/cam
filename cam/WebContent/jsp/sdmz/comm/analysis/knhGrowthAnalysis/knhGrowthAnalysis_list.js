function init() {
	if(sign==1){
		DmXzqhDataSetState.setParameter("filterSql"," leve='2' and substr(id,1,4)= '" + organArea.substring(0, 4) + "'");
    	L5.DatasetMgr.lookup("DmXzqhDataSetState").load();	
	}else{
		DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '" + organArea.substring(0, 6) + "'");
    	L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();
	}
    ds.on("load",flushPie);
    //ds.load();
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
	document.getElementById("svgDiv").innerHTML = "<embed id=\"svg\" src=\"knhGrowthAnalysisline.svg\" width=\"100%\" height=\"100%\" type=\"image/svg+xml\" pluginspage=\"SVGView.exe\"/>";
}
function getDzCun() {
	var dzZhenquery = document.getElementById("dzZhenquery").value;
	DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and substr(id,1,10)= '"+dzZhenquery.substr(0,10)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
}
function query() {
	var dateArr = document.getElementsByName("date");
	var date="";
	for(var i=0;i<dateArr.length;i++) {
		if(dateArr[i].checked) {
			date = dateArr[i].value;
		}
	}
	if(date=="") {
		alert("请选择统计间隔！");
		return;
	}
	var county = getParam("county");
	var dzZhen = getParam("dzZhenquery");
    var dzCun = getParam("dzCunquery");
	var jzlx = getParam("jzlxquery");
	var startDate = getParam("startDateQuery");
	var endDate = getParam("endDateQuery");
	ds.setParameter("countyquery", county);
    ds.setParameter("startDateQuery", startDate);
    ds.setParameter("endDateQuery", endDate);
    ds.setParameter("dzZhenquery", dzZhen);
    ds.setParameter("dzCunquery", dzCun);
    ds.setParameter("jzlxQuery", jzlx);
    ds.setParameter("date", date);
	ds.load();
}