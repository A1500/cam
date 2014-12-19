function init(){
	var DependantEmigratDataset = L5.DatasetMgr.lookup("DependantEmigratDataset");
 	DependantEmigratDataset.setParameter("APPLY_ID",applyId);
 	DependantEmigratDataset.load();
	L5.QuickTips.init();
}

function save(){
	var DependantEmigratDataset = L5.DatasetMgr.lookup("DependantEmigratDataset");
	var record=DependantEmigratDataset.getCurrent();
	//校验迁入地民政局是否为空
	var ingoingAddress = _$("ingoingAddress");
	if(ingoingAddress==''){
		L5.Msg.alert('提示',"迁入地民政局不能为空!");
		return false;
	}
	//校验残疾抚恤金已发至是否为空
	var allowanceMonth = _$("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"残疾抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","抚恤金已发至格式不正确！");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", record);
	command.setParameter("applyId",applyId);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){
	window.close();
}
 function getCodeAndName(){

		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 DependantEmigratDataset.getCurrent().set("ingoingCode",list[0]);
			 DependantEmigratDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}
 

