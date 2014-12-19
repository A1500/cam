function init(){
	L5.QuickTips.init();
	
	L5.getCmp("dependantApprove").on("activate",func);
	
}

function func(){  
		var src = document.getElementById("appTable").src;
		document.getElementById("appTable").src=src;
	}