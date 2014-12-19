/*
 * 初始化
 */
function init(){
	
	var moduleInput = document.getElementById("moduleCode");
	
	if(method === "INSERT"){//新增
		moduleInput.disabled = false;
		helpModuleDs.newRecord({"isLocal":isLocal});
		helpUrlDs.setParameter("HELP_URLS.MODULE_CODE@is", "NULL");
		helpUrlDs.load();
	}else if (method === "UPDATE"){//修改
		moduleInput.disabled = "disabled";
		if(idField){
			helpModuleDs.setParameter("HELP_MODULES.MODULE_CODE@=", idField);
			helpModuleDs.load();
			helpUrlDs.setParameter("HELP_URLS.MODULE_CODE@=", idField);
			helpUrlDs.load();
		}else{
			return;
		}
	} else{
		L5.Msg.alert(RES_PROMOT,RES_UNKOWN_CMD);
		return;
	}

	L5.QuickTips.init();
}

/*
 * 已经保存在数据库中的url编码不能修改
 */
function isNewUrl(){
	var state = helpUrlDs.getCurrent().state;
	if(state==L5.model.Record.STATE_NEW)
		return true;
	else 
		return false;
}

/*
 * 设置状态
 */
function setState(userRecord){
	var isSys = document.getElementById("isSys");
	if(isSys.checked){
		userRecord.set("isSys","1");
	}else{
		userRecord.set("isSys","0");
	}
	var isUseIP = document.getElementById("isUseIP");
	if(isUseIP.checked){
		userRecord.set("isUseIP","1");
	}else{
		userRecord.set("isUseIP","0");
	}
}

/*
 * 远程通用帮助需要校验模块的uri等信息
 */
function validate_remote(args){
	var value = args[0];
	var record = args[1]
	if(record.get("isLocal") === "1") {
		return true;
	}
		
	if (value === null || value === "") {
		return "不能为空";
	} else {
		if (typeof value == 'string' && value.trim() === "")
			return "不能为空";
		return true;
	}
}

/*
 * 点击保存按钮
 */
function save_click(){
	var moduleValid = helpModuleDs.isValidate();
	var urlValid = helpUrlDs.isValidate();
	if(moduleValid !== true || urlValid !== true){
		L5.MessageBox.alert(RES_PROMOT, (moduleValid !== true? moduleValid : urlValid));
//		L5.MessageBox.alert(RES_PROMOT, moduleValid + urlValid);
		return;
	}
	
	var command = new L5.Command("org.loushang.util.help.cmd.HelpUrlCommand");
	var moduleRecord = helpModuleDs.getCurrent();
	var urlRecords = helpUrlDs.getAllChangedRecords();
    for(var i=0;i<urlRecords.length;i++){
    	var helpCodei=urlRecords[i].get("helpCode");
    	for(var j=i+1;j<urlRecords.length;j++){
    		var helpCodej=urlRecords[j].get("helpCode");
    		if(helpCodei==helpCodej){
    			L5.MessageBox.alert(RES_PROMOT,HELP_SAME_URL_CODE);
    			return;
    		}
    	}
    }
	command.setParameter("moduleRecord",moduleRecord);
	command.setParameter("urlRecords",urlRecords);
	
	command.execute("saveModule");
	if (!command.error) {
		helpModuleDs.commitChanges();
		helpUrlDs.commitChanges();
		L5.MessageBox.alert(RES_PROMOT,RES_SAVE);
	}else{
		L5.MessageBox.alert(RES_PROMOT,command.error);
	}
}

/*
 * 点击取消按钮
 */
function undo_click(){
	helpModuleDs.rejectChanges();
	helpUrlDs.rejectChanges();
	if(method === "INSERT"){//新增
		helpModuleDs.newRecord({"isLocal":isLocal});
	}
}

//新增一条URL
function addUrl(){
	if(!helpModuleDs.getCurrent().get("moduleCode")){
		L5.Msg.alert("提示", REQUIRE_MODULECODE);
		return;
	}
	helpUrlDs.newRecord({"moduleCode":helpModuleDs.getCurrent().get("moduleCode"),
		"moduleName":helpModuleDs.getCurrent().get("moduleName")});
}

//删除一条URL,逻辑删除
function removeUrl(){
	var record = helpUrlDs.getCurrent();
	if(!record){
		L5.Msg.alert(RES_PROMOT, selectdel);
		return;
	}
	helpUrlDs.remove(record);
}

function ret_click(){
	var url = 'jsp/public/help/helpurl_list.jsp';
	L5.forward(url, HELP_LIST);
}
