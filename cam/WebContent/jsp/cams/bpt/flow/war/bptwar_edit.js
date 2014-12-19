
function init() {

		L5.QuickTips.init(); 
	L5.getCmp("warapply").on("activate",func);
}
function func(){  
		var src = document.getElementById("upload").src;
		document.getElementById("upload").src=src;
}