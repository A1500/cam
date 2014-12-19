var fileCode = "J046";
function init() {
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"sorgId":sorgId,"sorgType":"J","ifBranch":"1","sorgStatus":"22"});
		somApplyDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId,"applyType":somApplyType,"dataSource":"MEND","sorgType":"J","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
		somSessionDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId});
	}else{
		loadInfo();
	}
	dutyDataSetWin.filterBy(function(record, id){
		if("00002".indexOf(record.get('value'))>-1){
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
	//电子档案上传窗口关闭事件
	somElectronicDataSet_load();
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
}
function loadInfo(){
	$("mainSorgCode").disabled=true;
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.load();

	somOrganDataSet.setParameter("SORG_ID", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
			$("mainSorgId").value = ds.get("mainSorgId");
			$("name").innerHTML = ds.get("name");

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

	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',function(){
		somDutyDataSet.setParameter("TASK_CODE", taskCode);
		somDutyDataSet.load();
		somDutyDataSet.on('load',function(){
			if(somDutyDataSet.getCount() > 0){
				isOnly = false;
			}
		});
	});
	somElectronicDataSet_load();
}
//保存
function save(){
	//社团名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
		return;
	}
	var somOrganRecord=somOrganDataSet.getCurrent();
	somOrganRecord.set("mainSorgId",_$("mainSorgId"));
	somOrganRecord.set("mainSorgCode",_$("mainSorgCode"));
	somOrganRecord.set("cnName",_$("cnName"));
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();

	var somApplyDataSetValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetValidate != true){
		L5.Msg.alert("提示",somApplyDataSetValidate);
		return false;
	}
	var somSessionDataSetValidate = somSessionDataSet.isValidate();
	if(somSessionDataSetValidate != true){
		L5.Msg.alert("提示",somSessionDataSetValidate);
		return false;
	}
	var somOrganValidate = somOrganDataSet.isValidate();
	if(somOrganValidate != true){
		L5.Msg.alert("提示",somOrganValidate);
		return false;
	}

	var somSessionIsValidate = somSessionDataSet.isValidate();
	if(somSessionIsValidate != true){
		L5.Msg.alert("提示",somSessionIsValidate);
		L5.getCmp("tab").setActiveTab("1");
		return false;
	}

	//社团邮编
	if(_$("sorgPost")!=""){
		if(_isPostCode(_$("sorgPost")) != true){
			L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
			return;
		}
	}

	var command = new L5.Command("com.inspur.cams.sorg.history.fund.cmd.SomFundHistoryCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	//somOrganRecord.set("mainSorgName",somMainOrganDataSet.get('cnName'));
	//somOrganRecord.set("mainSorgCode",somMainOrganDataSet.get('sorgCode'));
	//somOrganRecord.set("legalPeople",somMainOrganDataSet.get('legalPeople'));
	//somOrganRecord.set("mainSorgId",somMainOrganDataSet.get('sorgId'));
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}

	if(somSessionRecord.get('sessionName') == ''){
		L5.Msg.alert("提示","请录入届次信息");
		return;
	}

	if(somDutyDataSet.getCount()==0){
		L5.Msg.alert("提示","请先录入分支(代表)机构负责人信息");
		return;
	}

	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	if(method=="INSERT"){
		command.execute("saveBranchBuild");
	}else{
		command.execute("updateBranchBuild");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功!",function(){
			//goBack();
			method="UPDATE";
			loadInfo();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//返回
function goBack(){
	if(method=="UPDATE"){
		var data=new L5.Map();
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
		data.put("searchSorgCode",_$("branchSorgCode"));
		url="jsp/cams/sorg/history/fund/branchBuild/fundBranchHistoryBuildList.jsp";
		L5.forward(url,'',data);
	}else{
		history.go(-1);
	}
}
//向dataset中增加数据
function addRecordToDataset(dataset,record){
	var methodName=window.dialogArguments.methodName;
	var ret=window.dialogArguments.activityList;
	dataset.removeAll();
	dataset.add(record);
}
function getValue() {
	//如果起先数据为空，则直接调用增加方法
	if(somOrganDataSet.getCount()==0){
		somOrganDataSet.newRecord();
		return;
	}
}
var sorgCodeNum = "";
var cnNameNum = "";
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

function validateIdcard(){
	if(_$("idCard") != ""){
		if(checkIDCard($("idCard")) == true){
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}
}
//查看负责人
function detailPeople(){
	var grid = L5.getCmp("peopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record);

	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('dutyId')==somResumeRecord.get('dutyId')){
			somResumeInsertDataSet.insert(j,somResumeRecord);
			j++;
		}
	}

	var win = L5.getCmp("peopleWin");
	win.show();
	$("peopleAge").innerHTML = getAgeByCode(record.get("idCard"));
	somPeopleElectronicDataSet_load(fileCode,record.get('dutyId'));//同步人员法律要件
}
var sorgCode='';
function valid_ifPartyLeader_win(){
	if(_$("ifPartyLeader_win") == "1"){
		$("promiseCode_win").style.display = "block";
		$("promiseOrgan_win").style.display = "block";
	}else{
		$("promiseCode_win").value = "";
		$("promiseOrgan_win").value = "";
		$("promiseCode_win").style.display = "none";
		$("promiseOrgan_win").style.display = "none";
	}
}

function validateIdcard_win(){
	if(_$("idCard_add") == ""){
		return;
	}
	if(_$("cardType_add") == "01"){
		if(checkIDCard($("idCard_add")) == true){
			var cardTypeValue = _$("cardType_add");
			var idCardValue = _$("idCard_add");
			var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet2");
			winPeopleDataSet.setParameter("CARD_TYPE@=",cardTypeValue);
			winPeopleDataSet.setParameter("ID_CARD@=",idCardValue);
			winPeopleDataSet.load();
			winPeopleDataSet.on("load",function(ds){
				if(ds.getCount() != 0){
					var winMemberDataSet = L5.DatasetMgr.lookup("winMemberDataSet2");
					winMemberDataSet.removeAll();
					var win = L5.getCmp("win_peopleValidate2");
					win.show();
				}else{
					var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
					winPresidePeopleDataSet.removeAll();
					var rd = winPresidePeopleDataSet.newRecord();
					rd.set("cardType",cardTypeValue);
					rd.set("idCard",idCardValue);
					rd.set("sex",getSexByCode(idCardValue));
					rd.set("birthday",getBirthByCode(idCardValue));
				}
			});
			var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
			var record = winPresidePeopleDataSet.getCurrent();
			//回填性别
			record.set("sex",getSexByCode(idCardValue));
			//回填出生年月
			record.set("birthday",getBirthByCode(idCardValue));
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}else{
		var cardTypeValue = _$("cardType_add");
		var idCardValue = _$("idCard_add").toUpperCase();
		var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet2");
		winPeopleDataSet.setParameter("CARD_TYPE@=",cardTypeValue);
		winPeopleDataSet.setParameter("ID_CARD@=",idCardValue);
		winPeopleDataSet.load();
		winPeopleDataSet.on("load",function(ds){
			if(ds.getCount() != 0){
				var winMemberDataSet = L5.DatasetMgr.lookup("winMemberDataSet2");
				winMemberDataSet.removeAll();
				var win = L5.getCmp("win_peopleValidate2");
				win.show();
			}else{
				var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
				winPresidePeopleDataSet.removeAll();
				var rd = winPresidePeopleDataSet.newRecord();
				rd.set("cardType",cardTypeValue);
				rd.set("idCard",idCardValue);
			}
		});
	}
}
function validateSorgCode(){
	$("name").innerHTML = "";
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
		$("mainSorgId").value = ds.get("sorgId");
		$("mainSorgCode").value = ds.get("sorgCode");
		$("cnName").value = ds.get("cnName");
	});
}
//------------------负责人处理------------------------------
var dutyId='';
//增加负责人按钮
function add(){
	updateRecord='';
	if(!isOnly){
		L5.Msg.alert("提示","只能新增一位分支机构负责人!");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.afterExecute=function(){
		dutyId = command.getReturn('dutyId');
		somDutyInsertDataSet.removeAll();
		somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifLegal":"0","sorgType":"J","regStatus":"1","taskCode":taskCode});
		var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
		//把负责人任职时间回填页面上的成立时间
		somDutyInsertDataSet.set("startDate",_$("startDate"));
		somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件
		somResumeInsertDataSet.removeAll();
		var win=L5.getCmp("peopleWin");
		win.show();
		document.getElementById("sorgDutiesNameDispaly").value = "分支机构负责人";
		var record=somDutyInsertDataSet.getCurrent();
		record.set('sorgDuties',"00002");
		win.setPosition(20,20);
	}
	command.execute('getDutyId');
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
	win.setPosition(20,20);
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").value = '';
		var nation = somDutyInsertDataSet.get('nation');
		var records = countrySelectDic.query("value",nation);
		if(records.length>0){
			var nationCode = records.items[0].get("text");
			document.getElementById("nation").value = nation;
			document.getElementById("nationDispaly").value = nationCode;
		}
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
				isOnly = true;
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
var isOnly = true;//判断是否已经添加了负责人
var peopleId=0;
var resumeCount=0;
///点击确定 保存一条负责人信息
function confirm(){
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//校验
	var record=somDutyInsertDataSet.getCurrent();
	record.set('sorgDuties',document.getElementById('sorgDuties').value);
	var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
	if(somDutyInsertValidate != true){
		L5.Msg.alert("提示",somDutyInsertValidate);
		return false;
	}
	var record=somDutyInsertDataSet.getCurrent();
	record.set("ifServe","1");
	record.set("promiseOrgan",document.getElementById('promiseOrgan_add').value);
	record.set("promiseCode",document.getElementById('promiseCode_add').value);
	record.set("nation",document.getElementById('nation').value);
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
	//处理个人简历完成
	var win=L5.getCmp("peopleWin");
	win.hide();
	updateRecord='';
	isOnly = false;
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
	var newRecord =somDutyInsertDataSet.getCurrent();
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
		document.getElementById('promiseOrgan_add').style.display="block";
		document.getElementById('promiseCode_add').style.display="block";
	}else{
		document.getElementById('promiseOrgan_add').style.display="none";
		document.getElementById('promiseCode_add').style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
	}
}
//负责人窗户关闭
function winClosePeople(){
	var win = L5.getCmp("peopleWin");
	win.hide();
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
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("branchSorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("branchSorgCode"));
		command.setParameter("sorgType","J");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
			return;
		}
	}
}