function init() {
	var MartyrOffspringDataSet = L5.DatasetMgr.lookup("MartyrOffspringDataSet");
	MartyrOffspringDataSet.setParameter("peopleId",peopleId);
	MartyrOffspringDataSet.load();
	L5.QuickTips.init();
}
 
function saveClick(){
   var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringCommand");
   var MartyrOffspringRecord =　MartyrOffspringDataSet.getCurrent();     
   //验证身份类别
   var statusType = MartyrOffspringDataSet.get("statusType");
   if(statusType==''||statusType==null){
	   	L5.Msg.alert("提示","身份类别不能为空！");
	   	return false;
   }
   //验证牺牲时间
   var sacrificeDate = MartyrOffspringDataSet.get("sacrificeDate");
   if(sacrificeDate==''||sacrificeDate==null){
	   	L5.Msg.alert("提示","牺牲时间不能为空！");
	   	return false;
   }
    if(sacrificeDate!=''&&!validateDateFormat(sacrificeDate)){
		L5.Msg.alert("提示","牺牲时间格式不正确！");
		return false;
	}
   //验证批准烈士（平反）时间
   var lezswApproveDate = MartyrOffspringDataSet.get("lezswApproveDate");
   if(lezswApproveDate==''||lezswApproveDate==null){
	   	L5.Msg.alert("提示","批准烈士（平反）时间不能为空！");
	   	return false;
   }
    if(lezswApproveDate!=''&&!validateDateFormat(lezswApproveDate)){
		L5.Msg.alert("提示","批准烈士（平反）时间格式不正确！");
		return false;
	}
   var isValidate1 = MartyrOffspringDataSet.isValidate();
   if(isValidate1 != true) {
   	   L5.Msg.alert("提示",isValidate1);
   	   return false;
   }
   command.setParameter("MartyrOffspringRecord",MartyrOffspringRecord);
   command.execute("update");
   if(!command.error) {
		L5.Msg.alert('提示',"保存成功！");
		return;
   } else {
       L5.Msg.alert('提示',"保存时出现错误！"+command.error);
       return false;
   }
}

function funClose(){	
	window.close();	
}