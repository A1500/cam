var legalRecord="";
var legalDuties="00012";
var sorgType="J";
var sorgCodeNum="";
var cnNameNum="";
var taskCode = "";
var applyType="219,220,221";
var fileCodeL="J016";//理事
var fileCodeS="J016";//监事
var fileCodeF="J015";
var peopleType="";
var currentId='';
var president='';//理事长
//初始化
function init() {
	var winDutyDataSet = L5.DatasetMgr.lookup("winDutyDataSet");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("6");
	L5.getCmp("tab").setActiveTab("7");
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"sorgId":sorgId,"sorgStatus":'22',"sorgType":"J","ifBranch":'0'});
		somSessionDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId});
		LegalPeopleDataSet.newRecord();
		somRuleDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId});
		somApplyDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId,"applyType":somApplyType,"dataSource":"MEND","sorgType":"J","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
		somElectronicDataSet_load();
	}else{
		loadInfo();
	}

	somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
	uploadLegalPeopleListCloseEvent();

	//过滤流程意见
	opinionSelect.filterBy(function(record, id){
		if("0,1".indexOf(record.get('value'))>-1){
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
	//过滤负责人职务：法定代表人
	sorgDutiesSelect.filterBy(function(record, id){
		if("00012".indexOf(record.get('value'))==-1){
			return record;
		}
	});
}
function loadInfo(){
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', function(){
		sorgId = somApplyDataSet.get('sorgId');
		taskCode = somApplyDataSet.get('taskCode');
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=", sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
			cnName=somOrganDataSet.get("cnName");
			sorgCode=somOrganDataSet.get("sorgCode");

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

		somSessionDataSet.setParameter("TASK_CODE", taskCode);
		somSessionDataSet.load();
		somSessionDataSet.on('load',function(){
			if(somSessionDataSet.getCount() == 0){
				somSessionDataSet.newRecord({"taskCode":taskCode,"seq":"1"});
			}
		});
		var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
		somRuleDataSet.setParameter("TASK_CODE", taskCode);
		somRuleDataSet.load();
		somRuleDataSet.on('load',function(){
			if(somRuleDataSet.getCount() == 0){
				somRuleDataSet.newRecord();
			}
		});

		somResumeInsertDataSet.setParameter("TASK_CODE", taskCode);
		somResumeLegalDataSet.removeAll();
		somResumeLegalDataSet.commitChanges();
		somResumeInsertDataSet.on("load",function(){
			aspForLiShi.setParameter("TASK_CODE", taskCode);
			aspForLiShi.setParameter("SORG_DUTIES@in", "00001,00003,00004,00005,00012");
			aspForLiShi.load();
			aspForLiShi.on('load',function(){
				document.getElementById("councilNum").innerHTML=aspForLiShi.getCount()-1;
				//加载法定代表人
				aspForLiShi.each(function(record, index){
					if(record.get('sorgDuties') == "00001"){
						president=record;
						document.getElementById('legalPeople').innerHTML=record.get('name');
						document.getElementById("labelAge").innerHTML = getAgeByCode(president.get('idCard'));
						//回填法定代表人简历
						var j=0;
						for(var i=somResumeInsertDataSet.getCount()-1;i>=0;i--){
							var somResumeRecord =somResumeInsertDataSet.getAt(i);
							if(record.get('dutyId') == somResumeRecord.get('dutyId')){
								somResumeLegalDataSet.insert(j,somResumeRecord);
								j++;
							}
						}
						//回填法定代表人简历结束
					}
					if(record.get('sorgDuties') == "00012"){
						legalDutyId=record.get("dutyId");
						LegalPeopleDataSet.removeAll();
						LegalPeopleDataSet.insert(0,record.copy());
						LegalPeopleDataSet.set("sorgDuties","00001");
						//LegalPeopleDataSet.set("dutyId",legalDutyId);
						//synPhotoDetail(president.get('photoId'),null);//同步照片
						somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
						aspForLiShi.remove(record);
					}
				});
			});

			aspForJianShi.setParameter("TASK_CODE", taskCode);
			aspForJianShi.setParameter("SORG_DUTIES", "00006");
			aspForJianShi.load();
			aspForJianShi.on('load',function(){
				document.getElementById("standCouncilNum").innerHTML=aspForJianShi.getCount();
			});
		});
		somResumeInsertDataSet.load();
		somElectronicDataSet_load();
		if(LegalPeopleDataSet.getCount() == 0){
			LegalPeopleDataSet.newRecord();
			initPhotoDetail(null);//初始化照片
		}

		somHeldPeopleDataSet.setParameter("TASK_CODE@=", taskCode);
		somHeldPeopleDataSet.load();
		somHeldOrganDataSet.setParameter("TASK_CODE@=", taskCode);
		somHeldOrganDataSet.load();
	});


}

//全部保存
function save(){
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
		return;
	}
	//登记日期
	if(!(document.getElementById("regDate").value)){
		L5.Msg.alert("提示","校验未通过："+"登记时间不能为空！");
		return;
	}
	//社会组织校验
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	//基金会邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"基金会邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//资金数额
	if(_$("regMon") != ''){
		var regMon = checkMoneyFix(_$("regMon"),2);
		if(regMon == "整数"){
			if(_$("regMon").length >8){
				L5.Msg.alert("提示","校验未通过："+"原始基金数额格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(regMon == false){
			L5.Msg.alert("提示","校验未通过："+"原始基金数额格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}

	//本届会期校验
	if(_$("tenure").trim() != ""){
		if(_$("tenure").length>2||!_isNum(_$("tenure"))){
			L5.Msg.alert("提示","校验未通过："+"本届会期应为整数，长度不能超过两位数");
			L5.getCmp("tab").setActiveTab("1");
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
	//发起人校验
	var somHeldPeopleDataSetValidate=somHeldPeopleDataSet.isValidate();
	if(somHeldPeopleDataSetValidate != true){
		L5.Msg.alert("提示",somHeldPeopleDataSetValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}
	var somHeldPeopleRecords=somHeldPeopleDataSet.getAllRecords();
	for(var i=0;i<somHeldPeopleRecords.length;i++){
		var idCard=somHeldPeopleRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}
	//发起组织校验
	var somHeldOrganDataSetDataSetValidate=somHeldOrganDataSet.isValidate();
	if(somHeldOrganDataSetDataSetValidate != true){
		L5.Msg.alert("提示",somHeldOrganDataSetDataSetValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//理事监事校验
	if(checkPeople() == false){
		return false;
	}
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("5");
		return false;
	}
	//章程数据校验
	if(checkRule() == false){
		return false;
	}

	var command = new L5.Command("com.inspur.cams.sorg.history.fund.cmd.SomFundHistoryCmd");
	//法人
	var organRecord = somOrganDataSet.getCurrent();
	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",document.getElementById('legalPeople').innerHTML);
	organRecord.set("councilNum",document.getElementById('councilNum').innerHTML);
	organRecord.set("standCouncilNum",document.getElementById('standCouncilNum').innerHTML);
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	command.setParameter("organRecord",organRecord);
	//法定代表人
	var LegalPeopleRecord = LegalPeopleDataSet.getCurrent().copy();

	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请录入理事长！");
		return;
	}

	//把法定代表人直接加入理事dataset
	LegalPeopleRecord.set("sorgDuties","00012");
	aspForLiShi.insert(aspForLiShi.getCount(),LegalPeopleRecord);
	command.setParameter("aspForLiShi",aspForLiShi.getAllRecords());
	//监事
	command.setParameter("aspForJianShi",aspForJianShi.getAllRecords());
	//个人简历
	somResumeInsertDataSet.clearFilter();
	command.setParameter("somResumeInsertDataSet",somResumeInsertDataSet.getAllRecords());
	//届次
	var somSessionRecord = somSessionDataSet.getCurrent();
	if(somSessionRecord.get('sessionName') == ''){
		L5.Msg.alert("提示","请录入届次信息");
		return;
	}
	command.setParameter("somSessionDataSet",somSessionRecord);

	//章程核准信息
	var somRuleRecord = somRuleDataSet.getCurrent();
	somRuleRecord.set("ifDraft","0");
	command.setParameter("somRuleRecord",somRuleRecord);
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	somApplyRecord.set("taskCode",taskCode);
	command.setParameter("somApplyRecord",somApplyRecord);

	command.setParameter("somHeldPeopleRecord", somHeldPeopleDataSet.getAllChangedRecords());
	command.setParameter("somHeldOrganRecord", somHeldOrganDataSet.getAllChangedRecords());
	//保存
	if(method=="INSERT"){
		command.execute("saveBuild");
	}else{
		command.execute("updateBuild");
	}
	if (!command.error) {
		L5.Msg.alert('提示','保存成功！',function(){
			//returnClick();
			method="UPDATE";
			loadInfo();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//返回
function returnClick(){
	if(method=="UPDATE"){
		var data=new L5.Map();
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
		data.put("searchSorgCode",_$("sorgCode"));
		url="jsp/cams/sorg/history/fund/mainBuild/fundHistoryBuildList.jsp";
		L5.forward(url,'',data);
	}else{
		history.go(-1);
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
//点击上传法定代表人员附件按钮
function clickUploadLegalPeopleFile(){
	if($("labelIdCard").innerHTML == ""){
		L5.Msg.alert('提示','请先选中法定代表人');
		return false;
	}
	uploadLegalPeopleFile();
}

function updateL(){
	peopleType='LU';
	var grid=L5.getCmp("peopleGrid");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	currentId=currentPeople.get('dutyId');
	initDutyL();
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());

	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	var sorgDuties=currentPeople.get('sorgDuties');
	var records=dutySelectDic.query("value",sorgDuties);
	if(records.length>0){
		var sorgDutiesText = records.items[0].get("text");
		document.getElementById("sorgDutiesNameDispaly").value = sorgDutiesText;
	}
	dutyDataSetWin.filterBy(function(record, id){
		if("00001,00003,00004,00005,00013".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").value = '';
		var nation = peopleInsertDataset.get('nation');
		var records = countrySelectDic.query("value",nation);
		if(records.length>0){
			var nationCode = records.items[0].get("text");
			document.getElementById("nation").value = nation;
			document.getElementById("nationDispaly").value = nationCode;
		}
	}
	L5.getCmp("peopleWin").setPosition(20,20);
	$("age").innerHTML = getAgeByCode(currentPeople.get('idCard'));
	//synPhoto(peopleInsertDataset.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet_load(fileCodeL,currentPeople.get('dutyId'));//同步理事法律要件
}
function delL(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				if(records[0].get('sorgDuties') == "00001"){
					president='';
					LegalPeopleDataSet.removeAll();
					LegalPeopleDataSet.setParameter("TASK_CODE@=","123");
					LegalPeopleDataSet.load();
					initPhotoDetail(null);//初始化照片
					somLegalPeopleElectronicDeleteDataSet_load();
					document.getElementById('legalPeople').innerHTML='';
					document.getElementById("labelAge").innerHTML = '';
					somResumeLegalDataSet.removeAll();
				}
				aspForLiShi.remove(records[0]);
				document.getElementById("councilNum").innerHTML=aspForLiShi.getCount();
				//删除此人的简历
				somResumeInsertDataSet.each(function(record, id){
					if(record.get('dutyId') == records[0].get('dutyId')){
						somResumeInsertDataSet.remove(record);
					}
				});
				//somResumeInsertDataSet.commitChanges();
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function updateS(){
	peopleType='SU';
	var grid=L5.getCmp("peopleGrid1");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	initDutyS();
	currentId=currentPeople.get('dutyId');
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());

	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('dutyId')){
			return record;
		}
	});

	L5.getCmp("peopleWin").show();
	var sorgDuties=currentPeople.get('sorgDuties');
	var records=dutySelectDic.query("value",sorgDuties);
	if(records.length>0){
		var sorgDutiesText = records.items[0].get("text");
		document.getElementById("sorgDutiesNameDispaly").value = sorgDutiesText;
	}
	L5.getCmp("peopleWin").setPosition(20,20);
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").value = '';
		var nation = peopleInsertDataset.get('nation');
		var records = countrySelectDic.query("value",nation);
		if(records.length>0){
			var nationCode = records.items[0].get("text");
			document.getElementById("nation").value = nation;
			document.getElementById("nationDispaly").value = nationCode;
		}
	}
	$("age").innerHTML = getAgeByCode(currentPeople.get('idCard'));
	//synPhoto(peopleInsertDataset.get("photoId"),"1");
	somPeopleElectronicDataSet_load(fileCodeL,currentPeople.get('dutyId'));//同步理事法律要件
}
function delS(){
	var grid = L5.getCmp('peopleGrid1');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				aspForJianShi.remove(records[0]);
				document.getElementById("standCouncilNum").innerHTML=aspForJianShi.getCount();
				//删除此人的简历
				somResumeInsertDataSet.each(function(record, id){
					if(record.get('dutyId') == records[0].get('dutyId')){
						somResumeInsertDataSet.remove(record);
					}
				});
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//增加一条简历
function addResume(){
	somResumeInsertDataSet.newRecord({"dutyId":currentId});
}
//删除一条简历
function delResume(){
	var grid = L5.getCmp('somResumeGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				somResumeInsertDataSet.remove(records[0]);
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//增加人员窗口中确认按钮
function confirm(){
	var record=peopleInsertDataset.getCurrent();
	record.set('sorgDuties',document.getElementById('sorgDuties').value);
	var IsValidate = peopleInsertDataset.isValidate();
	if(IsValidate != true){
		L5.Msg.alert("提示",IsValidate);
		return false;
	}
	var somResumeIsValidate = somResumeInsertDataSet.isValidate();
	if(somResumeIsValidate != true){
		L5.Msg.alert("提示",somResumeIsValidate);
		return false;
	}
	//维护照片信息
	if(_$("photoId1")){
		var newPhotoId = savePhoto(_$("photoId1"),"J");//保存照片到数据库并返回photoId
		if(newPhotoId!=null){
			peopleInsertDataset.set("photoId",newPhotoId);
		}
	}
	peopleInsertDataset.getCurrent().set("promiseOrgan",document.getElementById('promiseOrgan_add').value);
	peopleInsertDataset.getCurrent().set("promiseCode",document.getElementById('promiseCode_add').value);

	peopleInsertDataset.getCurrent().set("nation",document.getElementById('nation').value);
	//判断是否是理事长
	if(peopleInsertDataset.getCurrent().get('sorgDuties') == '00001'){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
		var pId = peopleInsertDataset.getCurrent().get('peopleId');
		if(pId == ""){
			pId = "无";
		}
		command.setParameter("peopleId",pId);
		command.setParameter("sorgType",sorgType);
		command.setParameter("sorgId",sorgId);
		command.execute("checkLegalPeopleRepeat");
		var flag=command.getReturn("flag");
		if(flag != "true"){
			L5.Msg.alert("提示", "此人"+flag+" 请重新选定！");
			return false;
		}
		if(president == ''){
			president=peopleInsertDataset.getCurrent();
			LegalPeopleDataSet.removeAll();
			LegalPeopleDataSet.insert(0,president.copy());
			LegalPeopleDataSet.set("dutyId",legalDutyId);
			document.getElementById('legalPeople').innerHTML=president.get('name');
			document.getElementById("labelAge").innerHTML = getAgeByCode(president.get('idCard'));
			synPhotoDetail(president.get('photoId'),null);//同步照片
			somLegalPeopleElectronicDataSet_load();//清空法定代表人法律要件并重载
			somResumeInsertDataSet.each(function(record, id){
				if(record.get('dutyId') == president.get('dutyId')){
					somResumeLegalDataSet.insert(somResumeLegalDataSet.getCount(),record);
				}
			});
		}else {
			if(peopleInsertDataset.getCurrent().get('dutyId') == president.get('dutyId')){
				president=peopleInsertDataset.getCurrent();
				LegalPeopleDataSet.removeAll();
				LegalPeopleDataSet.insert(0,president.copy());
				LegalPeopleDataSet.set("dutyId",legalDutyId);
				synPhotoDetail(president.get('photoId'),null);//同步照片
				somLegalPeopleElectronicDataSet_load();//清空法定代表人法律要件并重载
				document.getElementById('legalPeople').innerHTML=president.get('name');
				document.getElementById("labelAge").innerHTML = getAgeByCode(president.get('idCard'));
				somResumeLegalDataSet.removeAll();
				somResumeInsertDataSet.each(function(record, id){
					if(record.get('dutyId') == president.get('dutyId')){
						somResumeLegalDataSet.insert(somResumeLegalDataSet.getCount(),record.copy());
					}
				});
			}else{
				L5.Msg.alert("提示","理事长已经存在！");
				return false;
			}
		}
	}
	if(peopleType == "L"){
		aspForLiShi.insert(aspForLiShi.getCount(),peopleInsertDataset.getCurrent().copy());
		aspForLiShi.commitChanges();
		document.getElementById("councilNum").innerHTML=aspForLiShi.getCount();
	}else if(peopleType == "S"){
		aspForJianShi.insert(aspForJianShi.getCount(),peopleInsertDataset.getCurrent().copy());
		document.getElementById("standCouncilNum").innerHTML=aspForJianShi.getCount();
	}else if(peopleType == "LU"){
		if(currentPeople.get('sorgDuties') == '00001' && peopleInsertDataset.getCurrent().get('sorgDuties') != '00001'){
			president='';
			LegalPeopleDataSet.removeAll();
			LegalPeopleDataSet.setParameter("TASK_CODE@=","123");
			LegalPeopleDataSet.load();
			initPhotoDetail(null);//初始化照片
			document.getElementById('legalPeople').innerHTML='';
			document.getElementById("labelAge").innerHTML = '';
			somResumeLegalDataSet.removeAll();
		}
		aspForLiShi.remove(currentPeople);
		aspForLiShi.insert(aspForLiShi.getCount(),peopleInsertDataset.getCurrent().copy());
	}else if(peopleType == "SU"){
		aspForJianShi.remove(currentPeople);
		aspForJianShi.insert(aspForJianShi.getCount(),peopleInsertDataset.getCurrent().copy());
	}
	aspForLiShi.commitChanges();
	aspForJianShi.commitChanges();

	L5.getCmp("peopleWin").setVisible(false);
}
function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}
function countRender(value){
	if(value === undefined){
		value=0;
	}
	return "理事总人数: "+value+" 人";

}
function countRenderS(value){
	if(value === undefined){
		value=0;
	}
	return "监事总人数: "+value+" 人";

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
	var record=peopleInsertDataset.getCurrent();
	//如果为身份证号，获取出生日期和性别
	if(_$("idCard").length==18){
		record.set("sex",getSexByCode(_$("idCard")));
		record.set("birthday",getBirthByCode(_$("idCard")));
		showAge();
	}
	if(_$('idCard')!=""){
		var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
		winPeopleDataSet.setParameter("ID_CARD@=",idCard);
		winPeopleDataSet.load();
		winPeopleDataSet.on("load",function(ds){
			if(ds.getCount() > 0){
				var win_peopleValidate=L5.getCmp("win_peopleValidate");
				win_peopleValidate.show();
			}

		});
	}

}

function showAge(){
	var birthday=_$("birthday");
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	//peopleInsertDataset.removeAll();
	//var record = peopleInsertDataset.newRecord({"dutyId":currentId});
	var record = peopleInsertDataset.getCurrent();
	record.set("idCard",idCard);
	//回填性别
	record.set("sex",getSexByCode(idCard));
	//回填出生年月
	record.set("birthday",getBirthByCode(idCard));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCard);
	var win = L5.getCmp("win_peopleValidate");
	//初始化照片
	initPhoto("1");

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
	//peopleInsertDataset.removeAll();
	//var newRecord = peopleInsertDataset.newRecord({"dutyId":currentId});
	var newRecord = peopleInsertDataset.getCurrent();
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
	//newRecord.set("workPhone",record.get("workPhone"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("ifPartyLeader",record.get("ifPartyLeader"));
	//newRecord.set("resume",record.get("resume"));
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
	//synPhoto(newRecord.get("photoId"),"1");//同步照片

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
var cnNameNum='';
var sorgCodeNum='';
//校验登记证号是否重复
 function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.setParameter("sorgType","J");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"登记证号已存在");
			return;
		}
	}
}
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		command.setParameter("sorgId",sorgId);
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
}
//校验社会组织机构代码是否重复
//function organCodeUK(){
//	if(_$("organCode").trim() != ""){
//		var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
//		command.setParameter("organCode",_$("organCode"));
//		command.execute("organCodeUK");
//		organCodeNum = command.getReturn("organCodeNum");
//		if(organCodeNum != 0){
//			L5.Msg.alert("提示","校验未通过："+"输入的组织机构代码已存在");
//			return;
//		}
//	}
//}
//校验社团分支机构代码
function validateSorgCode(){
	$("name").innerHTML = "";
	$("legalPeople").innerHTML = "";
	$("mainSorgId").value = "";
	$("cnName").value = "";
	var mainSorgCode = _$("mainSorgCode");
	if(mainSorgCode.trim() == ""){
		return;
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	somMainOrganDataSet.setParameter("SORG_TYPE@=","J");
	somMainOrganDataSet.setParameter("SORG_CODE@=",mainSorgCode);
	somMainOrganDataSet.load();
	somMainOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			L5.Msg.alert("提示","输入的基金会登记证号不存在!");
			return ;
		}
		if(ds.get("sorgStatus") == "32" || ds.get("sorgStatus") == "62"){
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被注销，请重新输入！');
			return;
		}
		if(ds.get("sorgStatus") == "52"){
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被撤销，请重新输入！');
			ds.newRecord();
			return;
		}
		$("name").innerHTML = ds.get("cnName");
		$("legalPeople").innerHTML = ds.get("legalPeople");
		$("mainSorgId").value = ds.get("sorgId");
		$("mainSorgCode").value = ds.get("sorgCode");
		$("cnName").value = ds.get("cnName");
	});
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

// 增加个人简历
function addResume(){
	somResumeInsertDataSet.newRecord({"dutyId":currentId});
}
// 删除个人简历
function delResume(){
	var grid = L5.getCmp('somResumeGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				somResumeInsertDataSet.remove(records[0]);
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
//理事校验
function checkPeople(){
	var flag=true;
	var aspForLiShiIsValidate = aspForLiShi.isValidate();
	if(aspForLiShiIsValidate != true){
		L5.Msg.alert("提示",aspForLiShiIsValidate);
		flag = false;
	}
	var aspForJianShiIsValidate = aspForJianShi.isValidate();
	if(aspForJianShiIsValidate != true){
		L5.Msg.alert("提示",aspForJianShiIsValidate);
		flag = false;
	}
	return flag;
}
//判断章程数据是否正确
function checkRule(){
	var flag=true;
	var realNum=somRuleDataSet.get('realNum');
	var passNum=somRuleDataSet.get('passNum');
	var nopassNum=somRuleDataSet.get('nopassNum');
	var giveupNum=somRuleDataSet.get('giveupNum');
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
//增加一条人员备案
	function addL(){
		peopleType='L';
		initDutyL();
		L5.getCmp("peopleWin").show();
		dutyDataSetWin.filterBy(function(record, id){
		if("00001,00003,00004,00005,00013".indexOf(record.get('value'))>-1){
			return record;
		}
		});
		document.getElementById("sorgDutiesNameDispaly").value = "";
		L5.getCmp("peopleWin").setPosition(20,20);
		currentId=getReadomDutyId();
		peopleInsertDataset.removeAll();
		peopleInsertDataset.newRecord({"dutyId":currentId,"ifServe":"1","ifPartyLeader":"0","sorgType":"J","ifLegal":"0","regStatus":"1"});
		peopleInsertDataset.set("startDate",_$("startDate"));
		somResumeInsertDataSet.filterBy(function(record, id){
		});
		initPhoto("1");
		somPeopleElectronicDataSet_load(fileCodeL,currentId);//加载理事人员法律要件
	}

	function addS(){
		peopleType='S';
		initDutyS();
		L5.getCmp("peopleWin").show();
		document.getElementById("sorgDutiesNameDispaly").value = "监事";
		dutyDataSetWin.filterBy(function(record, id){
			if("00006".indexOf(record.get('value'))>-1){
				return record;
			}
		});
		L5.getCmp("peopleWin").setPosition(20,20);
		currentId=getReadomDutyId();
		peopleInsertDataset.removeAll();
		peopleInsertDataset.newRecord({"dutyId":currentId,"ifServe":"1","ifPartyLeader":"0","sorgType":"J","ifLegal":"0","regStatus":"1"});
		peopleInsertDataset.set("startDate",_$("startDate"));
		var record=peopleInsertDataset.getCurrent();
		record.set('sorgDuties',"00006");
		somResumeInsertDataSet.filterBy(function(record, id){
		});
		initPhoto("1");
		somPeopleElectronicDataSet_load(fileCodeS,currentId);//加载理事人员法律要件
	}

function getReadomDutyId(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.execute('getDutyId');
	return command.getReturn('dutyId');
}
// 增加筹备人（自然人）
function addHeldPeople(){
	somHeldPeopleDataSet.newRecord();
}
// 删除筹备人（自然人）
function delHelpPeople(){
	var record=somHeldPeopleDataSet.getCurrent();
	if(record!=null)
		somHeldPeopleDataSet.remove(record);
}
// 增加筹备人（单位）
function addHeldOrgan(){
	somHeldOrganDataSet.newRecord();
}
// 删除筹备人（单位）
function delHeldOrgan(){
	var record=somHeldOrganDataSet.getCurrent();
	if(record!=null){
		somHeldOrganDataSet.remove(record);
	}
}