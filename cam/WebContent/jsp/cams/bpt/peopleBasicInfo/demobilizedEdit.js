function init(){
//	document.getElementById("conscriptDate").disabled=true;//入伍时间
//	document.getElementById("decruitmentDate").disabled=true;//复员时间
//	document.getElementById("forcesNo").disabled=true;//原部队番号
//	document.getElementById("belongDate").disabled=true;//属于时期
//	document.getElementById("isKoeanwar").disabled=true;//是否抗美援朝
//	document.getElementById("demobilizedNo").disabled=true;//定期定量补助证编号
//	document.getElementById("approvalDate").disabled=true;//批准日期
//	document.getElementById("asdpNo").disabled=true;//复员证号
//	document.getElementById("demobilizedStateCode").disabled=true;//优抚对象状态
    PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    PeopleDemobilizedDataset.load();
}
function saveClick(){
    var ds=L5.DatasetMgr.lookup("PeopleDemobilizedDataset");

	var valid = ds.isValidate(true);
	if(valid !== true){
		alert("校验未通过，不能保存！"+valid);
		return false;
	}
	var conscriptDate = ds.get("conscriptDate");
	if(!validateDateFormat(conscriptDate))
	{
		 L5.Msg.alert('提示','入伍时间格式不正确！');
		 return false;
	}
	var decruitmentDate = ds.get("decruitmentDate");
	if(!validateDateFormat(decruitmentDate))
	{
		 L5.Msg.alert('提示','复员时间格式不正确！');
		 return false;
	}
	var approvalDate =  ds.get("approvalDate");
	if(!validateDateFormat(approvalDate))
	{
		 L5.Msg.alert('提示','批准时间格式不正确！');
		 return false;
	}
	
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand"); 
	command.setParameter("PeopleDemobilizedRecord",ds.getCurrent());
	command.execute("update");	
	
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
//关闭
function func_Close(){
	window.close();
}