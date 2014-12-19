var ifQuery = false;
function init(){
	if(organLevel=='SQ'){
		document.getElementById("sqcx").style.display = "";
		document.getElementById("jdcx").style.display = "none";
		document.getElementById("qtcx").style.display = "none";
	}else if(organLevel=='JD' ){
		document.getElementById("sqcx").style.display = "none";
		document.getElementById("jdcx").style.display = "";
		document.getElementById("qtcx").style.display = "none";
		var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
		OrgCodeDataset.setParameter("filterSql","organ_id = '"+organCode+"'");
		OrgCodeDataset.load();
	}else {
		document.getElementById("sqcx").style.display = "none";
		document.getElementById("jdcx").style.display = "none";
		document.getElementById("qtcx").style.display = "";
	}
	var cdcWorkInfoDataSet=L5.DatasetMgr.lookup("cdcWorkInfoDataSet");
	cdcWorkInfoDataSet.setParameter("code",organCode);
	cdcWorkInfoDataSet.setParameter("type","1");
	cdcWorkInfoDataSet.load();
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
	if(organLevel=='JD' ){
		var SQdomicileCode = document.getElementById("SQdomicileCode").value;
		if(SQdomicileCode!=""){organC =SQdomicileCode;}
	}else if(organLevel!='SQ' ){
		var domicileCode = document.getElementById("domicileCode").value;
		var leve = document.getElementById("leve").value;
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
	}
	var cdcWorkInfoDataSet = L5.DatasetMgr.lookup("cdcWorkInfoDataSet");
	cdcWorkInfoDataSet.setParameter("name",_$("name"));
	cdcWorkInfoDataSet.setParameter("reportDate",_$("reportDate"));
	cdcWorkInfoDataSet.setParameter("organCode",organC);
	cdcWorkInfoDataSet.setParameter("type","1");
	cdcWorkInfoDataSet.load();
}
function selfQuery(){
	var cdcWorkInfoDataSet = L5.DatasetMgr.lookup("cdcWorkInfoDataSet");
	cdcWorkInfoDataSet.setParameter("code",organCode);
	cdcWorkInfoDataSet.setParameter("reportDate",_$("reportDate"));
	cdcWorkInfoDataSet.setParameter("type","1");
	cdcWorkInfoDataSet.load();
}

function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/workbrief/cdcWorkBriefEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("ORGANCODE")!=organCode){
		L5.Msg.alert("提示","只能修改本单位工作简报！");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("workId",records[0].get("WORKID"));
	var url="jsp/ext/cdc/manage/workbrief/cdcWorkBriefEdit.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("ORGANCODE")!=organCode){
		L5.Msg.alert("提示","只能删除本单位工作简报！");
		return;
	}
	L5.MessageBox.confirm("提示", "确定删除该工作简报？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcWorkInfoCmd");
			command.setParameter("workId",records[0].get("WORKID"));
			command.execute("delete");
			if(!command.error){
				L5.Msg.alert("提示","删除成功！");
					var cdcWorkInfoDataSet=L5.DatasetMgr.lookup("cdcWorkInfoDataSet");
					cdcWorkInfoDataSet.reload();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("workId",records[0].get("WORKID"));
	data.put("fileId",records[0].get("FILEID"));
	var url="jsp/ext/cdc/manage/workbrief/cdcWorkBriefDetail.jsp";
	L5.forward(url,'',data);
}
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