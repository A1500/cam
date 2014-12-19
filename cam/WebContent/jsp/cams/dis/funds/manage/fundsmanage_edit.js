function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord({"disYear":year,"allocationStatus":"0","receiveStatus":"1"});
	}
	else if (method=="UPDATE"){
		ds.baseParams["ID@="]=idField;
		ds.load();
		ds.on("load",function(){
			//解析上级下拨资金用途字段，给页面赋值
			var purpose = ds.get("upAllocationPurpose");
			var nameArr = purpose.split(",");
			var name = "";
			for(var i = 0;i<nameArr.length;i++){
				var records = allocationPurposeSelect.query("value",nameArr[i]);
				if(i == nameArr.length-1){
					name+= records.items[0].get("text");
				}else{
					name+= records.items[0].get("text")+",";
				}
			}
			document.getElementById("upAllocationPurposeName").value = name;
		});
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function provinceSave(){
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCommand"); 
	command.setParameter("record",record);
	if (method=="INSERT"){
		command.execute("provinceSave");	
	}
	if (method=="UPDATE"){
		command.execute("update");	
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/dis/funds/manage/fundsmanage_list.jsp';
		var text = 'DIS_FUNDS_SOURCE';
		L5.forward(url,text);	 
 }


function pickType(){
	pickTypeInfo("upAllocationPurposeName","upAllocationPurpose");
}

function removeType(){
	removeTypeInfo("upAllocationPurposeName","upAllocationPurpose");
}
