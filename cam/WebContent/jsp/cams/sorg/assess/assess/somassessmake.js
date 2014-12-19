function init() {
		ds.load();
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
	if(method == "INSERT"){
		command.execute("insert");
	}
	if(method == "UPDATE"){
		command.execute("update");
	}	
	if (!command.error) {
		var data = new L5.Map();
		data.put("assessType",assessType);
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



