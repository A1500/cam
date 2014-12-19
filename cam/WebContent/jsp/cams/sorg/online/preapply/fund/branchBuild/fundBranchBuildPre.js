var fileCode = "J046";
var end=false;
var sorgId="";
function init() {
	L5.getCmp("tab").setActiveTab("0");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	//过滤流程意见
	opinionDataSet.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	//社团职务过滤
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
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
}
function loadInfo(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	sorgId = somApplyDataSet.get('sorgId');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
		validateSorgCode();
		var borgName = somOrganDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
		fillOrganInfo();
	});
	somSessionDataSet.setParameter("TASK_CODE@=", taskCode);
	somSessionDataSet.load();

	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
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
function save(){
	var name =_$("cnName");
	somOrganExistDataSet.setParameter("CN_NAME",name);
	//9为名称核准通过
	somOrganExistDataSet.setParameter("SORG_STATUS","9");
	somOrganExistDataSet.setParameter("SORG_TYPE","J");
	somOrganExistDataSet.load();
	somOrganExistDataSet.on('load',function(){
		if(somOrganExistDataSet.getCount() == 0){
			L5.Msg.alert("提示","该基金会名称尚未名称核准，无法进行设立登记！");
			somOrganDataSet.newRecord();
			return;
		}else{
			//如果查到的话将这笔预受理业务sorgid更新之前系统已经存在的那条数据的，因为筹备在保存的时候是做的update更新的名称核准的数据，taskcode不用更新
			sorgId=somOrganExistDataSet.get('sorgId');
			somOrganDataSet.getCurrent().set("sorgId",sorgId);
			somApplyDataSet.getCurrent().set("sorgId",sorgId);
			somSessionDataSet.getCurrent().set("sorgId",sorgId);
			//后台处理的时候会判断sessionId是否为空，为空会插入，否则就update，由于外网申请过来sessionId是不为空的，这里清空一下
			somSessionDataSet.getCurrent().set("sessionId","");

			var somDutyRecords=somDutyDataSet.getAllRecords();
			for(var i=0;i<somDutyRecords.length;i++){
				somDutyRecords[i].state = L5.model.Record.STATE_NEW;
				somDutyRecords[i].set("sorgId",sorgId);
				somDutyRecords[i].set("peopleId","");
			}
		}
		saveAllInfo();
	});
}
//保存
function saveAllInfo(){
	validateSorgCode();
	var somOrganRecord=somOrganDataSet.getCurrent();
	somOrganRecord.set("mainSorgId",_$("mainSorgId"));
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();

	var somOrganValidate = somOrganDataSet.isValidate();
	if(somOrganValidate != true){
		L5.Msg.alert("提示",somOrganValidate);
		return false;
	}
	//社团名称/中文
	/*if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}*/
	//社团邮编
	if(_isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
		return;
	}
	if(somDutyDataSet.getCount()==0){
		L5.Msg.alert("提示","请先录入分支(代表)机构负责人信息");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchBuildCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.execute("create");
	if(!command.error){
		L5.Msg.alert("提示","保存成功!",function(){
			updateOnlineStatusAccept();
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function submit(){
	var name =_$("cnName");
	somOrganExistDataSet.setParameter("CN_NAME",name);
	//9为名称核准通过
	somOrganExistDataSet.setParameter("SORG_STATUS","9");
	somOrganExistDataSet.setParameter("IF_BRANCH","1");
	somOrganExistDataSet.setParameter("SORG_TYPE","J");
	somOrganExistDataSet.load();
	somOrganExistDataSet.on('load',function(){
		if(somOrganExistDataSet.getCount() == 0){
			L5.Msg.alert("提示","该基金会名称尚未名称核准，无法进行设立登记！");
			somOrganDataSet.newRecord();
			return;
		}else{
			//如果查到的话将这笔预受理业务sorgid更新之前系统已经存在的那条数据的，因为筹备在保存的时候是做的update更新的名称核准的数据，taskcode不用更新
			sorgId=somOrganExistDataSet.get('sorgId');
			somOrganDataSet.getCurrent().set("sorgId",sorgId);
			somApplyDataSet.getCurrent().set("sorgId",sorgId);
			somSessionDataSet.getCurrent().set("sorgId",sorgId);
			//后台处理的时候会判断sessionId是否为空，为空会插入，否则就update，由于外网申请过来sessionId是不为空的，这里清空一下
			somSessionDataSet.getCurrent().set("sessionId","");

			var somDutyRecords=somDutyDataSet.getAllRecords();
			for(var i=0;i<somDutyRecords.length;i++){
				somDutyRecords[i].state = L5.model.Record.STATE_NEW;
				somDutyRecords[i].set("sorgId",sorgId);
				somDutyRecords[i].set("peopleId","");
			}
		}
		submitAllInfo();
	});
}
//保存并提交
function submitAllInfo() {
	validateSorgCode();
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganRecord=somOrganDataSet.getCurrent();
	somOrganRecord.set("mainSorgId",_$("mainSorgId"));
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();

	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();
	//if(method=="INSERT"){
		var somOrganValidate = somOrganDataSet.isValidate();
		if(somOrganValidate != true){
			L5.Msg.alert("提示",somOrganValidate);
			return false;
		}
		//社团名称/中文
		/*if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
			return;
		}*/
		//社团邮编
		if(_isPostCode(_$("sorgPost")) != true){
			L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
			return;
		}
	//}
	if(somDutyDataSet.getCount()==0){
		L5.Msg.alert("提示","请先录入分支(代表)机构负责人信息");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchBuildCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.execute("createAndSend");
	if(!command.error){
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
		updateOnlineStatusAccept();
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印不予受理通知
function printNoAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印受理通知
function printAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回
function goBack(){
	history.go(-1);
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
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称："+_$("cnName")+"已存在");
			$("cnName").value = "";
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
	if(typeof somPeopleElectronicDataSet != 'undefined'){
		somPeopleElectronicDataSet_load(fileCode,record.get('dutyId'));//同步人员法律要件
	}

	var win = L5.getCmp("peopleWin");
	win.show();
	L5.getCmp("peoplePanel1").setActiveTab("2");
	L5.getCmp("peoplePanel1").setActiveTab("1");
	L5.getCmp("peoplePanel1").setActiveTab("0");
	$("peopleAge").innerHTML = getAgeByCode(record.get("idCard"));
}

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
		$("mainSorgId").value = ds.get("sorgId");
		$("mainSorgCode").value = ds.get("sorgCode");
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
		somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件
		somResumeInsertDataSet.removeAll();
		//把负责人任职时间回填页面上的成立时间
		somDutyInsertDataSet.set("startDate",_$("startDate"));
		var win=L5.getCmp("peopleWin");
		win.show();
		document.getElementById("sorgDutiesNameDispaly").value = "分支机构负责人";
		var record=somDutyInsertDataSet.getCurrent();
		record.set('sorgDuties',"00002");
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
var isOnly = true;//判断是否已经添加了负责人
var peopleId=0;
var resumeCount=0;
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
	}
	);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}

///点击确定 保存一条负责人信息
function confirm(){
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
	var record=somDutyInsertDataSet.getCurrent();
	var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD@=",idCard);
	winPeopleDataSet.load();
	var win_peopleValidate=L5.getCmp("win_peopleValidate");
	win_peopleValidate.show();

}

//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
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
	if(_$("ifPartyLeader_add")=="1"){
		$('promiseOrgan_add').style.display="block";
		$('promiseCode_add').style.display="block";
	}else{
		$('promiseOrgan_add').style.display="none";
		$('promiseCode_add').style.display="none";
		$('promiseOrgan_add').value="";
		$('promiseCode_add').value="";
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
//保存
function saveApply(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchBuildCmd");
	var somApplyRecord = somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
	command.setParameter("somApplyRecord",somApplyRecord);
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
	if(act=="issue"){
		if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchBuildCmd");
	var somApplyRecord = somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		if(act=='issue' || end){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				goBack();
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				goBack();
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("branchSorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("branchSorgCode"));
		command.setParameter("sorgType","J");
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
			return;
		}
	}
}
//打印名称核准通知书
function printInform(){

}

var bool;
var mainSorgName;
var mainSorgId;
var mainSorgCode;
var fillOrganInfoName;
function fillOrganInfo(){
	var name = _$("cnName");
	fillOrganInfoName = name;
	bool = "false";
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
	mainSorgName=somOrganDataSet.get('name');
	mainSorgId=somOrganDataSet.get('mainSorgId');
	mainSorgCode=somOrganDataSet.get('mainSorgCode');
	//异地分支的，需要先名称核准才能异地分支申请，申请完后状态会改为15，此处成立状态为15也允许办分支成立登记
	somQueryOrganDataSet.setParameter("CN_NAME",name);
	somQueryOrganDataSet.setParameter("SORG_STATUS","15");
	somQueryOrganDataSet.setParameter("IF_BRANCH","1");
	somQueryOrganDataSet.load();
	somQueryOrganDataSet.on('load',somOrganOnLoadQueryAp);
}
function somOrganOnLoadQueryAp(){
		if(somQueryOrganDataSet.getCount() == 0){

		}else{
			bool = "true";
		}
		//如果查询异地分支没有通过，则查询名称核准是否通过的
		if(bool == "false"){
			//查询是否已经名称核准
			somQueryOrganDataSet.removeAll();
			somQueryOrganDataSet.setParameter("CN_NAME",fillOrganInfoName);
			somQueryOrganDataSet.setParameter("SORG_STATUS","9");
			somQueryOrganDataSet.setParameter("IF_BRANCH","1");
			somQueryOrganDataSet.load();
			somQueryOrganDataSet.on('load',somOrganOnLoadName);
		}
		somApplyDataSet.getCurrent().set("curOpinion","");
		somQueryOrganDataSet.un("load",somOrganOnLoadQueryAp);
	}

function somOrganOnLoadName(){
		if(somQueryOrganDataSet.getCount() == 0){
			//如果不是异地审批通过的，需要提示不能办理登记
			if(bool == "false"){
				L5.Msg.alert("提示","该基金会分支（代表）机构名称尚未成功核准或已经成立，无法进行登记！");
				somOrganDataSet.newRecord({"name":mainSorgName,"mainSorgCode":mainSorgCode,"mainSorgId":mainSorgId});
			}
		}
		somQueryOrganDataSet.un("load",somOrganOnLoadName);
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
		somApplyDataSet.getCurrent().set("curOpinion","基金会名称由 "+oldName+" 变更为 "+newName);
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