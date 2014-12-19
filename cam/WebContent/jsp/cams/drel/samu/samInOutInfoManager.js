function init(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	samGeroKeptPersonDataSet.load();
}
function query(){
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	var gerocomiumName=document.getElementById("gerocomiumName").value;	
	var personName=document.getElementById("personName").value;	
	var idCard=document.getElementById("idCard").value;	
	var inRoom=document.getElementById("inRoom").value;	
	var inBed=document.getElementById("inBed").value;
	samGeroKeptPersonDataSet.setParameter("GEROCOMIUM_NAME@=",gerocomiumName);
	samGeroKeptPersonDataSet.setParameter("PERSON_NAME@=",personName);	
	samGeroKeptPersonDataSet.setParameter("ID_CARD@=",idCard);	
	samGeroKeptPersonDataSet.setParameter("IN_ROOM@=",inRoom);	
	samGeroKeptPersonDataSet.setParameter("IN_BED@=",inBed);		
	samGeroKeptPersonDataSet.load();
}
function insert(){
	var method="insert";
	var width = 900;
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
	var isStatus=records[0].get("isStatus");
	if(isStatus=="0"){
		L5.Msg.alert("提示","此人已经出院！");
		return;
	}
	var personId=records[0].get("personId");
	var width = 900;
	var height = 400;
	var url="samOutGero.jsp?personId="+personId;
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}