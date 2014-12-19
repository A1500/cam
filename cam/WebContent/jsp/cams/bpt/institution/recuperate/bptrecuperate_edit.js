function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
		ds.set("domicileName",orgName);
		ds.set("domicileCode",orgCode);
		ds.set("id",newid);
		ds.set("peopleCount",0);
		ds.set("year",getCurDate().substr(0,4));
	}
	else if (method=="UPDATE"){
		ds.baseParams["ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		window.close();	
	}
	L5.QuickTips.init(); 
}

function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var record = ds.getCurrent();
    var time = record.get("createTime");
   if(!validateDateFormat(time)){
		L5.Msg.alert("提示", "编制时间格式不正确,不能保存!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateCommand"); 
	command.setParameter("record",record);
	if(method=="INSERT"){
		command.execute("insert");	
	}else if (method=="UPDATE"){
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			window.close();	
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function func_Close(){	
	window.close();	
}



