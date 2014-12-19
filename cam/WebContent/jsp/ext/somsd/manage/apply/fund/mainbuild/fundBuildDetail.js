var legalRecord="";
var legalDuties="00012";
var sorgType="J";
var sorgCodeNum="";
var cnNameNum="";
var taskCode = "";
var applyType="219,220,221";
var fileCodeL="J016";//理事
var fileCodeS="";//监事
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
	L5.getCmp("tab").setActiveTab("0");
	
	
		loadInfo();
	
		
	somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
	uploadLegalPeopleListCloseEvent();
	
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
//加载业务
function loadInfo(){
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadSomOrgan);
}
//加载社会组织
function loadSomOrgan(ds){
	ds.un("load",loadSomOrgan);
	sorgId = somApplyDataSet.get('sorgId');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadSomHeldPeople);
}
//加载发起人
function loadSomHeldPeople(ds){
	ds.un("load",loadSomHeldPeople);
	cnName=somOrganDataSet.get("cnName");
	sorgCode=somOrganDataSet.get("sorgCode");
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somOrganDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").innerHTML = borgCode;
		}
	}
	somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldPeopleDataSet.load();
	somHeldPeopleDataSet.on('load',loadSomHeldOrgan);
}
//加载发起单位
function loadSomHeldOrgan(ds){
	ds.un("load",loadSomHeldOrgan);
	somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldOrganDataSet.load();
	somHeldOrganDataSet.on('load',loadSomSession);
}
//加载届次
function loadSomSession(ds){
	ds.un("load",loadSomSession);
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',loadSomResume);
}
//加载简历
function loadSomResume(ds){
	ds.un("load",loadSomResume);
	if(ds.getCount() == 0){
		somSessionDataSet.newRecord({"taskCode":taskCode,"seq":"1"});
	}
	somResumeInsertDataSet.setParameter("TASK_CODE", taskCode);
	somResumeInsertDataSet.load();
	somResumeLegalDataSet.removeAll();
	somResumeLegalDataSet.commitChanges();
	somResumeInsertDataSet.on("load",loadAspForLiShi);
}
//加载理事
function loadAspForLiShi(ds){
	ds.un("load",loadAspForLiShi);
	aspForLiShi.setParameter("TASK_CODE", taskCode);
	aspForLiShi.setParameter("SORG_DUTIES@in", "00001,00003,00004,00005,00012");
	aspForLiShi.load();
	aspForLiShi.on('load',loadAspForJianShi);
}
//加载监事
function loadAspForJianShi(ds){
	ds.un("load",loadAspForJianShi);
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
			aspForLiShi.remove(record);
		}
	});
	if(LegalPeopleDataSet.getCount() == 0){
		LegalPeopleDataSet.newRecord();
		initPhotoDetail(null);//初始化照片
	}
	aspForJianShi.setParameter("TASK_CODE", taskCode);
	aspForJianShi.setParameter("SORG_DUTIES", "00006");
	aspForJianShi.load();
	aspForJianShi.on('load',loadSomRule);
}
//加载章程
function loadSomRule(ds){
	ds.un("load",loadSomRule);
	document.getElementById("standCouncilNum").innerHTML=ds.getCount();
	somRuleDataSet.setParameter("TASK_CODE", taskCode);
	somRuleDataSet.load();
	somRuleDataSet.on('load',loadElectronic);
}
//加载文件
function loadElectronic(ds){
	ds.un("load",loadElectronic);
	if(somRuleDataSet.getCount() == 0){
		somRuleDataSet.newRecord();
	}
	somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
	somElectronicDataSet_load();	
}


//返回
function returnClick(){
	window.history.go(-1);
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


function getReadomDutyId(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.execute('getDutyId');	
	return command.getReturn('dutyId');
}

