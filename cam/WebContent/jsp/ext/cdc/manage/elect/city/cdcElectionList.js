var ifQuery = false;
var ifInsert ;
function init(){
	mybuttonControl();
	var organC ;
	if(organLevel=="11"){
		organC =organCode.substring(0,2); 
	}else if(organLevel=="12" ){
		organC =organCode.substring(0,4); 
	}else if(organLevel=="13"){
		organC =organCode.substring(0,6); 
	}else if(organLevel=="JD"){
		organC =organCode.substring(0,9)
	}else{
		organC =organCode;
	}
	var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
	electionInfoDataSet.setParameter("ORGAN_CODE@like",organC);
	electionInfoDataSet.setParameter("REPORT_TYPE@=","C");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionInfoDataSet.load();
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	insertDataSet.on("load",function(){
		ifInsert = false;
		if(insertDataSet.getCount()>=1){
			ifInsert = true;
		}else{
			ifInsert = false;
		}
	});
}
function query(){
	var organC ;
	if(organLevel=="11"){
		organC =organCode.substring(0,2); 
	}else if(organLevel=="12" ){
		organC =organCode.substring(0,4); 
	}else if(organLevel=="13"){
		organC =organCode.substring(0,6); 
	}else if(organLevel=="JD"){
		organC =organCode.substring(0,9)
	}else{
		organC =organCode;
	}
	var domicileCode = document.getElementById("domicileCode").value;
	var leve = document.getElementById("leve").value;
	var electionInfoDataSet = L5.DatasetMgr.lookup("electionInfoDataSet");
	electionInfoDataSet.setParameter("STATUS@=",_$("status"));
	electionInfoDataSet.setParameter("REPORT_TYPE@=","C");
	electionInfoDataSet.setParameter("REPORT_DATE@=",_$("reportDate"));
	if(domicileCode!=""){
		if(leve =="3"){
			if(domicileCode.substring(4)=="00999000"){
				organC =domicileCode.substring(0,4); 
			}else if(domicileCode.substring(6)=="999000"){
				organC =domicileCode.substring(0,6); 
			}else{
				organC =domicileCode.substring(0,9);
			}
		}else if(leve =="4" ) {
			organC =domicileCode;
		}
	}
	electionInfoDataSet.setParameter("ORGAN_CODE@like",organC);
	electionInfoDataSet.load();	
}
function insert(){
var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	if(ifInsert){
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/elect/city/cdcElectionInfoEdit.jsp";
		L5.forward(url,'',data);
	}else{
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/elect/city/cdcElectionInfoEdit.jsp";
		L5.forward(url,'',data);
		//L5.Msg.alert("提示","暂无本项填报任务!");
	}
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("ifElection")=="0"){
		L5.Msg.alert("提示","未参加换届选举，不用填报数据!");
		return;
	}
	/*if(records[0].get("ifComplete")=="1"){
		L5.Msg.alert("提示","已完成换届选举，不能修改数据!");
		return;
	}*/
	var data=new L5.Map();
	data.put("reportTime",records[0].get("reportDate"));
	data.put("recordId",records[0].get("recordId"));
	data.put("method","update");
	var url="jsp/ext/cdc/manage/elect/city/cdcElectionEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("recordId",records[0].get("recordId"));
	var url="jsp/ext/cdc/manage/elect/city/cdcElectionDetail.jsp";
	L5.forward(url,'',data);
}

/*
*从数据库dic_city中查询organName
*/
function queryOrganName() {
	if(!ifQuery) {
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}	
}
function updateInfo(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")=="1"){
		L5.Msg.alert("提示","已经上报，不允许修改!");
		return;
	}
	var data=new L5.Map();
	data.put("recordId",records[0].get("recordId"));
	data.put("method","update");
	var url="jsp/ext/cdc/manage/elect/city/cdcElectionInfoEdit.jsp";
	L5.forward(url,'',data);
}


/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {

	queryOrganName();
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[4];
		document.getElementById("leve").value = list[2];
		document.getElementById("domicileCode").value = list[0];
	}
}

function mybuttonControl(){
	if(organLevel=='JD' ||organLevel=='SQ'){
		document.getElementById("xzqh1").style.display = "none";
		document.getElementById("xzqh2").style.display = "none";
	}else{
		document.getElementById("xzqh1").style.display = "";
		document.getElementById("xzqh2").style.display = "";
	}
	if(organLevel=="SQ"){
		$("sum").style.display="none";
	}else{
		$("detail1").style.display="none";
		$("detail2").style.display="none";
		$("detail3").style.display="none";
	}
}

function sum(){
	var data=new L5.Map();
	var url = "jsp/ext/cdc/manage/elect/detail/cdcElectionEdit.jsp";
	L5.forward(url,'',data);
}


function returnBack(){
	history.go(-1);
}