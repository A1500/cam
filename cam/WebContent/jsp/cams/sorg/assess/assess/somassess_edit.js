function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		var record=ds.newRecord();
		record.set("taskId",taskId);
		record.set("assessType",assessType);
		record.set("sorgCode",sorgCode);
		record.set("sorgType",sorgType);
		record.set("sorgName",sorgName);
		record.set("loginName",loginName);
		record.set("loginOrganId",loginOrganId);
		record.set("areaCode",areaCode);
		record.set("assessDate",assessDate);
	}
	else if (method=="UPDATE"){
		ds.baseParams["TASK_CODE@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var record = ds.getCurrent();
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	var command=new L5.Command("com.inspur.cams.sorg.assess.assess.cmd.SomAssessCommand"); 
	command.setParameter("record",record);
	var taskCode =record.get("taskCode");
	if(method == "INSERT"){
		command.execute("insert");
		taskCode = command.getReturn("taskCode");
	}
	if(method == "UPDATE"){
		command.execute("update");
	}	
	if (!command.error) {
		var data = new L5.Map();
		data.put("assessType",record.get("assessType"));
		data.put("taskCode",taskCode);
		data.put("method",method);
		var url='jsp/cams/sorg/assess/assess/somassessmake.jsp';
		var text = '开始评估打分';
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/sorg/assess/assess/somassess_list.jsp';
		var text = 'SOM_ASSESS';
		L5.forward(url,text);	 
 }
 function back2()
 {	 	var url='jsp/cams/sorg/assess/assess/somassessdetail_list.jsp';
		var text = 'SOM_ASSESS';
		L5.forward(url,text);	 
 }


