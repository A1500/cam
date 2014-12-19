function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("APPLY_ID", idField)
	ds.load();
	if (checkNum == '1') {
		document.getElementById("second").style.display = "none";
		// document.getElementById("an").style.display ="none";
	} else {
		document.getElementById("first").style.display = "none";
	}
	L5.QuickTips.init();
}

function back() {
	history.go(-1);
}
