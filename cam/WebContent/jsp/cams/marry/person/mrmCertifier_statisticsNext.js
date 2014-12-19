function init() {
	ds.setParameter("xzqu", xzqu);
	ds.load();
	
	document.getElementById("reDiv").style.display = "";
	L5.QuickTips.init();
	
};


function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("selId", selId);
		var url = "jsp/cams/marry/person/mrmCertifier_statistics.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
}

function queryNextLevel(value){
	var xzqh = value.nextSibling.innerHTML;
	if(xzqh==xzqu){
		return;
	}
	var data = new L5.Map();
	if(pageflag == '1'){
		data.put("xzqu", xzqh);
		data.put("pageflag","2");
		var url = "jsp/cams/marry/person/mrmCertifier_statisticsNext.jsp";
	}else if(pageflag == '2'){
		data.put("xzqu", xzqh.substr(0,8));
		var url = "jsp/cams/marry/person/mrmbasepersonbzydetail.jsp";
	}
		L5.forward(url, null, data);
}

function forExcel(){
	L5.dataset2excel(ds, "/jsp/cams/marry/person/exportCertifier_statistics.jsp");
}