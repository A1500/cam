function init(){
	L5.QuickTips.init();
	
	L5.getCmp("demobilized_appTabPanel").on("activate",func);
}

function func() {
	var src = document.getElementById("apptable").src;
	document.getElementById("apptable").src=src;
}
