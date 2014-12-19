var ifQuery = false;
function init(){
	if(organLevel=='SQ'){
		document.getElementById("sq").style.display = "";
		document.getElementById("other").style.display = "none";
	}else if(organLevel=='JD' ){
		document.getElementById("sq").style.display = "none";
		document.getElementById("other").style.display = "";
		document.getElementById("xzqh1").style.display = "";
		document.getElementById("xzqh2").style.display = "none";
		var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
		OrgCodeDataset.setParameter("filterSql","organ_id = '"+organCode+"'");
		OrgCodeDataset.load();
		document.getElementById("xzqh4").style.display = "";
	}else {
		document.getElementById("sq").style.display = "none";
		document.getElementById("other").style.display = "";
		document.getElementById("xzqh1").style.display = "";
		document.getElementById("xzqh2").style.display = "";
		document.getElementById("xzqh4").style.display = "none";
	}
	var cdcMailListDataSet=L5.DatasetMgr.lookup("cdcMailListDataSet");
	cdcMailListDataSet.setParameter("code",organCode);
	cdcMailListDataSet.load();
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
	var cdcMailListDataSet = L5.DatasetMgr.lookup("cdcMailListDataSet");
	cdcMailListDataSet.setParameter("name",_$("name"));
	cdcMailListDataSet.setParameter("organ",_$("organ"));
	cdcMailListDataSet.setParameter("dept",_$("dept"));
	cdcMailListDataSet.setParameter("organCode",organC);
	cdcMailListDataSet.load();
}
function selfQuery(){
	var cdcMailListDataSet = L5.DatasetMgr.lookup("cdcMailListDataSet");
	cdcMailListDataSet.setParameter("code",organCode);
	cdcMailListDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/maillist/cdcMailListEdit.jsp";
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
		L5.Msg.alert("提示","只能修改本单位填写的通讯录！");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("listId",records[0].get("LISTID"));
	var url="jsp/ext/cdc/manage/maillist/cdcMailListEdit.jsp";
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
		L5.Msg.alert("提示","只能删除本单位填写的通讯录！");
		return;
	}
	L5.MessageBox.confirm("提示", "确定删除该人通讯录？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcMailListCmd");
			command.setParameter("listId",records[0].get("LISTID"));
			command.execute("delete");
			if(!command.error){
				L5.Msg.alert("提示","删除成功！");
					var cdcMailListDataSet=L5.DatasetMgr.lookup("cdcMailListDataSet");
					cdcMailListDataSet.reload();
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
	data.put("listId",records[0].get("LISTID"));
	var url="jsp/ext/cdc/manage/maillist/cdcMailListDetail.jsp";
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