var fileCode = "S074";
var dutyId='';
var initLegalRecord="";//法定代表人的record
function init(){
	if(method=="INSERT"){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode});
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgStatus":"00","sorgId":sorgId,"sorgType":"S","ifBranch":'0',"morgName":userId,"morgArea":morgArea});
		somApplyDataSet.newRecord({"sorgName":userId,"ifFinish":"0","taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"S","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId});
		//电子档案
		somElectronicDataSet_load();
		//guidePeopleInit();
	}else if(method=="UPDATE"){
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadOrgan);
		//guidePeopleInit();
	}
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();

	if(method=="INSERT" || method=="UPDATE"){
		dutyFilter();
	}
}
function loadOrgan(ds){
	ds.un('load',loadOrgan);
	somOrganDataSet.setParameter("SORG_ID",ds.get("sorgId"));
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadSession);
}
function loadSession(ds){
	ds.un('load',loadSession);
	$("cnName").value = ds.get("cnName");
	$("sorgCode").value = ds.get("sorgCode");
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("TASK_CODE",taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',loadResume);
}
function loadResume(ds){
	ds.set("cnName",userId);
	ds.set("sorgCode",sorgCode);
	ds.un('load',loadResume);
	var record=ds.getCurrent();
	//加载简历信息
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',loadDuty);
}
function loadDuty(ds){
	ds.un('load',loadDuty);
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var record=somSessionDataSet.getCurrent();
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.setParameter("SESSION_ID", record.get('sessionId'));
	somDutyDataSet.load();
	somDutyDataSet.on('load',loadElectronic);
}
function loadElectronic(ds){
	ds.un('load',loadElectronic);
	//电子档案
	somElectronicDataSet_load();
}
// 增加负责人
function add(){
	updateRecord='';
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.execute('getDutyId');
	dutyId = command.getReturn('dutyId');
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifServe":"1","ifLegal":"0","sorgType":"S","regStatus":"1"});
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.removeAll();
	somDutyInsertDataSet.set("startDate",_$("startDate"));
	L5.getCmp("peopleWin").show();
	L5.getCmp("tabSomOrgan").setActiveTab("0");
	initPhoto("1");//初始化照片
	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步理事法律要件
}
var updateRecord;
// 修改负责人
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
	L5.getCmp("peopleWin").show();
	L5.getCmp("tabSomOrgan").setActiveTab("0");
	var birthday=updateRecord.get("birthday");
	showAge(birthday);
	synPhoto(somDutyDataSet.get("photoId"),"1");//同步照片
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

	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步理事法律要件
}
// 删除负责人
function del(){
	var grid=L5.getCmp("peopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.remove(record);
}
// 查看负责人明细
function detail(){
	var grid=L5.getCmp("peopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record.copy());
	//个人简历处理
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
	somPeopleElectronicDataSet_load(fileCode,record.get('dutyId'));//同步法律要件
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(record.get("photoId"),"1");//同步照片
}
// 保存
function save(){
	if(_$("sessionName") == ""){
		L5.Msg.alert("提示","届次名称不能为空！");
		return false;
	}
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var somSessionDataSetIsValidate = somSessionDataSet.isValidate();
	if(somSessionDataSetIsValidate != true){
		L5.Msg.alert("提示",somSessionDataSetIsValidate);
		return false;
	}
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var somDutyDataSetValidate = somDutyDataSet.isValidate();
	if(somDutyDataSetValidate != true){
		L5.Msg.alert("提示",somDutyDataSetValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.managePeople.cmd.ManagePeopleCmd");
	command.setParameter("somSessionRecord", somSessionRecord);
	if(initLegalRecord!=""){
		somDutyDataSet.insert(somDutyDataSet.getCount(),initLegalRecord);
	}
	command.setParameter("somDutyRecord", somDutyDataSet.getAllRecords());
	var somOrganRecord = somOrganDataSet.getCurrent();
	command.setParameter("somOrganRecord", somOrganRecord);
	var somApplyRecord = somApplyDataSet.getCurrent();
	command.setParameter("somApplyRecord", somApplyRecord);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	if(method=="INSERT"){
		command.execute("changeRegPeople");
	}else if(method=="UPDATE"){
		command.execute("updateRegPeople");
	}

	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			//returnBack();
			if(method=="INSERT"){
				method="UPDATE";
				init();
			}
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
// 返回备案列表页面
function returnBack(){
	history.go(-1);
}
// 根据开始日期与任期回写结束日期
function setEndDate(){
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	var record=somSessionDataSet.getCurrent();
	var tenure=_$("tenure");
	//var startDate=_$("startDate");
	var startDate=_$('startDate');
	if(tenure!=""&&startDate!=""){
		var year=parseInt(startDate.substring(0,4))+parseInt(tenure);
		var month=startDate.substring(5,7);
		var day=startDate.substring(8,10);
		record.set("endDate", year+"-"+month+"-"+day);
	}
}

//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}

function guidePeopleInit(){
	L5.getCmp("peopleGrid").on("rowclick",function(grid,rowIndex,e){
		var record=grid.getSelectionModel().getSelected();
		if(record){
			var peopleId=record.get('peopleId');
			var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
			winDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
			winDutyDataSet.load();
			winDutyDataSet.on('load',function(){
				winDutyDataSet.filterBy(function(record, id){
					if("00012".indexOf(record.get('sorgDuties'))==-1){
						return record;
					}
				});
			});
		}
	});
	//过滤负责人职务：法定代表人
	sorgDutiesDS.filterBy(function(record, id){
		if("00012".indexOf(record.get('value'))==-1){
			return record;
		}
	});
}

function dutyFilter(){
	//社团职务过滤
	sorgDutiesDS.filterBy(function(record, id){
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
		if("00006".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00014".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00001".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00003".indexOf(record.get('value'))>-1){
			return record;
		}
		if("00015".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
// 关闭窗口
var resumeCount=0;
function confirmInfo(){
	var somDutyInsertDataSet=L5.DatasetMgr.lookup("somDutyInsertDataSet");
	var record=somDutyInsertDataSet.getCurrent();
	var name=record.get('name').trim();
    record.set("name",name);
	//校验
	var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
	if(somDutyInsertValidate != true){
		L5.Msg.alert("提示",somDutyInsertValidate);
		return false;
	}
	//维护照片信息
	if(_$("photoId1")){
		var newPhotoId = savePhoto(_$("photoId1"),"S");//保存照片到数据库并返回photoId
		if(newPhotoId!=null){
			somDutyInsertDataSet.set("photoId",newPhotoId);
		}
	}
	if(updateRecord != ""){
		somDutyDataSet.remove(updateRecord);
	}
	if(record.get('ifServe') == '0'){
		record.set("regStatus","2");
	}
	somDutyDataSet.insert(somDutyDataSet.getCount(),record);
	somDutyDataSet.commitChanges();
	//处理个人简历
	var somResumeDataSet = L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeInsertDataSet = L5.DatasetMgr.lookup("somResumeInsertDataSet");
	for(var i=somResumeInsertDataSet.getCount()-1;i>=0;i--){
		var somResumeInsertRecord =somResumeInsertDataSet.getAt(i);
		somResumeInsertRecord.set("dutyId",record.get("dutyId"));
		if(somResumeDataSet.indexOf(somResumeInsertRecord)==-1){
			somResumeDataSet.insert(resumeCount,somResumeInsertRecord);
			resumeCount++;
		    somResumeDataSet.commitChanges();
		}
	}

	L5.getCmp("peopleWin").setVisible(false);
	updateRecord='';
	save();
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
function checkCard(){
	if(_$("idCard")=="") return;
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
}
function showAge(){
	var birthday=_$("birthday");
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
// 数据校验
function checkData(){
	if(_$("idCard")==""){
		L5.Msg.alert('提示','身份证号不能为空！');
		return false;
	}
	if(_$("name")==""){
		L5.Msg.alert('提示','姓名不能为空！');
		return false;
	}
	if(_$("sex")==""){
		L5.Msg.alert('提示','性别不能为空！');
		return false;
	}
	if(_$("birthday")==""){
		L5.Msg.alert('提示','出生日期不能为空！');
		return false;
	}
	if(_$("sorgDuties")==""){
		L5.Msg.alert('提示','担任职务不能为空！');
		return false;
	}
	if(_$("ifPartyLeader")==""){
		L5.Msg.alert('提示','是否党政机关领导干部不能为空！');
		return false;
	}else if(_$("ifPartyLeader")=="1"){
		if(_$("promiseOrgan")==""||_$("promiseCode")==""){
			L5.Msg.alert('提示','批准机关和批准文号不能为空！');
			return false;
		}
	}
	return true;
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
	var somDutyInsertDataSet=L5.DatasetMgr.lookup("somDutyInsertDataSet");
	var peopleRecord=somDutyInsertDataSet.getCurrent();
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	//回填人员基础信息
	peopleRecord.set("peopleId",record.get("peopleId"));
	peopleRecord.set("idCard",record.get("idCard"));
	peopleRecord.set("name",record.get("name"));
	peopleRecord.set("aliasName",record.get("aliasName"));
	peopleRecord.set("sex",record.get("sex"));
	peopleRecord.set("folk",record.get("folk"));
	peopleRecord.set("birthday",record.get("birthday"));
	peopleRecord.set("nation",record.get("nation"));
	peopleRecord.set("politics",record.get("politics"));
	peopleRecord.set("education",record.get("education"));
	peopleRecord.set("populace",record.get("populace"));
	peopleRecord.set("birthplace",record.get("birthplace"));
	peopleRecord.set("adds",record.get("adds"));
	peopleRecord.set("postCode",record.get("postCode"));
	peopleRecord.set("phone",record.get("phone"));
	peopleRecord.set("ifPartyLeader",record.get("ifPartyLeader"));
	peopleRecord.set("ifRetire",record.get("ifRetire"));
	peopleRecord.set("workName",record.get("workName"));
	peopleRecord.set("workPhone",record.get("workPhone"));
	peopleRecord.set("workDuties",record.get("workDuties"));
	peopleRecord.set("profession",record.get("profession"));
	peopleRecord.set("ifFulltime",record.get("ifFulltime"));
	peopleRecord.set("resume",record.get("resume"));
	peopleRecord.set("photoId",record.get("photoId"));
	synPhoto(peopleRecord.get("photoId"),"1");//同步照片
	L5.getCmp("win_peopleValidate").setVisible(false);
}
//关闭人员索引窗口
function closeItem(){
	L5.getCmp("win_peopleValidate").setVisible(false);
}
function ifPartyLeaderChange(){
	if(_$("ifPartyLeader")=="1"){
		$("leaderTr").style.display="block";
	}else{
		$("promiseOrgan").value="";
		$("promiseCode").value="";
		$("partyLeaderLevel").value="";
		$("leaderTr").style.display="none";
	}
}
function ifServeChange(){
	if(_$("ifServe")=="0"){
		$("peopleEndDate").style.display="block";
	}else{
		$("peopleEndDate").value="";
		$("peopleEndDate").style.display="none";
	}
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
/**
 * 查询该登记证号的社会组织下面是否存在填写的届次名称
 * @param sorgCode 登记证号
 * @param sessionName  届次名称
 * @param sorgId  sorgId
 */
function findSessionExist(){
	if(document.getElementById('sorgCode').innerHTML.trim() == '' || document.getElementById('sessionName').value.trim() == ''){
		return;
	}
	somSessionQueryDataSet.setParameter("sorgCode",document.getElementById('sorgCode').innerHTML.trim());
	somSessionQueryDataSet.setParameter("sessionName",document.getElementById('sessionName').value.trim());
	somSessionQueryDataSet.setParameter("sorgId",sorgId);
	somSessionQueryDataSet.load();
	somSessionQueryDataSet.on('load',alertLog);
}
//提示信息
function alertLog(ds){
	ds.un('load',alertLog);
	var count=0;
	if(ds.getCount() > 0 ){
		for(var j=0;j<ds.getCount();j++){  //排除apply表中onlineStatus状态为删除（9）的记录
			somApplyDataSet1.setParameter("TASK_CODE",ds.getAt(j).get('TASK_CODE'));
			somApplyDataSet1.load(true);
			if(somApplyDataSet1.get("onlineStatus")!="9"){
				count++;
			}
		}
	}
	if(count>0){
		L5.Msg.alert("提示","该届次已经录入！");
		document.getElementById('sessionName').value = '';
		somSessionDataSet.set('sessionName','');
		return;
	}
}
