var president='';//理事长
var sorgDuties='00006';
var currentPeople = '';
var sorgId='';
var sessionId = '';
var initLegalRecord="";//法定代表人的record
function init(){
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',findOnlineOrgan);	
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
	
	aspForLiShiQuery.on('load',function(){
		var peopleId='';
		aspForLiShiQuery.each(function(record, index){
			if(record.get('sorgDuties') == "00012" && record.get('regStatus')=="1"){
				initLegalRecord=record;
				peopleId=record.get('peopleId');
			}
		});
		aspForLiShiQuery.filterBy(function(record, id){
			if(record.get('sorgDuties') != "00012"){
				if(record.get('peopleId') == peopleId){
					record.set('ifLegal','1');
				}
				aspForLiShiQuery.commitChanges();
				return record;
			}
		});
		aspForLiShiQuery.filterBy(function(record, id){
			if("00001,00003,00004,00005,00013".indexOf(record.get('sorgDuties'))>-1){
				return record;
			}
		});
	});
	aspForJianShiQuery.on('load',function(){
		aspForJianShiQuery.filterBy(function(record, id){
			if("00006".indexOf( record.get('sorgDuties') ) > -1){
				return record;
			}
		});
	});
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
}
//查询出交换过来的社会组织的登记证号
function findOnlineOrgan(ds){
	ds.un('load',findOnlineOrgan);
	var applyRecord= ds.getCurrent();
	sorgId=applyRecord.get('sorgId');
	somOrganQueryDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganQueryDataSet.load();
	somOrganQueryDataSet.on('load',findSorg);
}
//找到正式库里的社会组织
function findSorg(ds){
	ds.un('load',findSorg);
	if( ds.getCount() > 0 ){
		var sorgCode = ds.get("sorgCode");
		document.getElementById('sorgCode').value= sorgCode;
		somOrganDataSet.setParameter("SORG_CODE",sorgCode);
		somOrganDataSet.setParameter("SORG_STATUS",'22');
		somOrganDataSet.setParameter("SORG_TYPE",'J');
		somOrganDataSet.load();
		somOrganDataSet.on('load',findSorgName);
	}else{
		L5.Msg.alert("提示","数据交换有误！没有找到此社会组织的信息！");
		somSessionDataSet.setParameter("SORG_ID",sorgId);
		somSessionDataSet.load();
		
		somSessionDataSet.on('load',loadTrueResume);
		return false;
	}
}
function findSorgName(ds){
	ds.un("load",findSorgName);
	var num=ds.getCount();
	if(num==0){
		L5.Msg.alert("提示","登记证号不存在，请重新输入！");
		sorgId='';
		document.getElementById('cnName').innerHTML='';
		//somSessionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		somApplyDataSet.set('borgName','');
		return;
	}else{
		sorgId=ds.get('sorgId');
		//somSessionDataSet.set('sorgId',sorgId);
		document.getElementById('cnName').innerHTML=ds.get('cnName');
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',sorgId);
		somApplyDataSet.set('borgName',ds.get('borgName'));
		
			
		somSessionDataSet.setParameter("SORG_ID",sorgId);
		somSessionDataSet.load();
		
		somSessionDataSet.on('load',loadTrueResume);
	}
}
//加载届中的简历
function loadTrueResume(ds){
	ds.un("load",loadTrueResume);
	if(ds.getCount() > 0){
		sessionId = ds.get("sessionId");
		var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
		somResumeDataSet.setParameter("TASK_CODE", ds.get("taskCode"));
		somResumeDataSet.load();
		somResumeDataSet.on('load', loadLishiTrue);
	}else{
		L5.Msg.alert("提示","数据交换有误！没有找到此社会组织的届次信息！");
		return ;
	}
}
//加载理事
function loadLishiTrue(ds){
	ds.un("load",loadLishiTrue);
	aspForLiShiQuery.setParameter("SESSION_ID", sessionId);
	aspForLiShiQuery.load();
	aspForLiShiQuery.on('load',loadJianshiTrue);
}
//加载监事
function loadJianshiTrue(ds){
	ds.un("load",loadJianshiTrue);
	aspForJianShiQuery.setParameter("SESSION_ID",sessionId);
	aspForJianShiQuery.load();
	aspForJianShiQuery.on('load',loadLishi);
}
//加载理事
function loadLishi(ds){
	ds.un("load",loadLishi);
	aspForLiShi.setParameter("TASK_CODE", taskCode);
	aspForLiShi.load();
	aspForLiShi.on('load',loadJianshi);
}
//加载监事
function loadJianshi(ds){
	ds.un("load",loadJianshi);
	var somDutyRecords=ds.getAllRecords();
	for(var i=0;i<somDutyRecords.length;i++){
		somDutyRecords[i].state = L5.model.Record.STATE_NEW;
		//将peopleId置空，否则后台会判断peopleId为空的时候才出入，否则更新，peopleId不置空导致people信息插不进去
		somDutyRecords[i].set("peopleId","");
	}
	aspForJianShi.setParameter("TASK_CODE", taskCode);
	aspForJianShi.load();
	aspForJianShi.on('load',loadResume);
}
//加载这次申请提交的人员简历
function loadResume(ds){
	ds.un("load",loadResume);
	var somDutyRecords=ds.getAllRecords();
	for(var i=0;i<somDutyRecords.length;i++){
		somDutyRecords[i].state = L5.model.Record.STATE_NEW;
		//将peopleId置空，否则后台会判断peopleId为空的时候才出入，否则更新，peopleId不置空导致people信息插不进去
		somDutyRecords[i].set("peopleId","");
	}
	var somResumeQueryDataSet=L5.DatasetMgr.lookup("somResumeQueryDataSet");
	somResumeQueryDataSet.setParameter("TASK_CODE", taskCode);
	somResumeQueryDataSet.load();
	somResumeQueryDataSet.on('load', addTogether);
}
//把人员和简历汇总在一起显示
function addTogether(ds){
	ds.un("load",addTogether);
	aspForLiShi.add(aspForLiShiQuery.getAllRecords());
	aspForJianShi.add(aspForJianShiQuery.getAllRecords());
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.add(somResumeQueryDataSet.getAllRecords());
	toCurrentDataset();
	//电子档案
	somElectronicDataSet_load();
}	
//输入登记证号，加载社会组织名称
function fillSorgInfo(){
	var sorgCode=document.getElementById('sorgCode').value;
	somOrganDataSet.removeAll();
	if(sorgCode == '' ){
		return ;
	}else{
		somOrganDataSet.setParameter("SORG_CODE",sorgCode);
		somOrganDataSet.setParameter("SORG_STATUS",'22');
		somOrganDataSet.setParameter("SORG_TYPE",'J');
		somOrganDataSet.load();
		somOrganDataSet.on('load',getSorgName);
	}
}
//获取社会组织名称
function getSorgName(ds){
	ds.un("load",getSorgName);
	var num=ds.getCount();
	if(num==0){
		L5.Msg.alert("提示","登记证号不存在，请重新输入！");
		sorgId='';
		document.getElementById('cnName').innerHTML='';
		//somSessionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		somApplyDataSet.set('borgName','');
		return;
	}else{
		sorgId=ds.get('sorgId');
		//somSessionDataSet.set('sorgId',sorgId);
		document.getElementById('cnName').innerHTML=ds.get('cnName');
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',sorgId);
		somApplyDataSet.set('borgName',ds.get('borgName'));
	}
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
	if(_$("sorgCode") == ''){
		L5.Msg.alert("提示","请填写社会组织登记证号！");
		return false;
	}
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
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
	
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.setParameter("somSessionRecord", somSessionRecord);
	
	aspForLiShi.add(aspForJianShi.getAllRecords());
	if(initLegalRecord!=""){
		initLegalRecord.set("sorgId",sorgId);
		aspForLiShi.insert(aspForLiShi.getCount(),initLegalRecord);
	}
	
	var records = aspForLiShi.getAllRecords();
	command.setParameter("somDutyRecord",records);
	//个人简历
	somResumeInsertDataSet.clearFilter();
	var somResumeRecords = somResumeInsertDataSet.getAllRecords();
	for (var i = 0;i<somResumeRecords.length;i++){
		somResumeRecords[i].set("sorgId",sorgId);
	}
	command.setParameter("somResumeRecords",somResumeRecords);
	
	command.setParameter("applyRecord",somApplyDataSet.getCurrent() );
	command.execute("updateRegPeople");
	
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			updateOnlineStatusPass(somApplyDataSet.getCurrent().get("taskCode"));
			returnBack();
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
	var startDate=record.get('startDate');
	if(tenure!=""&&startDate!=""){
		var year=parseInt(startDate.substring(0,4))+parseInt(tenure);
		var month=startDate.substring(5,7);
		record.set("endDate", year+"-"+month);
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
