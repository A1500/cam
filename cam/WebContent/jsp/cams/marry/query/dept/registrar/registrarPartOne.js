function init() {
	ds.setParameter("xzqu", organCode);
	ds.load();
	ds.on("load",function(){
		showDiv();
	});
	L5.QuickTips.init();
}

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}
function query() {
	ds.setParameter("xzqu", organCode);
	ds.load();
	noReclick(ds,'queryButton');
}

function back() {
	history.go(-1);
}
function queryNextLevel(value){
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu==organCode){
		return;
	}
	var data = new L5.Map();
	data.put("xzqu",xzqu)
	var url = "jsp/cams/marry/query/dept/registrar/registrarPartOneNext.jsp";
	L5.forward(url, null, data);
}
 
function forExcel(){
	//L5.dataset2excel(ds, "/jsp/cams/marry/query/dept/resource/exportOrganResource.jsp");
}
