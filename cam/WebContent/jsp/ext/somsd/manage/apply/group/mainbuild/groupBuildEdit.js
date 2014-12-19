var legalDutyId='';
var legalRecord="";
var legalDuties="00012";
//初始化
function init(){
	var winDutyDataSet = L5.DatasetMgr.lookup("winDutyDataSet");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		//法人
		somOrganDataSet.newRecord({"cnName":userId,"sorgId":sorgId,"sorgType":"S","ifBranch":'0',"morgName":userId,"morgArea":morgArea});
		//法定代表人
		LegalPeopleDataSet.newRecord();
		//届次信息
		somSessionDataSet.newRecord({"taskCode":taskCode});
		somRule.newRecord({"taskCode":taskCode});
		//会费标准
		somFee.newRecord({"taskCode":taskCode});
		//电子档案
		somElectronicDataSet_load();
		somLegalPeopleElectronicDataSet_load();
		//流程意见
		somApplyDataSet.newRecord({"curActivity":"受理","taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"S","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId});
	}else{
		forUPdateLoad();
	}

	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
	uploadLegalPeopleListCloseEvent();

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

}
function forUPdateLoad(){
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadSession);
}
function loadSession(ds){
	ds.un("load",loadSession);
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = ds.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',loadRule);
}
function loadRule(ds){
	ds.un("load",loadRule);
	if(ds.getCount() == 0){
		ds.newRecord({"taskCode":taskCode,"seq":"1"});
	}
	somRule.setParameter("TASK_CODE", taskCode);
	somRule.load();
	somRule.on('load',loadFee);
}
function loadFee(ds){
	ds.un("load",loadFee);
	somFee.setParameter("TASK_CODE", taskCode);
	somFee.load();
	somFee.on('load',loadApply);
}
function loadApply(ds){
	ds.un("load",loadApply);
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadsomResumeDataSet);
}
function loadsomResumeDataSet(ds){
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',somResumeDataSetOnload);
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
//保存后加载页面中的简历回填onload事件
function somResumeDataSetOnload(ds){
	ds.un("load",somResumeDataSetOnload);
	somDutyDataSet.setParameter("TASK_CODE", taskCode);
	somDutyDataSet.load();
	somDutyDataSet.on('load',somDutyOnLoad);
}
function somDutyOnLoad(ds){
	ds.un("load",somDutyOnLoad);
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.removeAll();
	somResumeLegalDataSet.commitChanges();
	var peopleId="";
	var sorgOpinion="";
	var sorgCheckDate="";
	ds.each(function(record, index){
		if(record.get('sorgDuties') == "00012"){
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
	ds.filterBy(function(record, id){
		if(record.get('sorgDuties') != legalDuties){
			if(record.get('peopleId') == peopleId){
				legalRecord=record.copy();
				record.set("ifLegal","1");
				legalRecord.set("sorgOpinion",sorgOpinion);
				legalRecord.set("sorgCheckDate",sorgCheckDate);
				LegalPeopleDataSet.insert(0,legalRecord);
				LegalPeopleDataSet.set("dutyId",legalDutyId);
				document.getElementById("labelAge").innerHTML=getAgeByCode(legalRecord.get("idCard"));
				if(document.getElementById("labelAge").innerHTML==""){
					document.getElementById("labelAge").innerHTML=getAgeByBirthday(legalRecord.get("birthday"));
				}
				//synPhoto(LegalPeopleDataSet.get("photoId"),null);
				somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
			}
			return record;
		}
	});
	ds.commitChanges();
	//加载电子档案
	somElectronicDataSet_load();
	if(LegalPeopleDataSet.getCount()==0){
		LegalPeopleDataSet.newRecord();
	}
	somPartyMemberDataSet.setParameter('SORG_ID',sorgId);
	somPartyMemberDataSet.load();
	somPartyMemberDataSet.on('load',somPartyMemberOnLoad);
}
//保存按钮
function saveAll(){
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
		return;
	}
	//社会组织校验
	//var somOrganIsValidate = somOrganDataSet.isValidate();
	//if(somOrganIsValidate != true){
	//	L5.Msg.alert("提示",somOrganIsValidate);
	//	L5.getCmp("tab").setActiveTab("0");
	//	return false;
	//}
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
/*
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
	}*/
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
	//会费数据校验
	if(checkFee() == false){
		return false;
	}
	//会费校验
	var somFeeIsValidate = somFee.isValidate();
	if(somFeeIsValidate != true){
		L5.Msg.alert("提示",somFeeIsValidate);
		L5.getCmp("tab").setActiveTab("4");
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
	LegalPeopleRecord.set("photoText",_$("photoId"));//封装照片
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somRuleRecord=somRule.getCurrent();
	var somFeeRecord=somFee.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();
	/*
	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入负责人！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定法定代表人！");
		return;
	}
	*/
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	somRuleRecord.set("ifDraft","0");
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.group.cmd.SomGroupOnlineCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somFeeRecord", somFeeRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("somPartyMemberRecords",somPartyMemberDataSet.getAllRecords());
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	command.setParameter("somPartyPraiseRecords",somPartyPraiseDataSet.getAllRecords());
	if(method=="INSERT"){
		command.execute("saveBuild");
	}else{
		command.execute("updateBuild");
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			method="UPDATE";
			forUPdateLoad();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
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
		L5.Msg.alert('提示','请先填写“社会团体中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
//------------------负责人处理------------------------------
//点击上传人员附件按钮
function clickUploadPeopleFile(){
	if(sorgId == ""){
		L5.getCmp("peopleWin").setVisible(false);
		L5.Msg.alert('提示','请先填写“社会团体中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadPeopleFile();
}
//点击上传法定代表人员附件按钮
function clickUploadLegalPeopleFile(){
	if($("nameLabel").innerHTML == ""){
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
		//centerWin(win);
		win.setPosition(20,20);
	}
	command.execute('getDutyId');
}
function centerWin(win){
	L5.EventManager.onWindowResize(function(){
       win.center();
    });
}
//点击确定 保存一条负责人信息
function confirm(){
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//校验
	var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
	if(somDutyInsertValidate != true){
		L5.Msg.alert("提示",somDutyInsertValidate);
		return false;
	}
	var record=somDutyInsertDataSet.getCurrent();
		var name=record.get('name').trim();
    record.set("name",name);
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

		somLegalPeopleElectronicDataSet_load();//加载法定代表人法律要件
		}
	//处理个人简历完成
	var win=L5.getCmp("peopleWin");
	win.hide();
	updateRecord='';
}
//选定为法定代表人
function chooseLegal(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var photoId = records[0].get("photoId");
		var legalDutyIdSelected=records[0].get("dutyId");
		//如果不是其他社团法定代表人
		L5.MessageBox.confirm('确定', '选定[ '+records[0].get("name")+' ]为法定代表人？',function(sta){
			if(sta=="yes"){
				//如果法定代表人已经存在
	/*
				if(LegalPeopleDataSet.getCount() ==1){
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
							if(document.getElementById("labelAge").innerHTML==""){
								document.getElementById("labelAge").innerHTML=getAgeByBirthday(records[0].get("birthday"));
							}
							//同步照片
							//synPhoto(photoId,null);
							//回填简历信息
							createLegalResume(legalDutyIdSelected);
							//清空法定代表人法律要件并重载
							somLegalPeopleElectronicDeleteDataSet_load();
						}
						else return;
					});
					return;
				}
				*/
				//如果法定代表人还未选定
				records[0].set("ifLegal",'1');
				somDutyDataSet.commitChanges();
				LegalPeopleDataSet.removeAll();
				LegalPeopleDataSet.insert(0,records[0].copy());
				LegalPeopleDataSet.getCurrent().set('dutyId',legalDutyId);
				var idCard=records[0].get("idCard");
				document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
				if(document.getElementById("labelAge").innerHTML==""){
					document.getElementById("labelAge").innerHTML=getAgeByBirthday(records[0].get("birthday"));
				}
				//同步照片
				//synPhoto(photoId,null);
				//回填简历信息
				createLegalResume(legalDutyIdSelected);
				//加载法定代表人法律要件
				somLegalPeopleElectronicDataSet_load();
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
	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件

	var win = L5.getCmp("peopleWin");
	win.show();
	$("age").innerHTML = getAgeByCode(updateRecord.get('idCard'));
	if($("age").innerHTML==""){
		$("age").innerHTML=getAgeByBirthday(updateRecord.get("birthday"));
	}
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

//负责人录入中输入身份证号进行查询
function checkPeopleInfo(){
	var idCard=document.getElementById("idCard").value;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		//return;
	}
	if(_$('idCard')!=""){
		var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
		winPeopleDataSet.setParameter("ID_CARD@=",_$('idCard'));
		winPeopleDataSet.load();
		winPeopleDataSet.on("load",function(ds){
			if(ds.getCount() > 0){
				var win_peopleValidate=L5.getCmp("win_peopleValidate");
				win_peopleValidate.show();
			}

		});
	}
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

function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
//判断章程数据是否正确
function checkRule(){
	var flag=true;
	var realNum=somRule.get('realNum');
	var passNum=somRule.get('passNum');
	var nopassNum=somRule.get('nopassNum');
	var giveupNum=somRule.get('giveupNum');
	if(realNum==""){
		realNum=0;
	}
	if(passNum==""){
		passNum=0;
	}
	if(nopassNum==""){
		nopassNum=0;
	}
	if(giveupNum==""){
		giveupNum=0;
	}
	if(realNum != (parseInt(passNum)+parseInt(nopassNum)+parseInt(giveupNum))){
		L5.Msg.alert("提示","章程核准表中的人数逻辑不正确");
		flag = false;
	}
	return flag;
}
//判断章程数据是否正确
function checkFee(){
	var flag=true;
	var realNum=somFee.get('realNum');
	var passNum=somFee.get('passNum');
	var nopassNum=somFee.get('nopassNum');
	var giveupNum=somFee.get('giveupNum');
	if(realNum==""){
		realNum=0;
	}
	if(passNum==""){
		passNum=0;
	}
	if(nopassNum==""){
		nopassNum=0;
	}
	if(giveupNum==""){
		giveupNum=0;
	}
	if(realNum != (parseInt(passNum)+parseInt(nopassNum)+parseInt(giveupNum))){
		L5.Msg.alert("提示","会费标准备案表中的人数逻辑不正确");
		flag = false;
	}
	return flag;
}

//返回
function goBack(){
	history.go(-1);
}