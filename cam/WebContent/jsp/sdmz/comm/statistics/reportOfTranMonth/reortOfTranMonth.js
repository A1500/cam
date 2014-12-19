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
		L5.Msg.alert("提示","请选择统计月份！");
		return;
	}
    ds.setParameter("startDate", yearQuery+"-"+monthQuery+"-01");
    ds.setParameter("endDate", yearQuery+"-"+monthQuery+"-31");
    ds.load();
}
function showDiv() {
	var length = ds.getCount();
	if(length==0) {
		ds.newRecord({"name":"无信息","Row1":0,"Row2":0,"Row3":0,"Row4":0,"Row5":0,"Row6":0,"Row7":0,"Row8":0,"Row9":0,"Row10":0,"Row11":0,"Row12":0});
	}
	setReportTitle();
	document.getElementById("reDiv").style.display="";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year = document.getElementById("yearQuery").value;
	var month = document.getElementById("monthQuery").value;
	reportTitleSpan.innerHTML = getChnNumber(year)+"年"+getChnNumber(month,'m')+"月各单位业务办理年统计报表";
}
function getChnNumber(code,type) {
	if(code==undefined||code=="") return;
	var codeArr = new Array();
	if(type=="m") {
		codeArr.push(code.replace("0",""));
	} else {
		codeArr = code.split("");
	}
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
			case '10': reStr += "十"; break;
			case '11': reStr += "十一"; break;
			case '12': reStr += "十二"; break;
			default: reStr += codeArr[i];
		}
	}
	return reStr;
}