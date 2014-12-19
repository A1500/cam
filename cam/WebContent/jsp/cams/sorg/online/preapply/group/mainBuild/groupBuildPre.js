var sorgCodeNum = "";
var sorgId="";
var sorgIdOnline="";
var taskCode="";
var cnNameNum = "";
var sorgCodeInit = "";
var cnNameInit = "";
var peopleIdInit = "";
var legalRecord="";
var updateRecord="";
var dutyId='';
var legalDutyId='';
var fileCode="S018";//负责人fileCode
var fileCodeF="S017";//法定代表人fileCode
//初始化
function init(){
	var winDutyDataSet = L5.DatasetMgr.lookup("winDutyDataSet");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("6");
	L5.getCmp("tab").setActiveTab("7");
	L5.getCmp("tab").setActiveTab("0");
	somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadInfo);

	somSessionDataSet.newRecord();

	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
	uploadLegalPeopleListCloseEvent();

	//过滤流程意见
	opinionSelect.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	//房屋来源意见过滤
	resideSourceSelect.filterBy(function(record, id){
		if("2".indexOf(record.get('value'))>-1){
			return record;
		}
		if("3".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	//社团职务过滤
	sorgDutiesSelect.filterBy(function(record, id){
		if("00004".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00007".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00008".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00009".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00014".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	//显示职务列表
	L5.getCmp("gridPeople").on("rowclick",function(g,rowIndex,e){
		winDutyDataSet.removeAll();
		var sm = g.getSelectionModel();
		var record = sm.getSelected();
		winDutyDataSet.setParameter("PEOPLE_ID",record.get("peopleId"));
		winDutyDataSet.load();
	});
	//身份验证window关闭时把数据清空
	L5.getCmp("win_peopleValidate").on("beforehide",function(){
		winDutyDataSet.removeAll();
	});

	//负责人window关闭时把数据清空
	L5.getCmp("peopleWin").on("beforehide",function(){
		updateRecord="";
	});
	//党员奖罚情况中，授予称号过滤
	grantedTitleComboBoxFilter();
}
//加载页面所有信息
function loadInfo(ds){
	ds.getCurrent().set("curOpinionId","1");
	ds.un("load",loadInfo);
	sorgId=ds.getCurrent().get("sorgId");
	//电子档案
	somElectronicDataSet_load();
	sorgIdOnline=ds.getCurrent().get("sorgId");
	taskCode=ds.getCurrent().get("taskCode");
	somOrganDataSetQuery.setParameter("SORG_ID@=", sorgId);
	somOrganDataSetQuery.load();
	somOrganDataSetQuery.on("load",loadSession);
}
function loadSession(ds){
	var cnName = ds.get("cnName");
	document.getElementById('cnName').value = cnName ;
	fillOrganInfo(cnName);
	ds.un("load",loadSession);
}
function loadRule(ds){
	ds.un("load",loadRule);
	somRule.setParameter("TASK_CODE@=", taskCode);
	somRule.load();
	somRule.on('load',loadFee);
}
function loadFee(ds){
	ds.un("load",loadFee);
	somFee.setParameter("TASK_CODE@=", taskCode);
	somFee.load();
	somFee.on('load',loadsomFlow);
}
/*
function loadRule(ds){
	ds.un("load",loadRule);
	somRule.setParameter("TASK_CODE@=", taskCode);
	somRule.load();
	somRule.on('load',loadFee);
}
function loadFee(ds){
	ds.un("load",loadFee);
	somFee.setParameter("TASK_CODE@=", taskCode);
	somFee.load();
	somFee.on('load',loadsomFlow);
}
*/
function loadsomFlow(ds){
	ds.un("load",loadsomFlow);
	somFlowListDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowListDataSet.setParameter("SORG_ID@=", sorgId);
	somFlowListDataSet.setParameter("APPLY_TYPE@=", "002");
	somFlowListDataSet.load();
	somFlowListDataSet.on('load',loadsomResume);
}

function loadsomResume(ds){
	ds.un("load",loadsomResume);
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',somResumeOnLoad);
	somPartyMemberDataSet.setParameter('SORG_ID',sorgIdOnline);
	somPartyMemberDataSet.load();
	somPartyMemberDataSet.on('load',somPartyMemberOnLoad);
}
function somPartyMemberOnLoad(ds){
		ds.un("load",somPartyMemberOnLoad);
		var mIds='';
		ds.filterBy(function(record, id){
			if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
				return record;
			}
		});
		if(ds.getCount()>0){
			for(var i=0;i<ds.getCount();i++){
				var mId=ds.getAt(i).get('memberId');
				mId+=',';
				mIds+=mId;
			}
			var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
			somPartyPraiseDataSet.setParameter('MEMBER_ID@IN',mIds);
			somPartyPraiseDataSet.load();
		}
	}
function somResumeOnLoad(ds){
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.un("load",somResumeOnLoad);
	somDutyDataSet.setParameter("TASK_CODE", taskCode);
	somDutyDataSet.load();
	somDutyDataSet.on('load',sumDutyOnLoad);
}
function sumDutyOnLoad(){
	somDutyDataSet.un("load",sumDutyOnLoad);
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	var peopleId="";
	var sorgOpinion="";
	var sorgCheckDate="";
	somDutyDataSet.each(function(record, index){
		if(record.get('sorgDuties') == legalDuties){
			peopleId=record.get('peopleId');
			sorgOpinion=record.get("sorgOpinion");
			sorgCheckDate=record.get("sorgCheckDate");
			legalDutyId=record.get('dutyId');
			//回填法定代表人简历
			var j=0;
			for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
				var somResumeRecord =somResumeDataSet.getAt(i);
				if(record.get('dutyId') == somResumeRecord.get('dutyId')){
						somResumeLegalDataSet.insert(j,somResumeRecord);
						j++;
					}
			}
			//回填法定代表人简历结束
		}
	});
	somDutyDataSet.filterBy(function(record, id){
		if(record.get('sorgDuties') != legalDuties){
			if(record.get('peopleId') == peopleId){
				legalRecord=record.copy();
				record.set("ifLegal","1");
				legalRecord.set("sorgOpinion",sorgOpinion);
				legalRecord.set("sorgCheckDate",sorgCheckDate);
				somDutyDataSet.commitChanges();
			}
			return record;
		}
	});
	LegalPeopleDataSet.insert(0,legalRecord);
	LegalPeopleDataSet.set("dutyId",legalDutyId);
	synPhoto(LegalPeopleDataSet.get("photoId"),null);
	somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
}
//保存按钮
function saveAllInfo(){
	//社会组织校验
	var somOrganIsValidate = somOrganDataSetQuery.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
		return;
	}
	//社会团体邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"社会团体邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//社会团体传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"社会团体传真格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//单位会员数和个人会员数
    if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() == ""){
		if(_$("unitsNum") < 30){
			L5.Msg.alert("提示","校验未通过："+"单位会员数不能小于30");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}

	if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() != ""&&_$("unitsNum").trim() != "" && _$("peopleNum").trim() != "")
	{
	  if(_$("unitsNum") < 30&&parseInt(_$("unitsNum"))+parseInt(_$("peopleNum")) < 50)
	  {
	  L5.Msg.alert("提示","校验未通过："+"单位会员数不能小于30");
			L5.getCmp("tab").setActiveTab("0");
			return;
	  }


	}
	//资金数额
	if(_$("regMon") != ''){
		var regMon = checkMoneyFix(_$("regMon"),2);
		if(regMon == "整数"){
			if(_$("regMon").length >8){
				L5.Msg.alert("提示","校验未通过："+"活动资金数额格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(regMon == false){
			L5.Msg.alert("提示","校验未通过："+"活动资金数额格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//用房面积
	if(_$("housingArea") != ''){
		var housingArea = checkMoneyFix(_$("housingArea"),2);
		if(housingArea == "整数"){
			if(_$("housingArea").length >8){
				L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(housingArea == false){
			L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//届次校验
	var somSessionIsValidate = somSessionDataSet.isValidate();
	if(somSessionIsValidate != true){
		L5.Msg.alert("提示",somSessionIsValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}
	//章程校验
	var somRuleIsValidate = somRule.isValidate();
	if(somRuleIsValidate != true){
		L5.Msg.alert("提示",somRuleIsValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//章程数据校验
	if(checkRule() == false){
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//会费校验
	var somFeeIsValidate = somFee.isValidate();
	if(somFeeIsValidate != true){
		L5.Msg.alert("提示",somFeeIsValidate);
		L5.getCmp("tab").setActiveTab("4");
		return false;
	}
	if(checkFee() == false){
		L5.getCmp("tab").setActiveTab("4");
		return false;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("7");
		return false;
	}

	var organRecord=somOrganDataSetQuery.getCurrent();
	if(LegalPeopleDataSet.getCount()<1){
		L5.Msg.alert('提示',"请选定法定代表人！");
		return;
	}
	var LegalPeopleRecord=LegalPeopleDataSet.getCurrent();
	LegalPeopleRecord.set("photoText",_$("photoId"));//封装照片
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somRuleRecord=somRule.getCurrent();
	var somFeeRecord=somFee.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();
	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入负责人！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定法定代表人！");
		return;
	}
	somApplyRecord.set("sorgId",sorgId);
	LegalPeopleRecord.set("sorgId",sorgId);
	somSessionRecord.set("sorgId",sorgId);
	//后台处理的时候会判断sessionId是否为空，为空会插入，否则就update，由于外网申请过来sessionId是不为空的，这里清空一下
	somRuleRecord.set("sorgId",sorgId);
	somFeeRecord.set("sorgId",sorgId);

	var flag="true";
	var index;
	for(var i=0;i<somDutyRecords.length;i++){
		somDutyRecords[i].state = L5.model.Record.STATE_NEW;
		somDutyRecords[i].set("sorgId",sorgId);
		if(somDutyRecords[i].get('peopleId')==LegalPeopleRecord.get("peopleId")){
			var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
			command.setParameter("idCard",somDutyRecords[i].get("idCard"));
			command.setParameter("name",somDutyRecords[i].get("name"));
			command.setParameter("sorgType", somDutyRecords[i].get('sorgType'));
			command.execute("checkLegalPeople");
			flag=command.getReturn("flag");
			index=i;
		}
		somDutyRecords[i].set("peopleId","");
	}

	var somPartyMemberRecords=somPartyMemberDataSet.getAllRecords();
	for(var i=0;i<somPartyMemberRecords.length;i++){
		somPartyMemberRecords[i].state = L5.model.Record.STATE_NEW;
		somPartyMemberRecords[i].set("sorgId",sorgId);
	}
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	var somPartyPraiseRecords=somPartyPraiseDataSet.getAllRecords();
	for(var i=0;i<somPartyPraiseRecords.length;i++){
		somPartyPraiseRecords[i].state = L5.model.Record.STATE_NEW;
		somPartyPraiseRecords[i].set("sorgId",sorgId);
	}
	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	somRuleRecord.set("ifDraft","1");
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somFeeRecord", somFeeRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	//command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("somPartyMemberRecords",somPartyMemberDataSet.getAllRecords());
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	command.setParameter("somPartyPraiseRecords",somPartyPraiseDataSet.getAllRecords());

	//是其他社团法定代表人
	if(flag != "true"){
		var arr=flag.split("|");
		L5.getCmp("tab").setActiveTab("1");
		L5.MessageBox.confirm('确定', somDutyRecords[index].get("name")+arr[0]+" 是否继续选定？",function(yes){
			if(yes == "yes"){
				somDutyRecords[index].set("peopleId",arr[1]);
				command.setParameter("somDutyRecords", somDutyRecords);
				command.execute("insertBuildInfo");
					if (!command.error) {
						L5.Msg.alert("提示","保存成功！",function(){
							updateOnlineStatusAccept();
							window.history.go(-1);
						});
					}else{
						L5.Msg.alert('提示',"保存时出现错误！"+command.error);
					}
			}else{
				somDutyRecords[index].set("ifLegal","0");
		        LegalPeopleDataSet.removeAll();
		        return false;
			}
		});
	}else{
		command.setParameter("somDutyRecords", somDutyRecords);
		command.execute("insertBuildInfo");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){
				updateOnlineStatusAccept();
				window.history.go(-1);
			});
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
}
//保存并提交按钮
function saveAndSendInfo(){
	//社会组织校验
	var somOrganIsValidate = somOrganDataSetQuery.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
		return;
	}
	//社会团体邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"社会团体邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//社会团体传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"社会团体传真格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//单位会员数和个人会员数
    if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() == ""){
		if(_$("unitsNum") < 30){
			L5.Msg.alert("提示","校验未通过："+"单位会员数不能小于30");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}

	if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() != ""&&_$("unitsNum").trim() != "" && _$("peopleNum").trim() != "")
	{
	  if(_$("unitsNum") < 30&&parseInt(_$("unitsNum"))+parseInt(_$("peopleNum")) < 50)
	  {
	  L5.Msg.alert("提示","校验未通过："+"单位会员数不能小于30");
			L5.getCmp("tab").setActiveTab("0");
			return;
	  }


	}
	//资金数额
	if(_$("regMon") != ''){
		var regMon = checkMoneyFix(_$("regMon"),2);
		if(regMon == "整数"){
			if(_$("regMon").length >8){
				L5.Msg.alert("提示","校验未通过："+"活动资金数额格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(regMon == false){
			L5.Msg.alert("提示","校验未通过："+"活动资金数额格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//用房面积
	if(_$("housingArea") != ''){
		var housingArea = checkMoneyFix(_$("housingArea"),2);
		if(housingArea == "整数"){
			if(_$("housingArea").length >8){
				L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(housingArea == false){
			L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//届次校验
	var somSessionIsValidate = somSessionDataSet.isValidate();
	if(somSessionIsValidate != true){
		L5.Msg.alert("提示",somSessionIsValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}
	//章程校验
	var somRuleIsValidate = somRule.isValidate();
	if(somRuleIsValidate != true){
		L5.Msg.alert("提示",somRuleIsValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//章程数据校验
	if(checkRule() == false){
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//会费校验
	var somFeeIsValidate = somFee.isValidate();
	if(somFeeIsValidate != true){
		L5.Msg.alert("提示",somFeeIsValidate);
		L5.getCmp("tab").setActiveTab("4");
		return false;
	}
	if(checkFee() == false){
		L5.getCmp("tab").setActiveTab("4");
		return false;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("7");
		return false;
	}

	var organRecord=somOrganDataSetQuery.getCurrent();
	if(LegalPeopleDataSet.getCount()<1){
		L5.Msg.alert('提示',"请选定法定代表人！");
		return;
	}
	var LegalPeopleRecord=LegalPeopleDataSet.getCurrent();
	LegalPeopleRecord.set("photoText",_$("photoId"));//封装照片
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somRuleRecord=somRule.getCurrent();
	var somFeeRecord=somFee.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();

	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入负责人！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定法定代表人！");
		return;
	}
	somApplyRecord.set("sorgId",sorgId);
	LegalPeopleRecord.set("sorgId",sorgId);
	somSessionRecord.set("sorgId",sorgId);
	//后台处理的时候会判断sessionId是否为空，为空会插入，否则就update，由于外网申请过来sessionId是不为空的，这里清空一下
	//somSessionRecord.set("sessionId","");
	somRuleRecord.set("sorgId",sorgId);
	somFeeRecord.set("sorgId",sorgId);

	var flag="true";
	var index;
	for(var i=0;i<somDutyRecords.length;i++){
		somDutyRecords[i].state = L5.model.Record.STATE_NEW;
		somDutyRecords[i].set("sorgId",sorgId);
		if(somDutyRecords[i].get('peopleId')==LegalPeopleRecord.get("peopleId")){
			var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
			command.setParameter("idCard",somDutyRecords[i].get("idCard"));
			command.setParameter("name",somDutyRecords[i].get("name"));
			command.setParameter("sorgType", somDutyRecords[i].get('sorgType'));
			command.execute("checkLegalPeople");
			flag=command.getReturn("flag");
			index=i;
		}
		somDutyRecords[i].set("peopleId","");
	}

	var somPartyMemberRecords=somPartyMemberDataSet.getAllRecords();
	for(var i=0;i<somPartyMemberRecords.length;i++){
		somPartyMemberRecords[i].state = L5.model.Record.STATE_NEW;
		somPartyMemberRecords[i].set("sorgId",sorgId);
	}
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	var somPartyPraiseRecords=somPartyPraiseDataSet.getAllRecords();
	for(var i=0;i<somPartyPraiseRecords.length;i++){
		somPartyPraiseRecords[i].state = L5.model.Record.STATE_NEW;
		somPartyPraiseRecords[i].set("sorgId",sorgId);
	}


	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	somRuleRecord.set("ifDraft","1");
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somFeeRecord", somFeeRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	//command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("somPartyMemberRecords",somPartyMemberDataSet.getAllRecords());
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	command.setParameter("somPartyPraiseRecords",somPartyPraiseDataSet.getAllRecords());

	//是其他社团法定代表人
	if(flag != "true"){
		var arr=flag.split("|");
		L5.getCmp("tab").setActiveTab("1");
		L5.MessageBox.confirm('确定', somDutyRecords[index].get("name")+arr[0]+" 是否继续选定？",function(yes){
			if(yes == "yes"){
				somDutyRecords[index].set("peopleId",arr[1]);
				command.setParameter("somDutyRecords", somDutyRecords);
				command.execute("saveAndSendBuild");
				if (!command.error) {
					L5.Msg.alert("提示","成功提交至下一环节！",function(){
						updateOnlineStatusAccept();
						window.history.go(-1);
					});
				}else{
					L5.Msg.alert('提示',"提交时出现错误！"+command.error);
				}
			}else{
				somDutyRecords[index].set("ifLegal","0");
		        LegalPeopleDataSet.removeAll();
		        return false;
			}
		});
	}else{
		command.setParameter("somDutyRecords", somDutyRecords);
		command.execute("saveAndSendBuild");
		if (!command.error) {
			L5.Msg.alert("提示","成功提交至下一环节！",function(){
				updateOnlineStatusAccept();
				window.history.go(-1);
			});
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		}
	}
}
//返回按钮
function goBack(){
	window.history.go(-1);
}
//打印受理通知
function printAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;
	window.open(url);
}
//判断章程数据是否正确
function checkRule(){
	var flag=true;
	var realNum=somRule.get('realNum');
	var passNum=somRule.get('passNum');
	var nopassNum=somRule.get('nopassNum');
	var giveupNum=somRule.get('giveupNum');
	if(realNum == '' ){
		realNum=0;
	}if(passNum == '' ){
		passNum=0;
	}if(nopassNum == '' ){
		nopassNum=0;
	}if(giveupNum == '' ){
		giveupNum=0;
	}
	if(parseInt(realNum) != (parseInt(passNum)+parseInt(nopassNum)+parseInt(giveupNum))){
		L5.Msg.alert("提示","章程核准表中的人数逻辑不正确");
		flag = false;
	}
	return flag;
}
//判断会费数据是否正确
function checkFee(){
	var flag=true;
	var realNum=somFee.get('realNum');
	var passNum=somFee.get('passNum');
	var nopassNum=somFee.get('nopassNum');
	var giveupNum=somFee.get('giveupNum');
	if(realNum == '' ){
		realNum=0;
	}if(passNum == '' ){
		passNum=0;
	}if(nopassNum == '' ){
		nopassNum=0;
	}if(giveupNum == '' ){
		giveupNum=0;
	}
	if(parseInt(realNum) != (parseInt(passNum)+parseInt(nopassNum)+parseInt(giveupNum))){
		L5.Msg.alert("提示","会费标准备案表中的人数逻辑不正确");
		flag = false;
	}
	return flag;
}
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.setParameter("sorgType","S");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
			return;
		}
	}
}
//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}

//------------------负责人处理------------------------------
//点击上传法定代表人员附件按钮
function clickUploadLegalPeopleFile(){
	if($("labelIdCard").innerHTML == ""){
		L5.Msg.alert('提示','请先选中法定代表人');
		return false;
	}
	uploadLegalPeopleFile();
}
//增加负责人按钮
function add(){
	updateRecord='';
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.afterExecute=function(){
		dutyId = command.getReturn('dutyId');
		somDutyInsertDataSet.removeAll();
		somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifLegal":"0","sorgType":"S","regStatus":"1","taskCode":taskCode});
		var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
		somResumeInsertDataSet.removeAll();
		//把负责人任职时间回填页面上的成立时间
		somDutyInsertDataSet.set("startDate",_$("startDate"));
		somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件
		var win=L5.getCmp("peopleWin");
		win.show();
		document.getElementById("sorgDutiesNameDispaly").value = "";
		win.on("show",idCardFocus);
	}
	command.execute('getDutyId');
}
//点击更新一条负责人
var updateRecord;
function update(){
	var grid=L5.getCmp("peopleGrid");
	updateRecord=grid.getSelectionModel().getSelected();
	if(!updateRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	dutyId=updateRecord.get('dutyId');
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,updateRecord.copy());
	//处理个人简历
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(updateRecord.get('dutyId')==somResumeRecord.get('dutyId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	//处理个人简历完成

	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件

	var win = L5.getCmp("peopleWin");
	win.show();
	var sorgDuties=updateRecord.get('sorgDuties');
	var records=dutySelectDic.query("value",sorgDuties);
	if(records.length>0){
		var sorgDutiesText = records.items[0].get("text");
		document.getElementById("sorgDutiesNameDispaly").value = sorgDutiesText;
	}
	$("age").innerHTML = getAgeByCode(updateRecord.get('idCard'));

}
//点击删除一条负责人
function del(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
			somDutyDataSet.remove(records[0]);
			if(records[0].get("ifLegal") == '1'){
				LegalPeopleDataSet.removeAll();
				somLegalPeopleElectronicDeleteDataSet_load();//清空法定代表人法律要件并重载
			}
		}
		else return;
	}
	);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}
var peopleId=0;
var resumeCount=0;
//点击确定 保存一条负责人信息
function confirm(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomPeopleCmd");
	command.setParameter("ID_CARD",_$("idCard"));
	command.execute("queryRestrictNum");
	var restrictNum = command.getReturn("restrictNum");
	var ifLimit=command.getReturn("ifLimit");
	if(restrictNum > 0){
		if(ifLimit=='1'){
			L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){
				return;
			});
		}else if(ifLimit=='0'){
			var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
			command.setParameter("ID_CARD",_$("idCard"));
			command.execute("queryPeopleNum");
			var peopleNum = command.getReturn("peopleNum");
			if(peopleNum > 0){
				L5.MessageBox.confirm('确定', '此人有'+peopleNum+'条受限记录，确定其担任负责人？',function(sta){
					if(sta=="yes"){
						confirmInfo();
						return;
					}else{
						return;
					}
				});
			}
		}else{
			confirmInfo();
		}
	}else{
		confirmInfo();
	}
}
function confirmInfo(){
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
		//校验
		var record=somDutyInsertDataSet.getCurrent();
		var name=record.get('name').trim();
    record.set("name",name);
		record.set('sorgDuties',document.getElementById('sorgDuties').value);
		var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
		if(somDutyInsertValidate != true){
			L5.Msg.alert("提示",somDutyInsertValidate);
			return false;
		}
	//邮编
	var postCode=record.get("postCode");
	if(postCode!=""&&_isPostCode(postCode) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
		record.set("ifServe","1");
		record.set("promiseOrgan",document.getElementById('promiseOrgan_add').value);
		record.set("promiseCode",document.getElementById('promiseCode_add').value);
		if(updateRecord != ""){
			somDutyDataSet.remove(updateRecord);
		}
		somDutyDataSet.insert(somDutyDataSet.getCount(),record);
		somDutyDataSet.commitChanges();

		//处理个人简历
		var somResumeDataSet = L5.DatasetMgr.lookup("somResumeDataSet");
		var somResumeInsertDataSet = L5.DatasetMgr.lookup("somResumeInsertDataSet");
		for(var i=somResumeInsertDataSet.getCount()-1;i>=0;i--){
			var somResumeInsertRecord =somResumeInsertDataSet.getAt(i);
			if(somResumeDataSet.indexOf(somResumeInsertRecord)==-1){
				somResumeDataSet.insert(resumeCount,somResumeInsertRecord);
				resumeCount++;
			    somResumeDataSet.commitChanges();
			}
		}

		if(record.get('ifLegal') == "1"){
			var somResumeLegalDataSet = L5.DatasetMgr.lookup("somResumeLegalDataSet");
			//更新法定代表人panel信息
			LegalPeopleDataSet.removeAll();
			LegalPeopleDataSet.insert(0,record.copy());
			LegalPeopleDataSet.set("dutyId",legalDutyId);
			//回填法定代表人简历
			somResumeLegalDataSet.removeAll();
			somResumeLegalDataSet.add(somResumeInsertDataSet.getAllRecords());
			//回填法定代表人简历结束

			//somLegalPeopleElectronicDeleteDataSet_load();//清空法定代表人法律要件并重载
		}
		//处理个人简历完成

		var win=L5.getCmp("peopleWin");
		win.hide();
		updateRecord='';
}
// 增加个人简历
function addResume(){
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.newRecord({"dutyId":dutyId});
}
// 删除个人简历
function delResume(){
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var record=somResumeInsertDataSet.getCurrent();
	if(record!=null){
		somResumeInsertDataSet.remove(record);
		somResumeDataSet.remove(record);
	}
}

function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
//负责人录入中输入身份证号进行查询
function checkPeopleInfo(){
	var idCard=document.getElementById("idCard").value;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	// 根据证件号码索引人员
	var record=somDutyInsertDataSet.getCurrent();
	var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD",_$('idCard'));
	winPeopleDataSet.load();
	winPeopleDataSet.on('load', function(){
		if(winPeopleDataSet.getCount()>0){
			L5.getCmp("win_peopleValidate").show();
		}else{
			record.set("peopleId","");	//未查到人员时peopleId置空
		}
	});

}
//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//somDutyInsertDataSet.removeAll();
	var record = somDutyInsertDataSet.getCurrent();
	record.set("idCard",idCard);
	//回填性别
	record.set("sex",getSexByCode(idCard));
	//回填出生年月
	record.set("birthday",getBirthByCode(idCard));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCard);
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//任职信息中回填此人信息
function editItem(){
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ifLimit=record.get("ifLimit");
	var restrictPeopleId=record.get("restrictPeopleId");
	if(ifLimit=='1'){
		L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){
			return;
		});
	}else if(ifLimit=='0'){
		var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
		command.setParameter("PEOPLE_ID",restrictPeopleId);
		command.execute("getNum");
		var num = command.getReturn("num");
		if(num>0){
			L5.MessageBox.confirm('确定', '此人有'+num+'条受限记录，确定其担任负责人？',function(sta){
				if(sta=="yes"){
					editItemInfo();
					return;
				}else{
					return;
				}
			});
		}
	}else{
		editItemInfo();
	}
}
function editItemInfo(){
	var grid = L5.getCmp("gridPeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	var peopleId = record.get("peopleId");
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//somDutyInsertDataSet.removeAll();
	var newRecord = somDutyInsertDataSet.getCurrent();
	newRecord.set("peopleId",record.get("peopleId"));
	newRecord.set("idCard",record.get("idCard"));
	$("age").innerHTML = getAgeByCode(record.get("idCard"));
	newRecord.set("name",record.get("name"));
	newRecord.set("aliasName",record.get("aliasName"));
	newRecord.set("sex",record.get("sex"));
	newRecord.set("folk",record.get("folk"));
	newRecord.set("ifFulltime",record.get("ifFulltime"));
	newRecord.set("birthday",record.get("birthday"));
	newRecord.set("nation",record.get("nation"));
	newRecord.set("politics",record.get("politics"));
	newRecord.set("education",record.get("education"));
	newRecord.set("birthplace",record.get("birthplace"));
	newRecord.set("phone",record.get("phone"));
	newRecord.set("adds",record.get("adds"));
	newRecord.set("ifRetire",record.get("ifRetire"));
	newRecord.set("populace",record.get("populace"));
	newRecord.set("postCode",record.get("postCode"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("workPhone",record.get("workPhone"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("ifPartyLeader",record.get("ifPartyLeader"));
	newRecord.set("resume",record.get("resume"));
	newRecord.set("profession",record.get("profession"));
	newRecord.set("peoplePartyType",record.get("peoplePartyType"));
	newRecord.set("joinDate",record.get("joinDate"));
	newRecord.set("relation",record.get("relation"));
	newRecord.set("partyDuties",record.get("partyDuties"));
	newRecord.set("ifMoblie",record.get("ifMoblie"));
	newRecord.set("developDate",record.get("developDate"));
	newRecord.set("activistsDate",record.get("activistsDate"));
	newRecord.set("applicationDate",record.get("applicationDate"));
	//newRecord.set("ifLegal",record.get("ifLegal"));
	newRecord.set("photoId",record.get("photoId"));

	//回填简历信息
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
	var gridDuty=L5.getCmp("gridDuty");
	var dutyRecord=gridDuty.getSelectionModel().getSelected();
	//分两种情况，因为简历时需要根据duty取，所以判断有没有选择职务信息，有的话就用选择的，没有选择的话就用判断有没有职务，有职务就用第一个
	if(!dutyRecord){
		//没有选择
		if(winDutyDataSet.getCount()>0){
			var dutyId = winDutyDataSet.getAt(0).get("dutyId");
			somResumeInsertDataSet.setParameter("DUTY_ID",dutyId);
			somResumeInsertDataSet.load();
		}
	}else{
		//选择了
		somResumeInsertDataSet.setParameter("DUTY_ID",dutyRecord.get("dutyId"));
		somResumeInsertDataSet.load();
	}

	var win = L5.getCmp("win_peopleValidate");
	win.hide();

}
//关闭窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//选择是否党政机关领导
function valid_ifPartyLeader_add(){
	if(document.getElementById('ifPartyLeader_add').value == '1'){
		$("leaderTr").style.display="block";
	}else{
		$("leaderTr").style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
		$("partyLeaderLevel").value="";
	}
}
//选定为法定代表人
function chooseLegal(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var photoId = records[0].get("photoId");
		var legalDutyIdSelected=records[0].get("dutyId");
		//检查此人是否是其他社团法定代表人
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
		var peopleId = records[0].get('peopleId');
		if( peopleId == ''){
			peopleId="NO_ONE"
		}
		command.setParameter("peopleId",peopleId);
		command.setParameter("sorgType", records[0].get('sorgType'));
		command.execute("checkLegalPeopleRepeat");
		var flag=command.getReturn("flag");
		//是其他社团法定代表人
		if(flag != "true"){
			L5.MessageBox.confirm('确定', records[0].get("name")+flag+" 是否继续选定？",function(sta){
				if(sta=="yes"){
					//如果法定代表人已经存在
					if(LegalPeopleDataSet.getCount() == 1 && LegalPeopleDataSet.getCurrent().get("idCard") != ""){
						L5.MessageBox.confirm('确定', '法定代表人已经存在，是否覆盖？',function(yes){
							if(yes=="yes"){
								var record=LegalPeopleDataSet.getCurrent();
								somDutyDataSet.each(function (rec, index){
									rec.set("ifLegal",'0');
								});
								LegalPeopleDataSet.removeAll();
								records[0].set("ifLegal",'1');
								somDutyDataSet.commitChanges();
								LegalPeopleDataSet.insert(0,records[0].copy());
								LegalPeopleDataSet.set("dutyId",legalDutyId);
								var idCard=records[0].get("idCard");
								document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
								//同步照片
								synPhoto(photoId,null);
								//回填简历信息
								createLegalResume(legalDutyIdSelected);
								somLegalPeopleElectronicDeleteDataSet_load();//清空法定代表人法律要件并重载
							}
								else return;
						});
						return;
					}
					//如果法定代表人还未选定
					records[0].set("ifLegal",'1');
					somDutyDataSet.commitChanges();
					LegalPeopleDataSet.removeAll();
					LegalPeopleDataSet.insert(0,records[0].copy());
					LegalPeopleDataSet.getCurrent().set('dutyId',legalDutyId);
					var idCard=records[0].get("idCard");
					document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
					//同步照片
					synPhoto(photoId,null);
					//回填简历信息
					createLegalResume(legalDutyIdSelected);
					//清空法定代表人法律要件并重载
					somLegalPeopleElectronicDeleteDataSet_load();
				}
				else return;
			});
			return;
		}
		//是其他社团法定代表人逻辑结束
		//如果不是其他社团法定代表人
		L5.MessageBox.confirm('确定', '选定[ '+records[0].get("name")+' ]为法定代表人？',function(sta){
			if(sta=="yes"){
				//如果法定代表人已经存在
				if(LegalPeopleDataSet.getCount() == 1 && LegalPeopleDataSet.getCurrent().get("idCard") != ""){
					L5.MessageBox.confirm('确定', '法定代表人已经存在，是否覆盖？',function(yes){
						if(yes=="yes"){
							var record=LegalPeopleDataSet.getCurrent();
							somDutyDataSet.each(function (rec1, index){
								rec1.set("ifLegal",'0');
							});
							LegalPeopleDataSet.removeAll();
							records[0].set("ifLegal",'1');
							somDutyDataSet.commitChanges();
							LegalPeopleDataSet.insert(0,records[0].copy());
							LegalPeopleDataSet.set("dutyId",legalDutyId);
							var idCard=records[0].get("idCard");
							document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
							//同步照片
							synPhoto(photoId,null);
							//回填简历信息
							createLegalResume(legalDutyIdSelected);
							//清空法定代表人法律要件并重载
							somLegalPeopleElectronicDeleteDataSet_load();
						}
						else return;
					});
					return;
				}
				//如果法定代表人还未选定
				records[0].set("ifLegal",'1');
				somDutyDataSet.commitChanges();
				LegalPeopleDataSet.removeAll();
				LegalPeopleDataSet.insert(0,records[0].copy());
				LegalPeopleDataSet.set('dutyId',legalDutyId);
				var idCard=records[0].get("idCard");
				document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
				//同步照片
				synPhoto(photoId,null);
				//回填简历信息
				createLegalResume(legalDutyIdSelected);
				//清空法定代表人法律要件并重载
				somLegalPeopleElectronicDeleteDataSet_load();
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//回填法定代表人简历
function createLegalResume(legalDutyId){
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.removeAll();
	somResumeDataSet.each(function(record, index){
		if(legalDutyId==record.get('dutyId')){
			somResumeLegalDataSet.insert(somResumeLegalDataSet.getCount(),record);
		}
	});
}
//打印一次性补正材料通知
function sendForPolishing(){

}

function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
function getName(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var name=record.get('name');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + name + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + name + '</a>';
	}else{
		return name;
	}
}
function getBirthday(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var birthday=record.get('birthday');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + birthday + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + birthday + '</a>';
	}else{
		return birthday;
	}
}
function getSex(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var sex=record.get('sex');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + sex + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + sex + '</a>';
	}else{
		return sex;
	}
}
function getIfLimit(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + '是' + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + '否' + '</a>';
	}else{
		return "";
	}
}
function showRestrict(restrictPeopleId){
	var somRestrictPeopleDetailDataSet=L5.DatasetMgr.lookup("somRestrictPeopleDetailDataSet");
	somRestrictPeopleDetailDataSet.setParameter("PEOPLE_ID",restrictPeopleId);
	somRestrictPeopleDetailDataSet.load();
	var win = L5.getCmp("restrictWin");
	win.show();
}
function closeRestrictWin(){
	var win = L5.getCmp("restrictWin");
	win.hide();
}
//社会组织名字查询
function fillOrganInfo(name){
	if(name.trim() == ''){
		return;
	}
	if(nameChangeFlag=="0"){
		loadOrganInfo(name);
	}else{
		if(name==newName){
			somOrganDataSet.set("cnName",name);
		}else{
			loadOrganInfo(name);
		}
	}
}
function loadOrganInfo(name){
	somOrganDataSet.removeAll();
	somOrganDataSet.setParameter("CN_NAME@=",name);
	somOrganDataSet.setParameter("SORG_STATUS@in","12,23");
	somOrganDataSet.setParameter("SORG_TYPE@=","S");
	somOrganDataSet.load();
	somOrganDataSet.on('load',checkOrgan);
}
//回填相应信息
function checkOrgan(ds){
	ds.un('load',checkOrgan);
	var name=document.getElementById("cnName").value;
	if(ds.getCount() == 0){
		L5.Msg.alert("提示","该社团名称尚未成功筹备或已经设立，无法进行设立登记！");
		document.getElementById("cnName").value = '';
		ds.newRecord();
		return;
	}else{
		//如果查到的话将这笔预受理业务sorgid更新之前系统已经存在的那条数据的，因为筹备在保存的时候是做的update更新的名称核准的数据，taskcode不用更新
		sorgId=ds.get('sorgId');

		var borgName = ds.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
	somApplyDataSet.getCurrent().set("curOpinion","");
	somMeetingDataSet.setParameter("sorgId",sorgId);
	somMeetingDataSet.load();
	somMeetingDataSet.on('load',loadRule);
}
/*******************************以下为名称变更一系列函数******************************/
var nameChangeFlag="0";
var oldName="";
var count=0;
var newName="";
//名称变更
function changeName(){
	cnName=_$('cnName');
	if(cnName==''){
		L5.Msg.alert('提示',"不存在要变更的社团名称，请先录入社团中文名称！");
		return;
	}
	if(count==0){
		oldName=cnName;
	}
	var win=L5.getCmp("changeName");
	win.show();
	document.getElementById('oldName').value=oldName;
	document.getElementById('newName').value="";
}
//名称变更确定
function confirmWin(){
	newName=document.getElementById('newName').value;
	if(oldName==newName){
		L5.Msg.alert('提示',"名称未作更改，请重新填写！");
		document.getElementById('newName').value="";
		return;
	}
	if(checkSorgName(newName)){
		document.getElementById('newName').value="";
	}else{
		var win=L5.getCmp("changeName");
		win.hide();
		nameChangeFlag="1";
		document.getElementById('cnName').value=newName;
		somApplyDataSet.getCurrent().set("curOpinion","社团名称由 "+oldName+" 变更为 "+newName);
		somOrganDataSet.set("cnName",newName);
		count++;
	}
}
//名称变更关闭
function closeWin(){
	var win=L5.getCmp("changeName");
	win.hide();
}
//名称检查是否重复
function checkSorgName(name){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",name);
	command.execute("cnNameUK");
	cnNameNum = command.getReturn("cnNameNum");
	if(cnNameNum != 0){
		L5.Msg.alert("提示","更改的名称已经存在，请重新输入！");
		return true;
	}
	return false;
}
/*******************************名称变更一系列函数结束******************************/

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
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somSessionRecord=somSessionDataSet.getCurrent();
	somSessionRecord.set("sessionId",record.get("MEETINGID"));
	somSessionRecord.set("sessionName",record.get("MEETINGNAME"));
	somSessionRecord.set("taskCode",taskCode);

	var somFeeDataSet=L5.DatasetMgr.lookup("somFee");
	var somFeeRecord=somFeeDataSet.getCurrent();
	somFeeRecord.set("meetingId",record.get("MEETINGID"));
	somFeeRecord.set("meetingName",record.get("MEETINGNAME"));
	somFeeRecord.set("meetingDate",record.get("MEETINGDATE"));
	somFeeRecord.set("shouldNum",record.get("SHOULDNUM"));
	somFeeRecord.set("realNum",record.get("REALNUM"));
	somFeeRecord.set("passNum",record.get("PASSNUM"));
	somFeeRecord.set("nopassNum",record.get("NOPASSNUM"));
	somFeeRecord.set("giveupNum",record.get("GIVEUPNUM"));
	somFeeRecord.set("meetingPlace",record.get("MEETINGPLACE"));

	var somRuleDataSet=L5.DatasetMgr.lookup("somRule");
	var somRuleRecord=somRuleDataSet.getCurrent();
	somRuleRecord.set("meetingId",record.get("MEETINGID"));
	somRuleRecord.set("meetingName",record.get("MEETINGNAME"));
	somRuleRecord.set("meetingFormat",record.get("MEETINGFORMAT"));
	somRuleRecord.set("meetingDate",record.get("MEETINGDATE"));
	somRuleRecord.set("shouldNum",record.get("SHOULDNUM"));
	somRuleRecord.set("realNum",record.get("REALNUM"));
	somRuleRecord.set("passNum",record.get("PASSNUM"));
	somRuleRecord.set("nopassNum",record.get("NOPASSNUM"));
	somRuleRecord.set("giveupNum",record.get("GIVEUPNUM"));

	winCloseMeeting();
}