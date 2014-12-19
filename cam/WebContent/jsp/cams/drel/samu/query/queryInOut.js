function init(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");	
	samGeroKeptPersonDataSet.setParameter("areaLevelId",organCode);
	samGeroKeptPersonDataSet.load();
}
function query(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var gerocomiumName=document.getElementById("gerocomiumName").value;	
	var personName=document.getElementById("personName").value;	
	var idCard=document.getElementById("idCard").value;	
	var inRoom=document.getElementById("inRoom").value;	
	var manaLevel=document.getElementById("manaLevel").value;
	var isStatus=document.getElementById("isStatus").value;
	var startInDate=document.getElementById("startInDate").value;	
	var endInDate=document.getElementById("endInDate").value;	
	var startOutDate=document.getElementById("startOutDate").value;
	var endOutDate=document.getElementById("endOutDate").value;
	samGeroKeptPersonDataSet.setParameter("gerocomiumName",gerocomiumName);
	samGeroKeptPersonDataSet.setParameter("personName",personName);	
	samGeroKeptPersonDataSet.setParameter("idCard",idCard);	
	samGeroKeptPersonDataSet.setParameter("inRoom",inRoom);	
	samGeroKeptPersonDataSet.setParameter("manaLevel",manaLevel);	
	samGeroKeptPersonDataSet.setParameter("isStatus",isStatus);	
	samGeroKeptPersonDataSet.setParameter("startInDate",startInDate);	
	samGeroKeptPersonDataSet.setParameter("endInDate",endInDate);	
	samGeroKeptPersonDataSet.setParameter("startOutDate",startOutDate);	
	samGeroKeptPersonDataSet.setParameter("endOutDate",endOutDate);	
	samGeroKeptPersonDataSet.setParameter("areaLevelId@like",organCode);	
	samGeroKeptPersonDataSet.load();
}
// 弹出主管
function func_ForManaSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("manaLevelId").value = list[0];
		document.getElementById("manaLevel").value = list[1];
	}
}
//弹出敬老院
function func_ForGeroSelect(){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/drel/samu/geroTree/geroTree.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("gerocomiumId").value = list[0];
		document.getElementById("gerocomiumName").value = list[1];
	}
}