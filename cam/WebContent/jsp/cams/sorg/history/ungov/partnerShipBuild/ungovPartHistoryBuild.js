var legalRecord="";
var dutyId='';
//初始化
function init(){
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("6");
	L5.getCmp("tab").setActiveTab("0");
	if(method == "INSERT"){
		somOrganDataSet.newRecord();
		somApplyDataSet.newRecord({"acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
		LegalPeopleDataSet.newRecord();
		somRuleDataSet.newRecord();
		//同步法律要件
		somElectronicDataSet_load();
		//同步法定代表人法律要件
		somLegalPeopleElectronicDataSet_load();
	}
	if(method == "UPDATE"){
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
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

	//负责人window关闭时把数据清空
	L5.getCmp("peopleWin").on("beforehide",function(){
		updateRecord="";
	});
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadLegalPeopleListCloseEvent();
}
function loadInfo(){
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somApplyDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOfficeDataSet.setParameter("TASK_CODE", taskCode);
	somOfficeDataSet.load();
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			somSessionDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId});
		}

	});
	somRuleDataSet.setParameter("TASK_CODE", taskCode);
	somRuleDataSet.load();
	//同步法律要件
	somElectronicDataSet_load();

	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',function(){
		somDutyDataSet.setParameter("TASK_CODE", taskCode);
		somDutyDataSet.load();
		somDutyDataSet.on('load',function(){
			var peopleId="";
			var sorgOpinion="";
			var sorgCheckDate="";
			somDutyDataSet.each(function(record, index){
				if(record.get('sorgDuties') == "00012"){
					peopleId=record.get('peopleId');
					sorgOpinion=record.get("sorgOpinion");
					sorgCheckDate=record.get("sorgCheckDate");
					legalDutyId=record.get('dutyId');
				}
			});
			somDutyDataSet.filterBy(function(record, id){
				if(record.get('sorgDuties') != legalDuties){
					if(record.get('peopleId') == peopleId){
						legalRecord=record.copy();
						record.set("ifLegal","1");
						LegalPeopleDataSet.removeAll();
						LegalPeopleDataSet.insert(0,legalRecord);
						LegalPeopleDataSet.set("dutyId",legalDutyId);
						//synPhoto(LegalPeopleDataSet.get("photoId"),null);
						somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
					}
					return record;
				}
			});
			somDutyDataSet.commitChanges();

		});
	});
	//加载电子档案
	somElectronicDataSet_load();
	if(LegalPeopleDataSet.getCount()==0){
		LegalPeopleDataSet.newRecord();
	}
}
//保存按钮
function save(){
	//名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的民办非企业单位名称已存在");
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的民办非企业单位登记证号已存在");
		return;
	}
	//登记日期
	if(!(document.getElementById("regDate").value)){
		L5.Msg.alert("提示","校验未通过："+"登记日期不能为空！");
		return;
	}
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
	//资金数额
/*	if(_$("regMon") != ''){
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
 /*var LegalPeopleIsValidate = LegalPeopleDataSet.isValidate();
	if(LegalPeopleIsValidate != true){
		L5.Msg.alert("提示",LegalPeopleIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}	*/
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
	//基本信息
	var organRecord=somOrganDataSet.getCurrent();
	//负责人
	var somDutyRecords=somDutyDataSet.getAllRecords();
	//法定代表人
	var LegalPeopleRecord=LegalPeopleDataSet.getCurrent();
	//内设机构
	var somOfficeDataSetRds = somOfficeDataSet.getAllRecords();
	//章程核准
	var somRuleRecord=somRuleDataSet.getCurrent();
	//处理意见
	var somApplyRecord=somApplyDataSet.getCurrent();
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	//届次信息
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet")
	var somSessionRecord=somSessionDataSet.getCurrent();

	if(somDutyDataSet.getCount() == 0){
		L5.Msg.alert('提示',"请录入单位领导成员！");
		return;
	}
	if(LegalPeopleRecord.get('name') == ''){
		L5.Msg.alert('提示',"请选定负责人！");
		return;
	}

	organRecord.set("sorgId",sorgId);
	organRecord.set("legalPeople",LegalPeopleRecord.get("name"));
	organRecord.set("borgName",somApplyRecord.get("borgName"));
	organRecord.set("sorgKind","2");
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	LegalPeopleRecord.set("photoText",_$("photoId"));//封装照片
	somApplyRecord.set("taskCode",taskCode);
	somApplyRecord.set("applyType",applyType);
	somApplyRecord.set('borgName',document.getElementById("borgName").value);

	var command = new L5.Command("com.inspur.cams.sorg.history.ungov.cmd.SomUngovHistoryCmd");
	command.setParameter("organRecord", organRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	command.setParameter("LegalPeopleRecord", LegalPeopleRecord);
	command.setParameter("somOfficeDataSetRds",somOfficeDataSetRds);
	command.setParameter("somRuleRecord", somRuleRecord);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("somSessionRecord", somSessionRecord);
	if(method=="INSERT"){
		command.execute("insertBuildInfo");
	}else {
		command.execute("updateBuildInfo");
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			//goBack();
			method="UPDATE";
			somApplyDataSet.setParameter("TASK_CODE",taskCode);
			somApplyDataSet.load();
			somApplyDataSet.on('load', loadInfo);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//返回按钮
function goBack(){
	var data=new L5.Map();
	var url="";
	data.put("searchSorgCode",searchSorgCode);
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	url="jsp/cams/sorg/history/ungov/partnerShipBuild/ungovPartHistoryBuildList.jsp";
	L5.forward(url,'',data);
}
//------------------负责人处理------------------------------
//点击上传法定代表人员附件按钮
function clickUploadLegalPeopleFile(){
	if($("legalName").value == ""){
		L5.Msg.alert('提示','请先选中负责人');
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
		win.setPosition(20,20);
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
//选定为法定代表人
function chooseLegal(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var photoId = records[0].get("photoId");
		var legalDutyIdSelected=records[0].get("dutyId");
		L5.MessageBox.confirm('确定', '选定[ '+records[0].get("name")+' ]为负责人？',function(sta){
			if(sta=="yes"){
				//如果法定代表人已经存在
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
							//synPhoto(photoId,null);
							//清空法定代表人法律要件
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
				LegalPeopleDataSet.getCurrent().set('dutyId',legalDutyId);
				//同步照片
				//synPhoto(photoId,null);
				//清空法定代表人法律要件
				somLegalPeopleElectronicDataSet_load();
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

var resumeCount=0;
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
		somLegalPeopleElectronicDataSet_load();//清空法定代表人法律要件并重载
		}
	//处理个人简历完成
	var win=L5.getCmp("peopleWin");
	win.hide();
	updateRecord='';
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
	var win = L5.getCmp("win_peopleValidate");
	win.hide();

}
//关闭任职信息窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//内设机构--------------------------------------------------
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
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	var winOfficeDataSetIsValidate = winOfficeDataSet.isValidate();
	if(winOfficeDataSetIsValidate != true){
		L5.Msg.alert("提示",winOfficeDataSetIsValidate);
		return false;
	}
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
//render渲染-----------------------------------------------
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
//onchange事件-----------------------------------------------
//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
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
	//如果为身份证号，获取出生日期和性别
	if(_$("idCard").length==18){
		record.set("sex",getSexByCode(_$("idCard")));
		record.set("birthday",getBirthByCode(_$("idCard")));
		showAge();
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
function showAge(){
	var birthday=_$("birthday");
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
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
//校验社会组织名称是否重复
var cnNameNum="";
var sorgCodeNum="";
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
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.setParameter("sorgType","M");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"登记证号已存在");
			return;
		}
	}
}