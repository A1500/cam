var meetingName = '';
var isMeetingExist = false;
function init(){
	var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
	somElectionDataSet.setParameter("TASK_CODE@=",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load', function(){
		var record=somElectionDataSet.getCurrent();
		meetingName= record.get("meetingName");
		var taskCode=record.get("taskCode");
		somAspchiefDataSet.setParameter("TASK_CODE",taskCode);
		somAspchiefDataSet.load();
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',fillOrganInfo);
	});
	opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
				return record;
			}
		});
	//电子档案
	somElectronicDataSet_load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
}
//somApplyDataSet加载触发的方法
function fillOrganInfo(applyds){
	sorgId = applyds.get("sorgId");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		var cnName = somOrganDataSet.get("cnName");
		somOrganDataSetQuery.setParameter("CN_NAME@=",cnName);
		somOrganDataSetQuery.setParameter("SORG_TYPE@=","S");
		somOrganDataSetQuery.setParameter("SORG_STATUS@in","9,12,22");
		somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
		somOrganDataSetQuery.load();
		somOrganDataSetQuery.on("load",organQueryLoad);
	});
}
//页面社团名称变动触发的方法
function findSorgCode(){
	if(_$("cnName").trim() == ''){
		return;
	}
	somOrganDataSetQuery.setParameter("CN_NAME@=",$("cnName").value.trim());
	somOrganDataSetQuery.setParameter("SORG_TYPE@=","S");
	somOrganDataSetQuery.setParameter("SORG_STATUS@in","9,12,22");
	somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSetQuery.load();
	somOrganDataSetQuery.on("load",organQueryLoad);
}
//somOrganDataSetQuery变动触发的方法
function organQueryLoad(ds){
	ds.un("load",organQueryLoad);
	if(somOrganDataSetQuery.getCount() == 0){
		L5.Msg.alert("提示","根据录入的社会组织名称没有查到相应的社会组织,不能进行换届审批，请确认并修改社会组织名称或登记证号！",function(){
			$("cnName").value = "";
			$("sorgCode").value = "";
			return false;
		});
	}else{
		sorgIdExist = somOrganDataSetQuery.get("sorgId");
//		$("cnName").value = somOrganDataSetQuery.get("cnName");
//		$("sorgCode").value = somOrganDataSet.get("sorgCode");
		//从organ表里取业务主管单位
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = somOrganDataSetQuery.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}
		meetingQuery(); //根据会议名称查询是否已经做过换届
	}
}
//页面社团登记证号变动触发的方法
function checkSorgCode(){
	if(_$("sorgCode").trim() == ''){
		return;
	}
	somOrganDataSetQuery.setParameter("SORG_CODE@=",_$("sorgCode").trim());
	somOrganDataSetQuery.setParameter("SORG_TYPE@=","S");
	somOrganDataSetQuery.setParameter("SORG_STATUS@in","9,22");
	somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSetQuery.load();
	somOrganDataSetQuery.on("load",organQueryLoad);
}
// 增加拟任负责人
function addAspchief(){
	somAspchiefDataSet.newRecord();
}
// 删除拟任负责人
function delAspchief(){
	var record=somAspchiefDataSet.getCurrent();
	if(record!=null)
		somAspchiefDataSet.remove(record);
}
function save(){
	if(_$('cnName') == '' ){
		L5.Msg.alert("提示","请填写社团名称！");
		return;
	}
	if( !isMeetingExist ){
		L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
		return ;
	}
	var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionApplyCmd");
	somElectionRecord.set("sorgId",sorgIdExist);
	somApplyRecord.set("sorgId",sorgIdExist);
	var somAspchiefRecords=somAspchiefDataSet.getAllRecords();
	for(var i=0;i<somAspchiefRecords.length;i++){
		somAspchiefRecords[i].state = L5.model.Record.STATE_NEW;
		somAspchiefRecords[i].set("sorgId",sorgIdExist);
	}
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somAspchiefRecord", somAspchiefRecords);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("create");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			updateOnlineStatusAccept();
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function submit(){
	if(_$('cnName') == '' ){
		L5.Msg.alert("提示","请填写社团名称！");
		return;
	}
	if( !isMeetingExist ){
		L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
		return ;
	}
	var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionApplyCmd");
	somElectionRecord.set("sorgId",sorgIdExist);
	somApplyRecord.set("sorgId",sorgIdExist);
	var somAspchiefRecords=somAspchiefDataSet.getAllRecords();
	for(var i=0;i<somAspchiefRecords.length;i++){
		somAspchiefRecords[i].state = L5.model.Record.STATE_NEW;
		somAspchiefRecords[i].set("sorgId",sorgIdExist);
	}
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somAspchiefRecord", somAspchiefRecords);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("createAndSend");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
		updateOnlineStatusAccept();
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.history.go(-1);
}

//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“社会团体中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
function printParty(){
	var somPartyMemberDataSet = L5.DatasetMgr.lookup("somPartyMemberDataSet");
	somPartyMemberDataSet.setParameter("SORG_ID",sorgId);
	somPartyMemberDataSet.setParameter("PEOPLE_TYPE",'1');
	somPartyMemberDataSet.load();
	somPartyMemberDataSet.on('load',function(ds){
		partyNum=ds.getCount();
		if(partyNum<3){
			L5.Msg.alert('提示','正式党员不足三人，不需建立党组织！');
			return;
		}
		var win = L5.getCmp("printPartyWin");
		win.show();
	});
}
var partyNum='';
function confirmPrint(){
	var linkmanName=encodeURIComponent(encodeURIComponent(_$('linkmanName')));
	var linkmanPhone=_$('linkmanPhone');
	if(linkmanName==''||linkmanPhone==''){
		L5.Msg.alert('提示','请先填写完整的联系人信息！');
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/partyBuildInformForPrint.jsp?cnName="+encodeURIComponent(encodeURIComponent(cnName))
	+'&linkmanName='+linkmanName+'&linkmanPhone='+linkmanPhone+'&taskCode='+taskCode+'&partyNum='+partyNum;
	window.open(url);
}
function closePrintWin(){
	var win = L5.getCmp("printPartyWin");
	win.setVisible(false);
}
//根据会议名称查询是否已经做过换届
function meetingQuery(){
	if(document.getElementById('cnName').value.trim() == '' ){
		L5.Msg.alert("提示","请填写社团名称！");
		return;
	}
	//根据会议名称查询是否已经做过换届
	var somMeetingQueryDataSet=L5.DatasetMgr.lookup("somMeetingQueryDataSet");
	somMeetingQueryDataSet.removeAll();
	somMeetingQueryDataSet.setParameter("SORG_ID@=",sorgIdExist);
	somMeetingQueryDataSet.setParameter("MEETING_NAME@=",document.getElementById("meetingName").value);
	somMeetingQueryDataSet.load();
	somMeetingQueryDataSet.on("load",alertMsgMeeting);
}
//somMeetingQueryDataSet加载触发的方法
function alertMsgMeeting(ds){
	ds.un("load",alertMsgMeeting);
	if(ds.getCount()>0){
		L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
		isMeetingExist = false;
	}else{
		isMeetingExist = true;
	}
}