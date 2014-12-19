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
		forUPdateLoad();
		
	
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
			document.getElementById("borgNameDispaly").innerHTML = borgCode;
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

//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}

function centerWin(win){
	L5.EventManager.onWindowResize(function(){
       win.center();           
    });        
}
//查看负责人
var updateRecord;
function detail(){
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

var peopleId=0;
var resumeCount=0;

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




function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}

//返回
function goBack(){
	history.go(-1);
}