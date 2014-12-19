var legalDuties="00012";
var dutyId='';
var legalDutyId='';
var business='';//证书上业务范围
//初始化
function init(){
	L5.getCmp("sorgTab").setActiveTab("5");
	L5.getCmp("sorgTab").setActiveTab("4");
	L5.getCmp("sorgTab").setActiveTab("2");

	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	L5.getCmp("sorgTab").setActiveTab("0");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("PROCESS_ID", processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	//过滤意见枚举，去掉补齐补正
	if(actname == 'examin' || actname == 'check' || actname == 'audit' ){
	}else{
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
				return record;
			}
		});
	}
	//过滤tab页
	if(flag == 'true'){
		L5.getCmp("tab").remove(2);
	}
	//房屋来源意见过滤
	resideSourceSelect.filterBy(function(record, id){
		if("2".indexOf(record.get('value'))>-1){
			return record;
		}
		if("3".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	if(L5.getCmp("win_peopleValidate")){
		var winDutyDataSet = L5.DatasetMgr.lookup("winDutyDataSet");
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
	}

	//负责人window关闭时把数据清空
	if(L5.getCmp("peopleWin")){
		L5.getCmp("peopleWin").on("beforehide",function(){
			updateRecord="";
		});
	}
}
function loadInfo(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');

	var somApplyRecord=somApplyDataSet.getCurrent();
	somApplyRecord.set("curOpinionId","1");
	//现场勘查
	if(actname=='watch'){
		$("watchInfo1").style.display="block";
		$("watchInfo2").style.display="block";
		$("prospectAttendPeople").value=somApplyRecord.get("prospectAttendPeople");
		$("prospectPlace").value=somApplyRecord.get("prospectPlace");
		$("prospectDate").value=somApplyRecord.get("prospectDate");
		somApplyRecord.set("prospectAttendPeople","");
		somApplyRecord.set("prospectPlace","");
		somApplyRecord.set("prospectDate","");
	}
	//法人
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();

	var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
	somOfficeDataSet.setParameter("TASK_CODE", taskCode);
	somOfficeDataSet.load();
	//电子档案
	somElectronicDataSet_load();

	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();

	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	somRuleDataSet.setParameter("TASK_CODE", taskCode);
	somRuleDataSet.load();

	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();

	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.setParameter("TASK_CODE", taskCode);
	somDutyDataSet.load();
	somDutyDataSet.on('load',function(){
		var peopleId="";
		var sorgOpinion="";
		var sorgCheckDate="";
		somDutyDataSet.each(function(record, index){
			if(record.get('sorgDuties') == legalDuties){
				peopleId=record.get('peopleId');
				sorgOpinion=record.get("sorgOpinion");
				sorgCheckDate=record.get("sorgCheckDate");
				legalDutyId=record.get('dutyId');
			}
		});
		somDutyDataSet.filterBy(function(record, id){
			if(record.get('sorgDuties') != legalDuties){
				if(record.get('peopleId') == peopleId){
					legalRecord=record;
					record.set("ifLegal","1");
						legalRecord.set("sorgOpinion",sorgOpinion);
						legalRecord.set("sorgCheckDate",sorgCheckDate);
					somDutyDataSet.commitChanges();
				}
				return record;
			}
		});
		var LegalPeopleDataSet=L5.DatasetMgr.lookup("LegalPeopleDataSet");
		LegalPeopleDataSet.insert(0,legalRecord);
		LegalPeopleDataSet.set("dutyId",legalDutyId);
		synPhotoDetail(LegalPeopleDataSet.get("photoId"),null);
		somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
	});
	somPartyMemberDataSet.setParameter('SORG_ID',sorgId);
	somPartyMemberDataSet.load();
	var mIds='';
	somPartyMemberDataSet.on('load',function(ds){
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
	});
	//流程历史意见
	var somFlowListDataSet=L5.DatasetMgr.lookup("somFlowListDataSet");
	somFlowListDataSet.setParameter("TASK_CODE", taskCode);
	//somFlowListDataSet.setParameter("SORG_ID", sorgId);
	//somFlowListDataSet.setParameter("APPLY_TYPE", "101");
	somFlowListDataSet.load();

	//电子档案上传窗口关闭事件
	uploadListCloseEvent();

	//过滤流程意见
	if(actname=='print' || actname=='issue'){
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	}

	//显示职务列表
	L5.getCmp("gridPeople").on("rowclick",function(g,rowIndex,e){
		var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
		winDutyDataSet.removeAll();
		var sm = g.getSelectionModel();
		var record = sm.getSelected();
		winDutyDataSet.setParameter("PEOPLE_ID",record.get("peopleId"));
		winDutyDataSet.load();
	});
	//身份验证window关闭时把数据清空
	L5.getCmp("win_peopleValidate").on("beforehide",function(){
		var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
		winDutyDataSet.removeAll();
	});

	//单位领导成员（合伙人）window关闭时把数据清空
	L5.getCmp("peopleWin").on("beforehide",function(){
		updateRecord="";
	});
}
/*
//保存按钮
function saveAll(){
	//社会组织校验
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");

	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//民办非企业邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"民办非企业邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//民办非企业传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"民办非企业传真格式不正确");
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
	if(_$("unitsNum").trim() == "" && _$("peopleNum").trim() != ""){
		if(_$("peopleNum") < 50){
			L5.Msg.alert("提示","校验未通过："+"个人会员数不能小于50");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() != ""){
		if(parseInt(_$("unitsNum"))+parseInt(_$("peopleNum")) < 50){
			L5.Msg.alert("提示","校验未通过："+"会员总数不能小于50");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//资金数额
	if(_$("regMon") != ''){
		var regMon = checkMoneyFix(_$("regMon"),2);
		if(regMon == "整数"){
			if(_$("regMon").length >8){
				L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(regMon == false){
			L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,小数点后应保留两位");
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
	var somRuleIsValidate = somRuleDataSet.isValidate();
	if(somRuleIsValidate != true){
		L5.Msg.alert("提示",somRuleIsValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("6");
		return false;
	}
	var LegalPeopleDataSet=L5.DatasetMgr.lookup("LegalPeopleDataSet");
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");

	var organRecord=somOrganDataSet.getCurrent();
	var LegalPeopleRecord=LegalPeopleDataSet.getCurrent();
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();

	var somDutyRecords=somDutyDataSet.getAllRecords();
	//办事机构
	var somOfficeDataSetRds = somOfficeDataSet.getAllChangedRecords();

	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入单位领导成员（合伙人）！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定法定代表人！");
		return;
	}

	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	organRecord.set("borgName",somApplyRecord.get("borgName"));
	somApplyRecord.set("taskCode",taskCode);

	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovIndivBuildCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	command.setParameter("somOfficeDataSetRds",somOfficeDataSetRds);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.execute("updateBuildInfo");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交按钮
function saveAndSend(){
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var LegalPeopleDataSet=L5.DatasetMgr.lookup("LegalPeopleDataSet");
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
	//社会组织校验
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//民办非企业邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"民办非企业邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//民办非企业传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"民办非企业传真格式不正确");
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
	if(_$("unitsNum").trim() == "" && _$("peopleNum").trim() != ""){
		if(_$("peopleNum") < 50){
			L5.Msg.alert("提示","校验未通过："+"个人会员数不能小于50");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	if(_$("unitsNum").trim() != "" && _$("peopleNum").trim() != ""){
		if(parseInt(_$("unitsNum"))+parseInt(_$("peopleNum")) < 50){
			L5.Msg.alert("提示","校验未通过："+"会员总数不能小于50");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//资金数额
	if(_$("regMon") != ''){
		var regMon = checkMoneyFix(_$("regMon"),2);
		if(regMon == "整数"){
			if(_$("regMon").length >8){
				L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(regMon == false){
			L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,小数点后应保留两位");
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
	var somRuleIsValidate = somRuleDataSet.isValidate();
	if(somRuleIsValidate != true){
		L5.Msg.alert("提示",somRuleIsValidate);
		L5.getCmp("tab").setActiveTab("3");
		return false;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("6");
		return false;
	}

	var organRecord=somOrganDataSet.getCurrent();
	var LegalPeopleRecord=LegalPeopleDataSet.getCurrent();
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();
	//办事机构
	var somOfficeDataSetRds = somOfficeDataSet.getAllChangedRecords();


	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入单位领导成员（合伙人）！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定法定代表人！");
		return;
	}

	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	organRecord.set("borgName",somApplyRecord.get("borgName"));
	somApplyRecord.set("taskCode",taskCode);

	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovIndivBuildCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	command.setParameter("somOfficeDataSetRds",somOfficeDataSetRds);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.execute("updateForSend");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}*/
//返回按钮
function goBack(){
	window.history.go(-1);
}
//回填社会组织法人登记信息
function fillOrganInfo(){
	somOrganDataSet.setParameter("CN_NAME",_$("cnName"));
	somOrganDataSet.setParameter("SORG_TYPE","M");
	somOrganDataSet.setParameter("SORG_STATUS","12");
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			L5.Msg.alert("提示","社会组织未筹备");
			somOrganDataSet.removeAll();
			somOrganDataSet.newRecord();
			changeResideSource();
			return;
		}else{
			sorgId=ds.get("sorgId");
			$("leasePeriod").value = ds.get("leasePeriod");
		}
	});
}
//校验登记证号是否重复
var sorgCodeNum='';
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.setParameter("sorgType","M");
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"登记证号已存在");
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
//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“民办非企业中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
//------------------单位领导成员（合伙人）处理------------------------------
//查看单位领导成员（合伙人）
function detailPeople(){
	var grid = L5.getCmp("peopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var somDutyInsertDataSet=L5.DatasetMgr.lookup("somDutyInsertDataSet");
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record);

	var win = L5.getCmp("peopleWin");
	win.show();
}
//单位领导成员（合伙人）窗户关闭
function winClosePeople(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
//增加单位领导成员（合伙人）按钮
function add(){
	var somDutyInsertDataSet=L5.DatasetMgr.lookup("somDutyInsertDataSet");
	somDutyInsertDataSet.newRecord();
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.removeAll();
	var win=L5.getCmp("peopleWin");
	win.show();
	win.on("show",idCardFocus);
}
function idCardFocus(){
	$("idCard").focus();
}
//点击更新一条单位领导成员（合伙人）
function update(){
	var grid=L5.getCmp("peopleGrid");
	updateRecord=grid.getSelectionModel().getSelected();
	if(!updateRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var somDutyInsertDataSet=L5.DatasetMgr.lookup("somDutyInsertDataSet");
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

	var win = L5.getCmp("peopleWin");
	win.show();
	win.on("show",idCardFocus);
}
//点击删除一条单位领导成员（合伙人）
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
//点击确定 保存一条单位领导成员（合伙人）信息
function confirm(){
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//校验
	var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
	if(somDutyInsertValidate != true){
		L5.Msg.alert("提示",somDutyInsertValidate);
		return false;
	}

	var record=somDutyInsertDataSet.getCurrent();
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
		somResumeInsertRecord.set("peopleId",record.get("peopleId"));
		if(somResumeDataSet.indexOf(somResumeInsertRecord)==-1){
			somResumeDataSet.insert(resumeCount,somResumeInsertRecord);
			resumeCount++;
		    somResumeDataSet.commitChanges();
		}
	}

	var somResumeLegalDataSet = L5.DatasetMgr.lookup("somResumeLegalDataSet");
	if(record.get('ifLegal') == "1"){
		//更新法定代表人panel信息
		LegalPeopleDataSet.insert(0,record);
		var ifLegalPeopleId=record.get('peopleId');
		//回填法定代表人简历
		var j=0;
		for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
			var somResumeRecord =somResumeDataSet.getAt(i);
			if(ifLegalPeopleId == somResumeRecord.get('peopleId')){
					somResumeLegalDataSet.insert(j,somResumeRecord);
					j++;
				}
		}
		//回填法定代表人简历结束
	}
	//处理个人简历完成


	var win=L5.getCmp("peopleWin");
	win.hide();
}
//单位领导成员（合伙人）录入中输入身份证号进行查询
function checkPeopleInfo(){
	var idCard=document.getElementById("idCard").value;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD",idCard);
	winPeopleDataSet.load();
	var win_peopleValidate=L5.getCmp("win_peopleValidate");
	win_peopleValidate.show();

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
	var grid = L5.getCmp("gridPeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return ;
	}
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
		document.getElementById('promiseOrgan_add').style.display="block";
		document.getElementById('promiseCode_add').style.display="block";
	}else{
		document.getElementById('promiseOrgan_add').style.display="none";
		document.getElementById('promiseCode_add').style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
	}
}
//选定为法定代表人
function chooseLegal(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
	L5.MessageBox.confirm('确定', '选定[ '+records[0].get("name")+' ]为法定代表人？',function(sta){
		if(sta=="yes"){
			if(LegalPeopleDataSet.getCount() == 1 && LegalPeopleDataSet.getCurrent().get("idCard") != ""){
				L5.MessageBox.confirm('确定', '法定代表人已经存在，是否覆盖？',function(yes){
					if(yes=="yes"){
						var record=LegalPeopleDataSet.getCurrent();
						somDutyDataSet.remove(record);
						record.set("ifLegal",'0');
						somDutyDataSet.insert(somDutyDataSet.getCount(),record);
						LegalPeopleDataSet.removeAll();
						records[0].set("ifLegal",'1');
						somDutyDataSet.commitChanges();
						LegalPeopleDataSet.insert(0,records[0]);
						var idCard=records[0].get("idCard");
						document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
					}
					else return;
				})
				return;
			}
			records[0].set("ifLegal",'1');
			somDutyDataSet.commitChanges();
			LegalPeopleDataSet.removeAll();
			LegalPeopleDataSet.insert(0,records[0]);
			var idCard=records[0].get("idCard");
			document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
		}
		else return;
	}
	);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}


var officeRecord = null;
//内设机构明细
function detailOffice(){
	var grid = L5.getCmp("officeGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	officeRecord = record;
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	winOfficeDataSet.removeAll();
	var newRecord = winOfficeDataSet.newRecord();
	var win = L5.getCmp("officeWin");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("place",record.get("place"));
	newRecord.set("phone",record.get("phone"));
	newRecord.set("postCode",record.get("postCode"));
	newRecord.set("officeChief",record.get("officeChief"));
	newRecord.set("dutiesDesc",record.get("dutiesDesc"));
	newRecord.set("reason",record.get("reason"));
	newRecord.set("process",record.get("process"));
}
//增加内设机构
function addOffice(){
	officeRecord = null;
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	winOfficeDataSet.removeAll();
	winOfficeDataSet.newRecord();
	var win = L5.getCmp("officeWin");
	win.show();
}
//修改内设机构
function editOffice(){
	var grid = L5.getCmp("officeGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	officeRecord = record;
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	winOfficeDataSet.removeAll();
	var newRecord = winOfficeDataSet.newRecord();
	var win = L5.getCmp("officeWin");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("place",record.get("place"));
	newRecord.set("phone",record.get("phone"));
	newRecord.set("postCode",record.get("postCode"));
	newRecord.set("officeChief",record.get("officeChief"));
	newRecord.set("dutiesDesc",record.get("dutiesDesc"));
	newRecord.set("reason",record.get("reason"));
	newRecord.set("process",record.get("process"));
}
//删除内设机构
function deleteOffice(){
	var grid = L5.getCmp("officeGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
	somOfficeDataSet.remove(record);
}
//内设机构窗口确定
function winInsertOffice(){
//校验-------------------------------------------
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	var winOfficeDataSetIsValidate = winOfficeDataSet.isValidate();
	if(winOfficeDataSetIsValidate != true){
		L5.Msg.alert("提示",winOfficeDataSetIsValidate);
		return false;
	}
	//------------------------------------------
	if(officeRecord == null){
		somOfficeDataSet.insert(somOfficeDataSet.getCount(),winOfficeDataSet.getCurrent());
	}else{
		var record = winOfficeDataSet.getCurrent();
		officeRecord.set("name",record.get("name"));
		officeRecord.set("place",record.get("place"));
		officeRecord.set("phone",record.get("phone"));
		officeRecord.set("postCode",record.get("postCode"));
		officeRecord.set("officeChief",record.get("officeChief"));
		officeRecord.set("dutiesDesc",record.get("dutiesDesc"));
		officeRecord.set("reason",record.get("reason"));
		officeRecord.set("process",record.get("process"));
	}
	var win = L5.getCmp("officeWin");
	win.setVisible(false);
}
//常设办事机构窗口关闭
function winCloseOffice(){
	var win = L5.getCmp("officeWin");
	win.setVisible(false);
}
var fetchPeople='';//领证人
var fetchDate='';//领证日期
var fetchPhone='';//领证人电话
var PrintDate='';//发证日期
var beginDate='';//有效期限起
var endDate='';//有效期限止
var issueReasonDesc='';//发证原因描述
//选择领证人
function choseIssuePeople(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.show();
}
//选择领证人里面的确认按钮
function buttonForFetch(){
	fetchPeople=document.getElementById('fetchPeople').value;
	fetchDate=document.getElementById('fetchDate').value;
	fetchPhone=document.getElementById('fetchPhone').value;
	if(fetchPeople==''){
		L5.Msg.alert('提示',"领证人不能为空！");return;
	}else if(fetchDate==''){
		L5.Msg.alert('提示',"领证日期不能为空！");return;
	}else if(fetchPhone==''){
		L5.Msg.alert('提示',"领证人联系电话不能为空！");return;
	}
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}
function closeForFetch(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}

//打印不予受理通知
function printNoAccept(){
	var printUrl=url+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp";
	window.open(printUrl);
}
//打印受理通知
function printAccept(){
	var printUrl=url+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=M";
	window.open(printUrl);
}
//弹出打印证书窗口
function printCert(){
	var win=L5.getCmp("forPrint");
	win.show();
	$('business').value = somOrganDataSet.get("business");
}
//关闭打印证书窗口
function winCloseCert(){
	var win = L5.getCmp("forPrint");
	win.setVisible(false);
}
//打印证书
function forCertType(){
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的民办非企业单位登记证号已存在");
		return;
	}
	var certType=_$('certType');
	sorgCode=_$('sorgCode');
	organCode=_$('organCode');
	regDate=_$('regDate');
	PrintDate=_$('PrintDate');
	beginDate=_$('beginDate');
	endDate=_$('endDate');
	issueReasonDesc=_$('issueReasonDesc');
	//业务范围可能会导致url过长，不能正确传递
	business = _$('business');
	var somApplyDataSet = L5.DatasetMgr.lookup("somApplyDataSet");
	var taskCode = somApplyDataSet.get("taskCode");
	if(business=='' ){
		L5.Msg.alert('提示',"请输入业务范围！");
		return;
	}
	if(sorgCode!=''&&certType!='' && endDate!='' && beginDate!='' && PrintDate!=''){
		if(endDate<beginDate){
			L5.Msg.alert('提示',"有效期限止不得早于有效期限起！");
			return;
		}
		var printUrl=url+"/jsp/cams/sorg/comm/print/ungovBuildForPrint.jsp?id="+sorgId+"&sorgCode="+sorgCode+"&organCode="+organCode+"&PrintDate="+PrintDate+"&beginDate="+beginDate+"&endDate="+endDate+"&taskCode="+taskCode+"&certType="+certType+"&business="+encodeURIComponent(business);
		PostNewWin(printUrl);
	}else{
		L5.Msg.alert('提示',"填入所需数据！");
		return;
	}
	if(certType == '0'){

	}else if(certType == '1'){

	}
}
//打印证书环节提交
function sendForPrint(){
	if(endDate=='' || beginDate=='' || PrintDate==''){
		L5.Msg.alert("提示","请先打印证书!");
		return;
	}
	if(actname=='print'){
		if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	var somApplyDataSet = L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovIndivBuildCmd");
	command.setParameter("sorgCode", sorgCode);
	command.setParameter("organCode", organCode);
	command.setParameter("certType", _$("certType"));
	command.setParameter("regDate", regDate);
	command.setParameter("endDate", endDate);
	command.setParameter("beginDate", beginDate);
	command.setParameter("PrintDate", PrintDate);
	command.setParameter("business", business);
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("issueReasonDesc", issueReasonDesc);
	command.setParameter("somApplyDataSetRd", somApplyDataSetRd);
	command.execute("printForSend");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//保存
function saveApply(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovIndivBuildCmd");
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	if(actname=="watch"){
		somApplyDataSetRd.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyDataSetRd.set("prospectPlace",_$("prospectPlace"));
		somApplyDataSetRd.set("prospectDate",_$("prospectDate"));
	}
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//保存
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function send(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovIndivBuildCmd");
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	if(actname=="watch"){
		somApplyDataSetRd.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyDataSetRd.set("prospectPlace",_$("prospectPlace"));
		somApplyDataSetRd.set("prospectDate",_$("prospectDate"));
	}
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		if(actname=='issue' ){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				goBack();
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
			if(actname == 'audit'){
			if(somApplyDataSetRd.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
				updateOnlineStatusPass(somApplyDataSetRd.get("taskCode"));
			}
			if(somApplyDataSetRd.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
				updateOnlineStatusNoPass(somApplyDataSetRd.get("taskCode"));
			}
		}
				goBack();
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
// 增加个人简历
function addResume(){
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.newRecord();
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
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
function detailPartyMember(){
	var grid = L5.getCmp("partyMemberGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var partyMemberRecord = record;
	var memberId=record.get('memberId');
	winPartyMemberDataSet.removeAll();
	winPartyMemberDataSet.insert(0,record);

	//处理奖惩
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	somPartyPraiseInsertDataSet.removeAll();
	var j=0;
	for(var i=somPartyPraiseDataSet.getCount()-1;i>=0;i--){
		var somPartyPraiseRecord =somPartyPraiseDataSet.getAt(i);
		if(partyMemberRecord.get('memberId')==somPartyPraiseRecord.get('memberId')){
			somPartyPraiseInsertDataSet.insert(j,somPartyPraiseRecord);
			j++;
		}
	}
	var win = L5.getCmp("partyMemberWin");
	win.show();

	var peopleType=record.get('peopleType');
 	var dangyuan=$("dangyuanDiv");
 	var yubei=$("yubeiDiv");
 	var fazhan=$("fazhanDiv");
 	var jijifenzi=$("jijifenziDiv");
 	var shenqingren=$("shenqingrenDiv");
 	if(peopleType==5){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="block";
 	}else if(peopleType==4){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="block";
 		shenqingren.style.display="none";
 	}else if(peopleType==3){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="block";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";
 	}else if(peopleType==2){
 		dangyuan.style.display="none";
 		yubei.style.display="block";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";
 	}else{
 		dangyuan.style.display="block";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";
 	}
}
//窗口关闭
function winClosePartyMember(){
	var win = L5.getCmp("partyMemberWin");
	win.setVisible(false);
}