function init(){
	//迁入信息word重复打开
	L5.getCmp("intoPrintPanel").on("activate",demoIllInPrtRpt);
}

//迁入信息word重复打开
function demoIllInPrtRpt(){
	var src = document.getElementById("intoPrint").src;
	document.getElementById("intoPrint").src = src;
}
