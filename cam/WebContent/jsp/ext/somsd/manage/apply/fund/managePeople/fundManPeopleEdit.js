var president='';//理事长
var sorgDuties='00006';
var currentPeople = '';
function init(){
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'22',
			"sorgType":"J","ifBranch":'0',"morgName":userId,"morgArea":morgArea});
		somApplyDataSet.newRecord({"curActivity":"受理","taskCode":taskCode,
			"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"J",
				"acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});

		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode});
		//电子档案
		somElectronicDataSet_load();
	}else if(method =="UPDATE" ){
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadSomOrgan);
	}

	aspForLiShi.on('load',function(){
		aspForLiShi.filterBy(function(record, id){
			if("00001,00003,00004,00005,00013".indexOf(record.get('sorgDuties'))>-1){
				return record;
			}
		});
		toCurrentDataset();
	});
	aspForJianShi.on('load',function(){
		aspForJianShi.filterBy(function(record, id){
			if("00006".indexOf( record.get('sorgDuties') ) > -1){
				return record;
			}
		});
	});
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
}
function loadSomOrgan(ds){
	ds.un("load",loadSomOrgan);
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadSomSession);
}
function loadSomSession(ds){
	ds.un("load",loadSomSession);
	if(ds.getCount() > 0 ){
		document.getElementById('sorgCode').value = ds.get("sorgCode");
		document.getElementById('cnName').value = ds.get("cnName");
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("TASK_CODE",taskCode);
		somSessionDataSet.load();
		somSessionDataSet.on('load',loadDuty);
	}else{
		L5.Msg.alert("提示","社会组织信息加载出错!");
		return;
	}
}
function loadDuty(ds){
	ds.set("cnName",userId);
	ds.set("sorgCode",sorgCode);
	ds.un("load",loadDuty);
	//加载简历信息
	if(ds.getCount() > 0 ){
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somResumeInsertDataSet.setParameter("TASK_CODE",taskCode);
		somResumeInsertDataSet.load();
		somResumeInsertDataSet.on('load',loadLishi);
	}else{
		L5.Msg.alert("提示","届次信息加载出错!");
		return;
	}
}
function loadLishi(ds){
	ds.un("load",loadLishi);
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	aspForLiShi.setParameter("SESSION_ID", somSessionDataSet.get('sessionId'));
	aspForLiShi.load();
	aspForLiShi.on('load',loadJianshi);
}
function loadJianshi(ds){
	ds.un("load",loadJianshi);
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	aspForJianShi.setParameter("SESSION_ID",somSessionDataSet.get('sessionId'));
	aspForJianShi.load();
	aspForJianShi.on('load',loadElectron);
}
function loadElectron(ds){
	ds.un("load",loadElectron);
	//电子档案
	somElectronicDataSet_load();
}
// 修改负责人
function update(){
	somDutyDataSet.removeAll();
	var record=somDutyDataSet.newRecord();
	somDutyDataSet.remove(record);
	somDutyDataSet.insert(0,currentPeople.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	var birthday=currentPeople.get("birthday");
	showAge();
	synPhoto(somDutyDataSet.get("photoId"),"1");//同步照片
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").value = '';
		var nation = somDutyDataSet.get('nation');
		var records = countrySelectDic.query("value",nation);
		if(records.length == 1){
			var nationCode = records.items[0].get("text");
			document.getElementById("nation").value = nation;
			document.getElementById("nationDispaly").value = nationCode;
		}
	}
	//同步法律要件
	if(peopleType=="LU"){
		somPeopleElectronicDataSet_load(fileCodeL,currentPeople.get('dutyId'));
	}
	if(peopleType=="SU"){
		somPeopleElectronicDataSet.removeAll();
	}
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
function detailL(){
	peopleType="L";
	var grid=L5.getCmp("peopleGrid");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentRecord.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet_load(fileCodeL,currentRecord.get('dutyId'));//同步法律要件
}
// 查看负责人明细
function detailS(){
	peopleType="S";
	var grid=L5.getCmp("peopleGrid1");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentRecord.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet.removeAll();//同步法律要件
}
// 查看负责人明细
function detail(){
	var grid=L5.getCmp("peopleGrid2");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentRecord.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
}
// 保存
function save(){
	if(document.getElementById("sessionName").value.trim() == ''){
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

	var aspForLiShiIsValidate = aspForLiShi.isValidate();
	if(aspForLiShiIsValidate != true){
		L5.Msg.alert("提示",aspForLiShiIsValidate);
		return false;
	}
	var aspForJianShiIsValidate = aspForJianShi.isValidate();
	if(aspForJianShiIsValidate != true){
		L5.Msg.alert("提示",aspForJianShiIsValidate);
		return false;
	}
	var somSessionDataSetIsValidate = somSessionDataSet.isValidate();
	if(somSessionDataSetIsValidate != true){
		L5.Msg.alert("提示",somSessionDataSetIsValidate);
		return false;
	}
	var organRecord = somOrganDataSet.getCurrent();
	var applyRecord = somApplyDataSet.getCurrent();
	applyRecord	.set("sorgName",document.getElementById("cnName").innerHTML);

	//var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");
	command.setParameter("somSessionRecord", somSessionRecord);

	aspForLiShi.add(aspForJianShi.getAllRecords());
	command.setParameter("somDutyRecord", aspForLiShi.getAllRecords());
	//个人简历
	somResumeInsertDataSet.clearFilter();
	var somResumeRecords = somResumeInsertDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("organRecord",organRecord);
	command.setParameter("applyRecord",applyRecord);
	command.execute("saveManPeople");

	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			//returnBack();
			if(method=="INSERT"){
				method="UPDATE";
				init();
			}
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！");
	}
}
// 返回备案列表页面
function returnBack(){
	window.history.go(-1);
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

//----------------------------------------------------------------

//增加一条人员备案
function addL(){
	initDutyL();
	peopleType='L';
	add();
	sorgDuties = '00006';
}
function updateL(){
	var grid=L5.getCmp("peopleGrid");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	currentId=currentPeople.get('dutyId');
	initDutyL();
	peopleType='LU';
	update();
}
function delL(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				aspForLiShi.remove(records[0]);
				toCurrentDataset();
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
function addS(){
	initDutyS();
	peopleType='S';
	add();
	sorgDuties = '00006';
}
function updateS(){
	var grid=L5.getCmp("peopleGrid1");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	initDutyS();
	currentId=currentPeople.get('dutyId');
	peopleType='SU';
	update();
}
function delS(){
	var grid = L5.getCmp('peopleGrid1');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				aspForJianShi.remove(records[0]);
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
function countRenderF(value){
	if(value === undefined){
		value=0;
	}
	return "负责人总人数: "+value+" 人";
}
//同步加载负责人信息
function toCurrentDataset(){
	var records=aspForLiShi.getAllRecords();
	CurrentDataset.removeAll();
	CurrentDataset.add(records);
	CurrentDataset.filterBy(function(record, id){
		if("00001,00003,00004".indexOf(record.get('sorgDuties'))>-1){
			return record;
		}
	});
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
function confirm(){
	var IsValidate = somDutyDataSet.isValidate();
	if(IsValidate != true){
		L5.Msg.alert("提示",IsValidate);
		return false;
	}
	var record=somDutyDataSet.getCurrent();
		var name=record.get('name').trim();
	record.set("name",name);
	//维护照片信息
	if(_$("photoId1")){
		var newPhotoId = savePhoto(_$("photoId1"),"J");//保存照片到数据库并返回photoId
		if(newPhotoId!=null){
			somDutyDataSet.set("photoId",newPhotoId);
		}
	}
	if(record.get('ifServe')=='0'){
		record.set("regStatus","2");
	}
	record.set("nation",document.getElementById('nation').value);
	if(peopleType == "L"){
		aspForLiShi.insert(aspForLiShi.getCount(),somDutyDataSet.getCurrent().copy());
		toCurrentDataset();
	}else if(peopleType == "S"){
		aspForJianShi.insert(aspForJianShi.getCount(),somDutyDataSet.getCurrent().copy());
	}else if(peopleType == "LU"){
		aspForLiShi.remove(currentPeople);
		aspForLiShi.insert(aspForLiShi.getCount(),somDutyDataSet.getCurrent().copy());
		toCurrentDataset();
	}else if(peopleType == "SU"){
		aspForJianShi.remove(currentPeople);
		aspForJianShi.insert(aspForJianShi.getCount(),somDutyDataSet.getCurrent().copy());
	}
	aspForLiShi.commitChanges();
	aspForJianShi.commitChanges();

	L5.getCmp("peopleWin").setVisible(false);
	save();
}
function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}
function checkCard(){
	if(_$("idCardID")=="") return;
	//身份证号
	if(checkIDCard( document.getElementById("idCardID") ) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var record=somDutyDataSet.getCurrent();
	//如果为身份证号，获取出生年月和性别
	if(_$("idCardID").length==18){
		record.set("sex",getSexByCode(_$("idCardID")));
		record.set("birthday",getBirthdayByCode(_$("idCardID")));
		showAge();
	}
}
function showAge(){
	var birthday=_$("birthday");
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
