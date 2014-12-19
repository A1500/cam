function init(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.load();
}
function query(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var areaLevel=document.getElementById("areaLevel").value;
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var manaLevel=document.getElementById("manaLevel").value;
	var legelPeople=document.getElementById("legelPeople").value;
	var startMonth=document.getElementById("startMonth").value;
	var endMonth=document.getElementById("endMonth").value;
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.setParameter("AREA_LEVEL@=",areaLevel);
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_NAME@=",gerocomiumName);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE>",startMonth);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE<",endMonth);
	samGerocomiumInfoDataSet.setParameter("MANA_LEVEL@=",manaLevel);
	samGerocomiumInfoDataSet.setParameter("LEGEL_PEOPLE@=",legelPeople);
	samGerocomiumInfoDataSet.load();
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("gerocomiumId",records[0].get("gerocomiumId"));
	var url="jsp/cams/drel/samu/samGerocomiumInfoDetail_list.jsp";
	L5.forward(url,'',data);
}
function detailAll(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var gerocomiumId=records[0].get("gerocomiumId");
	var width = screen.width-200;
		    var height = screen.height/2-50;
	 var url="samGerocomiumInfoHisList.jsp?gerocomiumId="+gerocomiumId;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
// 弹出本地的行政区划
function func_ForAreaSelect() {
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("areaLevelId").value = list[0];
		document.getElementById("areaLevel").value = list[1];
	}
}
// 弹出主管
function func_ForManaSelect() {
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
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