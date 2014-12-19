
function init() {
		
	L5.QuickTips.init(); 	
	L5.getCmp("testapply").on("activate",func);
}
function func(){  
		var src = document.getElementById("test").src;
		document.getElementById("test").src=src;
}
	

