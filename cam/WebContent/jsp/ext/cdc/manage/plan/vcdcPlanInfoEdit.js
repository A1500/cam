var  orgCode ;
function init(){
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var planDataSet=L5.DatasetMgr.lookup("planDataSet");
	if(method=="insert"){
		OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
		OrgCodeDataset.load();
		OrgCodeDataset.on("load",function() {
			orgCode = OrgCodeDataset.get("text");
			if(organLevel=='JD'){
				organCode= orgCode.substring(0,9)+"000";
			}
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
			if(organLevel=='JD'){
				planDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", organCode);
			}else{
				planDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", orgCode);
			}
			reportWorkDataSet.load();
			});
	}else{
		$("reportDate").disabled=true;
		document.getElementById("backInsert").style.display = "none";
		planDataSet.setParameter("PLAN_ID@=",recordId);
		planDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var planDataSet=L5.DatasetMgr.lookup("planDataSet");
	planDataSet.removeAll();
	if(organLevel=='JD'){
		planDataSet.setParameter("ORGAN_CODE@=", organCode);
	}else{
		planDataSet.setParameter("ORGAN_CODE@=", orgCode);
	}
	planDataSet.setParameter("sort","CREATE_TIME");	
	planDataSet.setParameter("dir","desc");
	planDataSet.load();
	planDataSet.on("load",function(){
		if (planDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				if(organLevel=='JD'){
					planDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", organCode);
				}else{
					planDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", orgCode);
				}
				});
		}
	});
	
}
function save(){
	if(document.getElementById('planNum').value == ''){
	 	L5.Msg.alert("提示","规划社区数量不能为空!");
	 	return false;
	}
	if(document.getElementById('completeNum').value == ''){
	 	L5.Msg.alert("提示","规划建设完成社区数量不能为空!");
	 	return false;
	}
	if(document.getElementById('yearCompleteNum').value == ''){
	 	L5.Msg.alert("提示","本年度建设完成社区数量不能为空!");
	 	return false;
	}
	var planDataSet=L5.DatasetMgr.lookup("planDataSet");
	var isValidate = planDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=planDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPlanInfoCmd");
	command.setParameter("record",record);
	command.setForm("form1");
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/plan/vcdcPlanInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}