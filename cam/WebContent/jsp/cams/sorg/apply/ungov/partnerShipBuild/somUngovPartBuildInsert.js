var legalRecord="";
var legalDuties="00012";
var sorgType="M";
var sorgCodeNum="";
var cnNameNum="";
//初始化
function init(){
	var winDutyDataSet = L5.DatasetMgr.lookup("winDutyDataSet");
	L5.getCmp("sorgTab").setActiveTab("5");
	L5.getCmp("sorgTab").setActiveTab("4");
	L5.getCmp("sorgTab").setActiveTab("3");
	L5.getCmp("sorgTab").setActiveTab("2");
	L5.getCmp("sorgTab").setActiveTab("1");
	L5.getCmp("sorgTab").setActiveTab("0");
	
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("0");
	if(method == 'INSERT'){
		somOrganDataSet.newRecord();
		somApplyDataSet.newRecord({"taskCode":taskCode,"curActivity":"受理", "curOpinionId":"1"});
		somRuleDataSet.newRecord({"taskCode":taskCode});
		somSessionDataSet.newRecord({"taskCode":taskCode});
		somElectronicDataSet_load();
	}else{
		somApplyDataSet.setParameter("PROCESS_ID@=", processId);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
	}
	
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
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
function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = somOrganDataSet.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}
	});
	
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somElectronicDataSet_load();
	
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();	
	somResumeDataSet.on('load',function(){	
		somDutyDataSet.setParameter("TASK_CODE", taskCode);
		somDutyDataSet.load();
		somDutyDataSet.on('load',function(){
			if(somDutyDataSet.getCount()>0){
				var peopleId="";
				var sorgOpinion = "";
				somDutyDataSet.each(function(record, index){
					if(record.get('sorgDuties') == legalDuties){
						peopleId=record.get('peopleId');
						legalDutyId=record.get('dutyId');
						sorgOpinion=record.get('sorgOpinion');
						//回填法定代表人简历
						var j=0;
					}
				});
				somDutyDataSet.filterBy(function(record, id){
					if(record.get('sorgDuties') != legalDuties){
						if(record.get('peopleId') == peopleId){
							legalRecord=record.copy();
							record.set("ifLegal","1");
							somDutyDataSet.commitChanges();
						}
						return record;
					}
				});
				LegalPeopleDataSet.insert(0,legalRecord);
				LegalPeopleDataSet.set("dutyId",legalDutyId);
				LegalPeopleDataSet.set("sorgOpinion",sorgOpinion);
				synPhoto(LegalPeopleDataSet.get("photoId"),null);
				
				var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
				somOfficeDataSet.setParameter("TASK_CODE@=", taskCode);
				somOfficeDataSet.load();
								
				var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
				somSessionDataSet.setParameter("TASK_CODE@=", taskCode);
				somSessionDataSet.load();
				var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
				somRuleDataSet.setParameter("TASK_CODE@=", taskCode);
				somRuleDataSet.load();	
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
			}else{
				somApplyDataSet.set("curActivity", "受理");
				somApplyDataSet.set("curOpinionId",'1');
				//法定代表人
				LegalPeopleDataSet.newRecord();
				//届次信息
				var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
				somSessionDataSet.newRecord();
				//章程核准
				var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
				somRuleDataSet.newRecord();		
			}
			somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件	
		});	
	});
}
//保存按钮
function save(){
	//社会组织校验
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("0");
		return false;
	}	
	//民办非企业邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"民办非企业邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("0");
		return;
	}
	//民办非企业传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"民办非企业传真格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("0");
		return;
	}
	//资金数额
	if(_$("regMon") != ''){
		var regMon = checkMoneyFix(_$("regMon"),2);
		if(regMon == "整数"){
			if(_$("regMon").length >8){
				L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				L5.getCmp("sorgTab").setActiveTab("0");
				return;
			}
		}
		if(regMon == false){
			L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			L5.getCmp("sorgTab").setActiveTab("0");
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
				L5.getCmp("sorgTab").setActiveTab("0");
				return;
			}
		}
		if(housingArea == false){
			L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			L5.getCmp("sorgTab").setActiveTab("0");
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
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("4");
		return false;
	}
	//章程数据校验
	if(checkRule() == false){
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("4");
		return false;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		return false;
	}

	var organRecord=somOrganDataSet.getCurrent();
	if(LegalPeopleDataSet.getCount()<1){
		L5.Msg.alert('提示',"请选定负责人！");
		return;
	}
	var LegalPeopleRecord=LegalPeopleDataSet.getCurrent();
	LegalPeopleRecord.set("photoText",_$("photoId"));//封装照片
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();
	//办事机构
	var somOfficeDataSetRds = somOfficeDataSet.getAllRecords();
	
	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入合伙人！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定负责人！");
		return;
	}
	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("borgName",document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	if(legalRecord==""){
		somRuleRecord.set("ifDraft","1");
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovPartBuildCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	command.setParameter("somOfficeDataSetRds", somOfficeDataSetRds);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	
	alert(somResumeDataSet.print());
	
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("somPartyMemberRecords",somPartyMemberDataSet.getAllRecords());
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	command.setParameter("somPartyPraiseRecords",somPartyPraiseDataSet.getAllRecords());
	if(legalRecord==""){
		command.execute("insertBuildInfo");
	}else {
		command.execute("updateBuildInfo");
	}	
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			window.history.go(-1);
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交按钮
function submit(){
	//社会组织校验
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("0");
		return false;
	}	
	//民办非企业邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"民办非企业邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("0");
		return;
	}
	//民办非企业传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"民办非企业传真格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("0");
		return;
	}
	//资金数额
	if(_$("regMon") != ''){
		var regMon = checkMoneyFix(_$("regMon"),2);
		if(regMon == "整数"){
			if(_$("regMon").length >8){
				L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				L5.getCmp("sorgTab").setActiveTab("0");
				return;
			}
		}
		if(regMon == false){
			L5.Msg.alert("提示","校验未通过："+"开办资金数额格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			L5.getCmp("sorgTab").setActiveTab("0");
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
				L5.getCmp("sorgTab").setActiveTab("0");
				return;
			}
		}
		if(housingArea == false){
			L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			L5.getCmp("sorgTab").setActiveTab("0");
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
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("4");
		return false;
	}
	//章程数据校验
	if(checkRule() == false){
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("sorgTab").setActiveTab("4");
		return false;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		return false;
	}

	var organRecord=somOrganDataSet.getCurrent();
	if(LegalPeopleDataSet.getCount()<1){
		L5.Msg.alert('提示',"请选定负责人！");
		return;
	}
	var LegalPeopleRecord=LegalPeopleDataSet.getCurrent();
	LegalPeopleRecord.set("photoText",_$("photoId"));//封装照片
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somRuleRecord=somRuleDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();
	//办事机构
	var somOfficeDataSetRds = somOfficeDataSet.getAllRecords();
	
	
	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入合伙人！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定负责人！");
		return;
	}
	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return;
		}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somApplyRecord.set("borgName",document.getElementById("borgName").value);
	somApplyRecord.set("taskCode",taskCode);
	if(legalRecord==""){
		somRuleRecord.set("ifDraft","1");
	}	
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovPartBuildCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	command.setParameter("somOfficeDataSetRds", somOfficeDataSetRds);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("somPartyMemberRecords",somPartyMemberDataSet.getAllRecords());
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	command.setParameter("somPartyPraiseRecords",somPartyPraiseDataSet.getAllRecords());
	if(legalRecord==""){
		command.execute("createAndSend");
	}else {
		command.execute("updateForSend");
	}
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			window.history.go(-1);
		});		
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印受理通知
function printAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&printPeople="+currentUserName+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回按钮
function goBack(){
	window.history.go(-1);
}
//判断章程数据是否正确
function checkRule(){
	var flag=true;
	var realNum=somRuleDataSet.get('realNum');
	var passNum=somRuleDataSet.get('passNum');
	var nopassNum=somRuleDataSet.get('nopassNum');
	var giveupNum=somRuleDataSet.get('giveupNum');
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
//回填社会组织法人登记信息
function fillOrganInfo(){
	somOrganDataSet.setParameter("CN_NAME@=",_$("cnName"));
	somOrganDataSet.setParameter("SORG_TYPE@=","M");
	somOrganDataSet.setParameter("SORG_STATUS@=","12");
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
//------------------负责人处理------------------------------
//点击上传负责人员附件按钮
function clickUploadLegalPeopleFile(){
	if($("legalName").value == ""){
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
		somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifLegal":"0","sorgType":"M","regStatus":"1","taskCode":taskCode});
		var win=L5.getCmp("peopleWin");
		win.show();
	}
	command.execute('getDutyId');
}
function idCardFocus(){
	$("idCard").focus();
}
//点击更新一条负责人
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
	var win = L5.getCmp("peopleWin");
	win.show();
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
				somLegalPeopleElectronicDeleteDataSet_load();//清空法定代表人法律要件
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
	confirmInfo();
}
function confirmInfo(){
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//校验
	var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
	if(somDutyInsertValidate != true){
		L5.Msg.alert("提示",somDutyInsertValidate);
		return false;
	}
	
	var record=somDutyInsertDataSet.getCurrent();
	//邮编
	var postCode=record.get("postCode");
	if(postCode!=""&&_isPostCode(postCode) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
	record.set("ifServe","1");
	if(updateRecord != ""){
		somDutyDataSet.remove(updateRecord);
	}
	somDutyDataSet.insert(somDutyDataSet.getCount(),record);
	somDutyDataSet.commitChanges();
	
	if(record.get('ifLegal') == "1"){
		//更新法定代表人panel信息
		LegalPeopleDataSet.removeAll();
		LegalPeopleDataSet.insert(0,record.copy());
		LegalPeopleDataSet.set("dutyId",legalDutyId);
		//清空法定代表人法律要件并重载
		somLegalPeopleElectronicDeleteDataSet_load();
	}
	var win=L5.getCmp("peopleWin");
	win.hide();
	updateRecord='';
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
	
	var idCard=document.getElementById("idCard").value;
	//回填性别
	record.set("sex",getSexByCode(idCard));
	//回填出生年月	
	record.set("birthday",getBirthByCode(idCard));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCard);
	$("birthday").value = getBirthByCode(idCard);
	
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
	newRecord.set("personUnit",record.get("personUnit"));
	newRecord.set("personUnitPhone",record.get("personUnitPhone"));
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
//选定为负责人
function chooseLegal(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var photoId = records[0].get("photoId");
		var legalDutyIdSelected=records[0].get("dutyId");
		L5.MessageBox.confirm('确定', '选定[ '+records[0].get("name")+' ]为负责人？',function(sta){
			if(sta=="yes"){
				if(LegalPeopleDataSet.getCount() == 1 && LegalPeopleDataSet.getCurrent().get("name") != ""){
					L5.MessageBox.confirm('确定', '负责人已经存在，是否覆盖？',function(yes){
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
							//同步照片
							synPhoto(photoId,null);
							//清空法定代表人法律要件
							somLegalPeopleElectronicDeleteDataSet_load();
						}
						else return;
					})
					return;
				}
				//如果法定代表人还未选定
				records[0].set("ifLegal",'1');
				somDutyDataSet.commitChanges();
				LegalPeopleDataSet.removeAll();
				LegalPeopleDataSet.insert(0,records[0].copy());
				LegalPeopleDataSet.getCurrent().set('dutyId',legalDutyId);
				//同步照片
				synPhoto(photoId,null);
				//清空法定代表人法律要件
				somLegalPeopleElectronicDeleteDataSet_load();
			}
			else return;
		});		
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

// 增加举办者（自然人）
function addHeldPeople(){
	somHeldPeopleDataSet.newRecord();
}
// 删除举办者（自然人）
function delHelpPeople(){
	var record=somHeldPeopleDataSet.getCurrent();
	if(record!=null)
		somHeldPeopleDataSet.remove(record);
}
// 增加举办者（单位）
function addHeldOrgan(){
	somHeldOrganDataSet.newRecord();
}
// 删除举办者（单位）
function delHeldOrgan(){
	var record=somHeldOrganDataSet.getCurrent();
	if(record!=null)
		somHeldOrganDataSet.remove(record);
}

var officeRecord = null;
//增加常设办事机构
function addOffice(){
	officeRecord = null;
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	winOfficeDataSet.removeAll();
	winOfficeDataSet.newRecord();
	var win = L5.getCmp("officeWin");
	win.show();
}
//修改常设办事机构
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
//删除常设办事机构
function deleteOffice(){
	var grid = L5.getCmp("officeGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	somOfficeDataSet.remove(record);
}
//常设办事机构窗口确定
function winInsertOffice(){
//校验-------------------------------------------
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	var winOfficeDataSetIsValidate = winOfficeDataSet.isValidate();
	if(winOfficeDataSetIsValidate != true){
		L5.Msg.alert("提示",winOfficeDataSetIsValidate);
		return false;
	}
	//邮编
	if(_$("postCode_office")!=""&&_isPostCode(_$("postCode_office")) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
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
// 增加个人简历
function addResume(){
	if(LegalPeopleDataSet.getCurrent().get('dutyId') == '' ){
		L5.Msg.alert("提示","请先选择负责人！" );
		return;
	}
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.newRecord({"taskCode":taskCode,"dutyId":LegalPeopleDataSet.getCurrent().get('dutyId') });
}
// 删除个人简历
function delResume(){
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var record=somResumeDataSet.getCurrent();
	if(record!=null){
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
	somOrganDataSet.setParameter("CN_NAME",name);
	somOrganDataSet.setParameter("SORG_STATUS","9");
	somOrganDataSet.setParameter("SORG_TYPE","M");
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() == 0){
			L5.Msg.alert("提示","该民办非企业单位名称尚未成功核准或已经成立，无法进行成立登记！");
			somOrganDataSet.newRecord();
			return;
		}else{
			sorgId=somOrganDataSet.get('sorgId');
			cnName=name;
			somApplyDataSet.set("borgName",somOrganDataSet.get('borgName'));
			somOrganDataSet.set("sorgKind",'2');
			
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somOrganDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").value = borgName;
					document.getElementById("borgNameDispaly").value = borgCode;
				}
			}
			somApplyDataSet.getCurrent().set("curOpinion","");
		}
	});
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
		somApplyDataSet.getCurrent().set("curOpinion","民办非企业单位名称由 "+oldName+" 变更为 "+newName);
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