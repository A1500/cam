function init(){
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
 	ProvinceMigrationDataSet.setParameter("APPLY_ID",applyId);
 	ProvinceMigrationDataSet.load();
	L5.QuickTips.init();
}
function save(){
	//校验迁入地民政局是否为空
	var ingoingAddress = _$("ingoingName");
	if(ingoingAddress==''){
		L5.Msg.alert('提示',"迁入地民政局不能为空!");
		return false;
	}
	//校验残疾抚恤金已发至是否为空
	var recordMigration = ProvinceMigrationDataSet.getCurrent();
		allowanceMonth = recordMigration.get("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"残疾抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","退伍时间格式不正确！");
		return false;
	}
	var domicode = _$("domicileCode");
	if(domicode == '') {
		L5.Msg.alert('提示',"户口薄(行政区划)不能为空!");
		return false;
	}
	
	var apanageCode = _$("apanageCode");
	if(apanageCode == '') {
		L5.Msg.alert('提示',"实际居住(行政区划)不能为空!");
		return false;
	}
	
	var record=ProvinceMigrationDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", record);
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

 
function func_ForDomicileSelect(){
		var ingoingCode = _$("ingoingCode");
		var ingoingName = _$("ingoingName");
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?organCode=370000000000&organName=山东省","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 ProvinceMigrationDataSet.getCurrent().set("ingoingCode",list[0]);
			 ProvinceMigrationDataSet.getCurrent().set("ingoingName",list[1]);
		}
}