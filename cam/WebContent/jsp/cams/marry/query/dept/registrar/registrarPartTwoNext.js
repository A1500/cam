function init() {
	ds.setParameter("xzqu", xzqu);
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

 
function forExcel(){
	//L5.dataset2excel(ds, "/jsp/cams/marry/query/dept/resource/exportOrganResource.jsp");
}
