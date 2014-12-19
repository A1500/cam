function init() {
	ds.setParameter("xzqu", xzqu);
	ds.load();
	L5.QuickTips.init();
}

function back() {
	history.go(-1);
}


function queryNextLevel(value){
	var xzqh = value.nextSibling.innerHTML;
	if(xzqu==xzqh){
		return;
	}
	var data = new L5.Map();
	data.put("xzqu",xzqh)
	var url = "jsp/cams/marry/query/dept/resource/organResourceNextLevel.jsp";
	L5.forward(url, null, data);
}
function forExcel(){
	L5.dataset2excel(ds, "/jsp/cams/marry/query/dept/resource/exportOrganResource.jsp");
}