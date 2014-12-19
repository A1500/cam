function init(){
    PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    PeopleDemobilizedDataset.load();
}
function saveClick(){
    var ds=L5.DatasetMgr.lookup("PeopleDemobilizedDataset");
	
	
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	var Record= ds.getCurrent();
	command.setParameter("PeopleDemobilizedRecord",Record);
	command.execute("updateDmeoIntoProvince");	
	var valid = ds.isValidate(true);
	if(valid !== true){
		alert("校验未通过，不能保存！"+valid);
		return false;
	}
	var conscriptDate = Record.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示","入伍时间格式不正确！");
		return false;
	}
	var decruitmentDate = Record.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示","复员时间格式不正确！");
		return false;
	}

   if (!command.error) {
		L5.Msg.alert('提示', '保存成功！');
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_BelongDate(){
  var conscriptDate = PeopleDemobilizedDataset.get("conscriptDate");
  if(conscriptDate !=''){
     if(conscriptDate>='1937-07-07'&&conscriptDate<='1945-09-02'){
         PeopleDemobilizedDataset.set("belongDate",1);
     }else if(conscriptDate>='1945-09-03'&&conscriptDate<='1949-09-30'){
         PeopleDemobilizedDataset.set("belongDate",2);
     }else{
         PeopleDemobilizedDataset.set("belongDate",3);
     }
  }
}
function returnClick(){
   window.close();
}
 function getCodeAndName(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 PeopleDemobilizedDataset.getCurrent().set("ingoingCode",list[0]);
			 PeopleDemobilizedDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}