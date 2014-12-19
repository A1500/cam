function init(){
	var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
		decisionDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		decisionDataSet.setParameter("RECORD_ID@=",recordId);
		decisionDataSet.load();
		reportWorkDataSet.load();
	}
}
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > "") 
	{ 
	   var reg=/^\d+$/; 
	   if ( (offOtherMon.match(reg)== null)) 
	    { 
	     L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
		    item.focus();
		    }); 
	    item.value="";
	   
	    return ; 
	    }
}
}
function forInsert(){
	var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	decisionDataSet.removeAll();
	decisionDataSet.setParameter("ORGAN_CODE@=", organCode);
	decisionDataSet.setParameter("sort","CREATE_TIME");	
	decisionDataSet.setParameter("dir","desc");
	decisionDataSet.load();
	decisionDataSet.on("load",function(){
		if (decisionDataSet.getCount()>0){
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				decisionDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
			});
		}
	});
}
function save(){
	if(document.getElementById("reportDate").value==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	if(document.getElementById("meetingNum").value==""){
		L5.Msg.alert("提示","居民会议次数不能为空！");
		return;
	}
	if(document.getElementById("meetingPeopleNum").value==""){
		L5.Msg.alert("提示","居民会议参加人数不能为空！");
		return;
	}
	if(document.getElementById("sovietNum").value==""){
		L5.Msg.alert("提示","居民代表会议次数不能为空！");
		return;
	}
	if(document.getElementById("sovietPeopleNum").value==""){
		L5.Msg.alert("提示","居民代表会议参加人数不能为空！");
		return;
	}
	var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	var isValidate = decisionDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	
	var record=decisionDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcDecisionReportCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/decision/cdcDecisionInfoList.jsp";
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
			var url="jsp/ext/cdc/manage/decision/cdcDecisionInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}