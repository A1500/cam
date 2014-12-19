function init() {
	ds.on("load",showDiv)
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
	var yearQuery = getParam("yearQuery");
	var monthQuery = getParam("monthQuery");
	if(yearQuery==undefined) {
		L5.Msg.alert("提示","请选择统计年份！");
		return;
	}
	if(monthQuery==undefined) {
		L5.Msg.alert("提示","请选择统计上半年或下半年！");
		return;
	}
	if(monthQuery=="s") {
	    ds.setParameter("startDate", yearQuery+"-01-01 00:00:00");
	    ds.setParameter("endDate", yearQuery+"-06-30 00:00:00");
	} else {
	    ds.setParameter("startDate", yearQuery+"-07-01 00:00:00");
	    ds.setParameter("endDate", yearQuery+"-12-31 00:00:00");
	}
    ds.load();
}
function showDiv() {
	var length = ds.getCount();
	if(length==0) {
		ds.newRecord({"PLAN_ORGAN_NAME":"无救助信息","NUM":0,"FAMILY_NUM":0,"PEOPLE_NUM":0,"FUND":0});
	}
	setReportTitle();
	document.getElementById("reDiv").style.display="";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year = document.getElementById("yearQuery").value;
	var month = document.getElementById("monthQuery").value;
	reportTitleSpan.innerHTML = getChnNumber(year)+"年"+(month=="s"?"上":"下")+"半年各单位救助成果年统计报表";
}
function getChnNumber(code) {
	if(code==undefined||code=="") return;
	var codeArr = code.split("");
	var reStr = "";
	for(var i=0;i<codeArr.length;i++) {
		switch(codeArr[i]) {
			case '0': reStr += "零"; break;
			case '1': reStr += "一"; break;
			case '2': reStr += "二"; break;
			case '3': reStr += "三"; break;
			case '4': reStr += "四"; break;
			case '5': reStr += "五"; break;
			case '6': reStr += "六"; break;
			case '7': reStr += "七"; break;
			case '8': reStr += "八"; break;
			case '9': reStr += "九"; break;
			default: reStr += codeArr[i];
		}
	}
	return reStr;
}