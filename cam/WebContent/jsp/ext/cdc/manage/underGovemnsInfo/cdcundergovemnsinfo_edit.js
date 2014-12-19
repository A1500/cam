function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}else if (method=="INSERT"){
		//ds.newRecord({"villageName":name,"villageCode":idField,"organCode":organCode,"organName":organName});
	}else if (method=="UPDATE"){
		ds.setParameter("VILLAGE_CODE@=",idField);
		ds.load(true);
		if(ds.getCount()<1){
			ds.newRecord({"villageName":userName,"villageCode":idField,"organCode":organCode,"organName":organName});
		}
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcUnderGovemnsInfoCommand"); 
	command.setParameter("record",record);
	if (method=="INSERT"){
		command.execute("insert");	
	}else if (method=="UPDATE"){
		command.execute("save");	
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){back()});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/ext/cdc/manage/underGovemnsInfo/cdcundergovemnsinfo_list.jsp';
		var text = 'CDC_UNDER_GOVEMNS_INFO';
		L5.forward(url,text);	 
 }
//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	 //  var reg=/^\d+(\.\d{2})?$/; 
	   var reg=/[^\d]/g;
	   if ((offOtherMon.match(reg)!= null)){ 
	   L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}
//如是小数，保留到两位
function fordecimalcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}


