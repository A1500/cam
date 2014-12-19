function init() {
	ds.setParameter("xzqu", organCode);
	ds.on('load', showDiv);
	if(selId!='null'){
		ds.setParameter("xzqu", selId);
		ds.load();
	}
	L5.QuickTips.init();
};
	

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}
function initTime(){
	document.getElementById("deptName").value = "";
	document.getElementById("deptId").value = "";
}

function query() {
	var deptname = document.getElementById("deptname").value;//所属民政部门
	var deptId = document.getElementById("deptId").value;//所属民政部门
	var selId;
    if(deptId==''){
    	selId = organCode;
	}else{
		selId = deptId;
	}
	ds.setParameter("xzqu", selId);
	ds.load();
}

function queryNextLevel(value){
	var xzqu = value.nextSibling.innerHTML;
	var deptId = document.getElementById("deptId").value;//所属民政部门
	var deptname = document.getElementById("deptname").value;//所属民政部门
	var selId;
    if(deptId==''){
    	selId = organCode;
	}else{
		selId = deptId;
	}
	if(xzqu==deptId){
		return;
	}
	var data = new L5.Map();
	data.put("xzqu", xzqu);
	data.put("selId", selId);
	data.put("pageflag","1");
	var url = "jsp/cams/marry/person/mrmCertifier_statisticsNext.jsp";
	L5.forward(url, null, data);
}

 
 //所属部门
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var organName = "山东省";
	//var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	var revalue=window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+organCode+"&organName="+escape(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("deptId").value = list[0];
		document.getElementById("deptname").value = list[1];
	}
}
function forExcel(){
	L5.dataset2excel(ds, "/jsp/cams/marry/person/exportCertifier_statistics.jsp");
}