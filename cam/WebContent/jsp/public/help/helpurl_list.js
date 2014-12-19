function init() {
	helpModuleDs.load();
	helpUrlDs.setParameter("HELP_URLS.MODULE_CODE@is", "NULL");
	helpUrlDs.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	return value;
}

function query(){
	helpModuleDs.setParameter("HELP_MODULES.MODULE_NAME@LIKE", getParam("moduleName"));
	helpModuleDs.setParameter("HELP_MODULES.ISLOCAL@=", getParam("isLocal"));
	
	helpModuleDs.load();
	helpUrlDs.removeAll();
}

function queryUrls(){
	var modulecode = L5.getCmp('helpModuleGrid').getSelectionModel().getSelections()[0].get("moduleCode");
	
	helpUrlDs.setParameter("HELP_URLS.MODULE_CODE@=",modulecode);
	helpUrlDs.load();
}

function addLocal() {
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("isLocal", "1");
	var url='jsp/public/help/helpurl_edit.jsp';
	L5.forward(url,addLocalText,data);
}

function addRemote() {
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("isLocal", "0");
	var url='jsp/public/help/helpurl_edit.jsp';
	L5.forward(url,addRemoteText,data);

}

function update(){
	var grid=L5.getCmp('helpModuleGrid');
	var selected=grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert(alerttitle,selectone);
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("isLocal", selected[0].get("isLocal"));
	data.put("moduleCode",selected[0].get("moduleCode"));
	var url='jsp/public/help/helpurl_edit.jsp';
	L5.forward(url,updatetext,data);
}

function del(){
	var grid=L5.getCmp('helpModuleGrid');
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert(alerttitle,selectdel);
		return false;
	}
	
	L5.MessageBox.confirm(alerttitle, confirm,function(state){
		if(state=="yes"){
			var command=new L5.Command("org.loushang.util.help.cmd.HelpUrlCommand");
			command.setParameter("delCode", selected[0].get("moduleCode"));
			command.execute("deleteHelpModule");
			if (!command.error) {
				helpModuleDs.remove(selected[0]);
				helpModuleDs.commitChanges();
				helpUrlDs.removeAll();
				helpUrlDs.commitChanges();
			}else{
				L5.Msg.alert(alerttitle,command.error);
			}
		}else{
			return false;
		}
	});
}

function chengeText(value){
	if(value === "1"){
		return yesText;
	} else {
		return noText;
	}
}

