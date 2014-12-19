function init(){
	//迁入信息word重复打开
	L5.getCmp("demobiInPrintPanel").on("activate",demoInPrtRpt);
}

//迁入信息word重复打开
function demoInPrtRpt(){
	var src = document.getElementById("demobiInPrintFrm").src;
	document.getElementById("demobiInPrintFrm").src = src;
}

