function init(){
	var ds = L5.DatasetMgr.lookup("ds"); 
	ds.setParameter("xzqu", organCode);
	ds.load();
	L5.QuickTips.init();
}

function query(){
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

/**
 * 导出excel
 */
function emport() {
	var excelDs = L5.DatasetMgr.lookup("excelDs");
	var deptId = document.getElementById("deptId").value;//所属民政部门
	var selId;
    if(deptId==''){
    	selId = organCode;
	}else{
		selId = deptId;
	}
	excelDs.setParameter("xzqu", selId);
	excelDs.load();
	excelDs.on("load",function() {
		L5.dataset2excel(excelDs,"/jsp/cams/marry/query/dept/mrmRegisOrganEmportExcel.jsp");
	});
}

 //所属部门
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var organName = "山东省";
	//alert(encodeURIComponent(organName));
//	var organCode="370000000000";
	//var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	var revalue=window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+organCode+"&organName="+encodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	//var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+organCode+"&organName=根节点","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("deptId").value = list[0];
		document.getElementById("deptname").value = list[1];
	}
}
function initTime(){
	document.getElementById("deptName").value = "";
	document.getElementById("deptId").value = "";
}