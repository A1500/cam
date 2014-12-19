function init() {
L5.Ajax.timeout=300000;
	ds.on("load", showDiv);
	L5.QuickTips.init();
};

function query() {
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	if (cxsj_q != '') {
		ds.setParameter("cxsj_q", cxsj_q);
	}
	if (cxsj_z != '') {
		ds.setParameter("cxsj_z", cxsj_z);
	}
	ds.setParameter("xzqu", organCode);
	ds.load();
}
function showDiv() {
	setReportTitle();
	document.getElementById("reDiv").style.display = "";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year1 = document.getElementById("cxsj_q").value.split("-")[0];
	var year2 = document.getElementById("cxsj_z").value.split("-")[0];
	if (year1 ==year2) {
		reportTitleSpan.innerHTML = getChnNumber(year1)+"优待金标准";
	} else {
		reportTitleSpan.innerHTML = getChnNumber(year1) +"--"+ getChnNumber(year2)+ "优待金标准";
	}

}
function getChnNumber(code) {
	if (code == undefined || code == "")
		return;
	var codeArr = code.split("");
	var reStr = "";
	for (var i = 0; i < codeArr.length; i++) {
		switch (codeArr[i]) {
			case '0' :
				reStr += "零";
				break;
			case '1' :
				reStr += "一";
				break;
			case '2' :
				reStr += "二";
				break;
			case '3' :
				reStr += "三";
				break;
			case '4' :
				reStr += "四";
				break;
			case '5' :
				reStr += "五";
				break;
			case '6' :
				reStr += "六";
				break;
			case '7' :
				reStr += "七";
				break;
			case '8' :
				reStr += "八";
				break;
			case '9' :
				reStr += "九";
				break;
			default :
				reStr += codeArr[i];
		}
	}
	return reStr;
}

function getTime(time) {
	var times = time.split("-");
	time = times[0] + "." + times[1];
	return time;
}

function test(value) {
	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
	var data = new L5.Map();
	if (cxsj_q != '') {
		data.put("cxsjq", cxsj_q);
	}
	if (cxsj_z != '') {
		data.put("cxsjz", cxsj_z);
	}
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/bpt/query/youDaiJinStandard/query_YouDaiJin.jsp";
	L5.forward(url, null, data);
}
