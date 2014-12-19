function init(){
 if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		returnClick();
	}
 if (method == "UPDATE"){
    PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    PeopleDemobilizedDataset.load();
 }else{
   
 }
}
function saveClick(){
    var ds=L5.DatasetMgr.lookup("PeopleDemobilizedDataset");
	var record = ds.getCurrent();
	var valid = ds.isValidate(true);
	if(valid !== true){
		alert("校验未通过，不能保存！"+valid);
		return false;
	}
	
	var conscriptDate = record.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示","入伍时间格式不正确！");
		return false;
	}
	
	var decruitmentDate = record.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示","复员时间格式不正确！");
		return false;
	}
	
	var approvalDate = record.get("approvalDate");
	if(approvalDate!=''&&!validateDateFormat(approvalDate)){
		L5.Msg.alert("提示","批准日期格式不正确！");
		return false;
	}
	
	var cancellationDate = record.get("cancellationDate");
	if(cancellationDate!=''&&!validateDateFormat(cancellationDate)){
		L5.Msg.alert("提示","注销日期格式不正确！");
		return false;
	}
	
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand"); 
	command.setParameter("PeopleDemobilizedRecord",ds.getCurrent());
	command.execute("update");	
	
   if (!command.error) {
		L5.Msg.alert('提示', '保存成功！');
		returnClick();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function returnClick(){
    var url = 'jsp/cams/bpt/demobilized/demobilizedList.jsp';
	var text = '基础信息_人员信息';
	L5.forward(url, text);
}