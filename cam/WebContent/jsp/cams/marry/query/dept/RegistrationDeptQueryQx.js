function init() {
	ds.setParameter("xzqu", xzqu);
	ds.on('load', showDiv);
	ds.load();
	L5.QuickTips.init();
};
	

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}
function forExcel(){
	L5.dataset2excel(ds, "");
}
function back(){
	history.go(-1);
}