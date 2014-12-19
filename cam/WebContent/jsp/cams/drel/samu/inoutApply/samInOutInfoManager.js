function init(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	samGeroKeptPersonDataSet.setParameter("isStatus","1");	
	samGeroKeptPersonDataSet.setParameter("areaLevelId",organCode);	
	samGeroKeptPersonDataSet.load();
}
function query(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var gerocomiumName=document.getElementById("gerocomiumName").value;	
	var personName=document.getElementById("personName").value;	
	var idCard=document.getElementById("idCard").value;	
	var inRoom=document.getElementById("inRoom").value;	
	var inBed=document.getElementById("inBed").value;
	var manaLevel=document.getElementById("manaLevel").value;
	var isStatus=document.getElementById("isStatus").value;
	samGeroKeptPersonDataSet.setParameter("gerocomiumName",gerocomiumName);
	samGeroKeptPersonDataSet.setParameter("personName",personName);	
	samGeroKeptPersonDataSet.setParameter("idCard",idCard);	
	samGeroKeptPersonDataSet.setParameter("inRoom",inRoom);	
	samGeroKeptPersonDataSet.setParameter("inBed",inBed);
	samGeroKeptPersonDataSet.setParameter("manaLevel",manaLevel);	
	samGeroKeptPersonDataSet.setParameter("isStatus",isStatus);	
	samGeroKeptPersonDataSet.setParameter("areaLevelId",organCode);		
	samGeroKeptPersonDataSet.load();
}
function insert(){
	var method="insert";
	var width = 1100;
	var height = 400;
	var url="samInInsert.jsp?method="+method;
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
function outGero(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var isStatus=records[0].get("IS_STATUS");
	if(isStatus=="0"){
		L5.Msg.alert("提示","此人已经出院！");
		return;
	}
	var personId=records[0].get("PERSON_ID");
	var gerocomiumName=records[0].get("GEROCOMIUM_NAME");
	var width = 900;
	var height = 400;
	var url="samOutGero.jsp?personId="+personId+"&gerocomiumName="+gerocomiumName;
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
function editInGero(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var isStatus=records[0].get("IS_STATUS");
	if(isStatus=="0"){
		L5.Msg.alert("提示","此人已经出院！");
		return;
	}
	var personId=records[0].get("PERSON_ID");
	var gerocomiumName=records[0].get("GEROCOMIUM_NAME");
	var width = 900;
	var height = 400;
	var url="samEditInGero.jsp?personId="+personId+"&gerocomiumName="+gerocomiumName;
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
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