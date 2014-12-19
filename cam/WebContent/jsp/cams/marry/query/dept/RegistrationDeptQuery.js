function init() {
	ds.setParameter("xzqu", organCode);
	ds.on('load', showDiv);
	ds.load();
	L5.QuickTips.init();
};
	

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}
function queryNextLevel(value){
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu==organCode){
		return;
	}
	var data = new L5.Map();
	data.put("xzqu", xzqu);
	var url = "jsp/cams/marry/query/dept/RegistrationDeptQueryQx.jsp";
	L5.forward(url, null, data);
}
function forExcel(){
	L5.dataset2excel(ds, "");
}