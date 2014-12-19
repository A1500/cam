//初始化
function init(){
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("6");
	L5.getCmp("tab").setActiveTab("0");
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.setParameter("APPLY_TYPE",applyType);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);

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
//	L5.getCmp("peopleWin").on("beforehide",function(){
	//	updateRecord="";
//	});
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadLegalPeopleListCloseEvent();
}
function loadInfo(){
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somApplyDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgNameDispaly").innerHTML = borgCode;
		}
	}

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
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	somHeldPeopleDataSet.setParameter("TASK_CODE@=", taskCode);
	somHeldPeopleDataSet.load();
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	somHeldOrganDataSet.setParameter("TASK_CODE@=", taskCode);
	somHeldOrganDataSet.load();

	//同步法律要件
	somElectronicDataSet_load();

	somRuleDataSet.setParameter("TASK_CODE", taskCode);
	somRuleDataSet.load();

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
	somPartyMemberDataSet.setParameter('SORG_ID',sorgId);
	somPartyMemberDataSet.load();
	somPartyMemberDataSet.on('load',somPartyMemberOnLoad);
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
//返回按钮
function goBack(){
	history.go(-1);
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

//查看常用机构
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
//关闭任职信息窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//常设办事机构窗口关闭
function winCloseOffice(){
	var win = L5.getCmp("officeWin");
	win.setVisible(false);
}
