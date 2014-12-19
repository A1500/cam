function init() {
   if(method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}else if (method=="INSERT"){
		ds.setParameter("counties",organCode);
	    ds.load();
	}else if (method=="UPDATE"){
	    ds.baseParams["STANDARDS_COUNTIES@="]=standardsCounties;
		ds.baseParams["START_DATE@="]=startDate;
		ds.baseParams["END_DATE@="]=endDate;
		ds.load();
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
};

function save() {
   var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalstaCommand");
   var records = ds.getAllRecords();
   var startDate = document.getElementById("startDate").value;
   if(startDate==""){
       L5.Msg.alert('提示','请输入生效日期起!');
	   return false;
    }
    
    if(startDate!=''&&!validateDateFormat(startDate)){
		L5.Msg.alert("提示","生效日期（起）格式不正确！");
		return false;
	}
    var newDate =new Date(document.getElementById("startDate").value.replace("-","/"));
    command.setParameter("organCode", organCode);
    command.setParameter("type", "4");
    command.execute("getMaxDate");
    if(command.getReturn("maxDate")!=undefined){
       var oldMax =new Date(command.getReturn("maxDate").replace("-","/"));
       if(newDate<=oldMax){
          L5.Msg.alert('提示','请输入大于'+oldMax+'日期!');
	      return false;
       }
    }
    if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	command.setParameter("standardsCounties", organCode);
	command.setParameter("startDate", document.getElementById("startDate").value);
	command.setParameter("records", records);
	command.execute("addStandardData");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function back(){	 	
	history.go(-1);
 }