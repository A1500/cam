var sorgId = "1";
var trueSorgId = '';
function init(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadOrgan);
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});	
	}
}
function loadOrgan(ds){
	ds.un('load',loadOrgan);
	sorgId = ds.get("sorgId");
	
	somOrganQueryDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganQueryDataSet.load();
	somOrganQueryDataSet.on('load',loadTrueOrgan);
	//somOrganQueryDataSet.on('load',loadRule);
}
function loadTrueOrgan(ds){
	ds.un('load',loadOrgan);
	if(ds.getCount() > 0){
		var sorgCode = ds.get("sorgCode");
		somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
		somOrganDataSet.setParameter("SORG_TYPE","J");
		somOrganDataSet.setParameter("sorg_status@=",'22');
		somOrganDataSet.load();
		somOrganDataSet.on('load',findSorg);
	}else{
		
		L5.Msg.alert("提示","数据出错！未找到交换的社会组织信息！");
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
		somRuleDataSet.load();
		//电子档案
		somElectronicDataSet_load();
		return;
	}
}
function sorgCodechange(){
	var sorgCode = document.getElementById("sorgCode").value;
	if(sorgCode.trim() == ''){
		return;
	}
	somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.load();
	somOrganDataSet.on('load',findSorg);
}
//社会组织
function findSorg(somOrganDataset){
	somOrganDataset.un('load',findSorg);
	if(somOrganDataset.getCount() > 0 ){
		sorgOrganRecord= somOrganDataset.getCurrent();
		trueSorgId = sorgOrganRecord.get('sorgId');
		document.getElementById('cnName').innerHTML=sorgOrganRecord.get('cnName');
		document.getElementById("sorgCode").value=sorgOrganRecord.get('sorgCode');
		somApplyDataSet.set("borgName",sorgOrganRecord.get('borgName'));
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
		somRuleDataSet.load();
		somRuleDataSet.on("load",function(ds){
			//清空会议名称
			ds.set("meetingName","");
		});
		
		//电子档案
		somElectronicDataSet_load();
		
		//查询换届会议信息
		somMeetingDataSet.setParameter("sorgId",trueSorgId);
		somMeetingDataSet.load();
	}else{
		L5.Msg.alert("提示","没有找到此登记证号的社会组织的信息！");
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.setParameter("TASK_CODE@=",taskCode);
		somRuleDataSet.load();
		//电子档案
		somElectronicDataSet_load();
		document.getElementById("sorgCode").value = '';
		return false;
	}
}
function save(){
	if(document.getElementById("sorgCode").value.trim() == '' ){
		L5.Msg.alert("提示","基金会登记证号不能为空！");
		return;
	}
	if(_$("meetingName")==""){
		L5.Msg.alert("提示","请填写会议名称！");
		return;
	}
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	var validate=somRuleDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var shouldNum=_$("shouldNum");
	var realNum=_$("realNum");
	var passNum=_$("passNum");
	var nopassNum=_$("nopassNum");
	var givenupNum=_$("giveupNum");
	if(givenupNum!=""|nopassNum!=""|passNum!=""|realNum!=""){
		var num=parseInt(givenupNum)+parseInt(nopassNum)+parseInt(passNum);
		if(num!=realNum){
			L5.Msg.alert("提示","人数逻辑出错！");
			return false;
		}
	}
	
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	
	somRuleRecord.set("sorgId",trueSorgId);
	somApplyRecord.set("sorgId",trueSorgId);
	
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomRuleCmd");
	command.setParameter("somRuleRecord",somRuleRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("insert");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			updateOnlineStatusPass(somApplyRecord.get("taskCode"));
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
	uploadFile();
}
function returnBackHistory(){
	window.history.go(-1);	
}


function showMeeting(){
	var win=L5.getCmp("meetingWindow");
	win.show();
}

function winCloseMeeting(){
	var win=L5.getCmp("meetingWindow");
	win.hide();
}
function chooseMeeting(){
	var grid=L5.getCmp("meetingGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(record.get("RULESATUS") == "是"){
		L5.Msg.alert("提示","已经进行过章程核准，请不要重复核准！");
		return;
	}
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	var somRuleRecord=somRuleDataSet.getCurrent();
	somRuleRecord.set("meetingId",record.get("MEETINGID"));
	somRuleRecord.set("meetingName",record.get("MEETINGNAME"));
	somRuleRecord.set("meetingDate",record.get("MEETINGDATE"));
	winCloseMeeting();
}

