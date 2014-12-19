function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
	
		ds.newRecord({
		   disasterId:disasterId,
		   regPeople:regPeopleName,
		   regOrgan:regOrganName,
		   regTime:regTime
		});
	}
	else if (method=="UPDATE"){
		ds.baseParams["DISASTER_ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
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
    var records = ds.getAllChangedRecords();
	var command=new L5.Command("com.inspur.sdmz.disasterInfo.cmd.DisasterInfoCommand"); 
	command.setParameter("records",records);
	command.setParameter("method",method);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/sdmz/disasterInfo/disasterinfo_list.jsp';
		var text = '灾情信息';
		L5.forward(url,text);	 
 }



