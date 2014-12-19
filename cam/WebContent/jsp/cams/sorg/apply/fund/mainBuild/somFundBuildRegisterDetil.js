var legalRecord="";
var legalDuties="00012";
var sorgType="J";
var sorgCodeNum="";
var cnNameNum="";
var somApplyType="204";
var applyType="219,220,221";
var fileCodeL="J016";//理事
var fileCodeS="";//监事
var fileCodeF="J015";//法定代表人
var legalDutyId="";
var peopleType='';
var dutyId = 0;//初始dutyId
var currentId='';
var president='';//理事长
var fetchPeople='';//领证人 
var fetchDate='';//领证日期
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
	
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("PROCESS_ID@=", processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);		
	
	//过滤流程意见
	opinionSelect.filterBy(function(record, id){
		if("0,1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	
	//过滤负责人职务：法定代表人
	sorgDutiesSelect.filterBy(function(record, id){
		if("00012".indexOf(record.get('value'))==-1){
			return record;
		}
	});
	if(method == "yiban" || method == "end"){
		var tab=L5.getCmp("tab");
		var ipinionPanel=L5.getCmp("ipinionPanel");
		tab.remove(ipinionPanel);
	}
}
function loadInfo(){
	somApplyDataSet.set("curActivity", "受理");
	somApplyDataSet.set("curOpinionId",'1');
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	
	aspForJianShi.setParameter("TASK_CODE", taskCode);
	aspForJianShi.setParameter("SORG_DUTIES", "00006");
	aspForJianShi.load();
	
	somResumeInsertDataSet.setParameter("TASK_CODE", taskCode);
	somResumeInsertDataSet.on("load",function(){
		aspForLiShi.setParameter("TASK_CODE", taskCode);
		aspForLiShi.setParameter("SORG_DUTIES@in", "00001,00003,00004,00005,00012,00013");
		aspForLiShi.load();
		aspForLiShi.on('load',function(){
			var sorgOpinion="";
			var sorgCheckDate="";
			//加载法定代表人
			aspForLiShi.each(function(record, index){
				if(record.get('sorgDuties') == legalDuties){
					legalDutyId = record.get("dutyId");
					sorgOpinion=record.get("sorgOpinion");
					sorgCheckDate=record.get("sorgCheckDate");
				}
			});
			aspForLiShi.each(function(record, index){
				if(record.get('sorgDuties') == "00001"){
					president=record;
					LegalPeopleDataSet.insert(0,president.copy());
					LegalPeopleDataSet.set("sorgOpinion",sorgOpinion);
					LegalPeopleDataSet.set("sorgCheckDate",sorgCheckDate);					
					synPhotoDetail(president.get('photoId'),null);//同步照片
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
				aspForLiShi.filterBy(function(record, id){
					if("00012".indexOf(record.get('sorgDuties'))==-1){
						return record;
					}
				});
			});
			somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
		});
	});
	somResumeInsertDataSet.load();
	somPartyMemberDataSet.setParameter('SORG_ID',sorgId);	
	somPartyMemberDataSet.load();
	var mIds='';
	somPartyMemberDataSet.on('load',function(ds){
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
	});
	somElectronicDataSet_load();//同步法律要件
	
	LegalPeopleDataSet.on('load',function(){
		if(LegalPeopleDataSet.getCount() == 0){
			LegalPeopleDataSet.newRecord();
		}
	});
	
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',function(){
		if(somSessionDataSet.getCount() == 0){
			somSessionDataSet.newRecord();
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
	
}

//全部保存
function save(){
	
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("5");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	somApplyRecord.set("taskCode",taskCode);
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert('提示','保存成功！',function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
				
}
//保存并提交
function submit(){
//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("5");
		return false;
	}
	if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
		L5.Msg.alert("提示","请先填写领证信息！");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	somApplyRecord.set("taskCode",taskCode);
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存
	command.execute("send");
	if (!command.error) {
		L5.Msg.alert("提示","成功结束流程!",function(){
			returnClick();
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
function returnClick(){
	history.go(-1);
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
	$("age").innerHTML = getAgeByCode(currentPeople.get("idCard"));
	synPhotoDetail(peopleInsertDataset.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet_load(fileCodeL,currentPeople.get('dutyId'));//同步理事法律要件
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
	$("age").innerHTML = getAgeByCode(currentPeople.get("idCard"));
	synPhotoDetail(peopleInsertDataset.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet_load(fileCodeL,currentPeople.get('dutyId'));//同步理事法律要件
}

function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}
function countRender(value){
	var count = aspForLiShi.getTotalCount();
	if(count === undefined){
		count=0;
	}
	return "理事总人数: "+count+" 人";

}
function countRenderS(value){
	var count = aspForJianShi.getTotalCount();
	if(count === undefined){
		count=0;
	}
	return "监事总人数: "+count+" 人";

}
//选择领证人
function choseIssuePeople(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.show();
}
//选择领证人里面的确认按钮
function buttonForFetch(){
	fetchPeople=document.getElementById('fetchPeople').value; 
	fetchDate=document.getElementById('fetchDate').value;
	fetchPhone=document.getElementById('fetchPhone').value;
	if(fetchPeople==''){
		L5.Msg.alert('提示',"领证人不能为空！");return;
	}else if(fetchDate==''){
		L5.Msg.alert('提示',"领证日期不能为空！");return;
	}else if(fetchPhone==''){
		L5.Msg.alert('提示',"领证人联系电话不能为空！");return;
	}
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}
function closeForFetch(){	
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}
function detailPartyMember(){
	var grid = L5.getCmp("partyMemberGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var partyMemberRecord = record;
	var memberId=record.get('memberId');
	winPartyMemberDataSet.removeAll();
	winPartyMemberDataSet.insert(0,record);
	
	//处理奖惩
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	somPartyPraiseInsertDataSet.removeAll();
	var j=0;
	for(var i=somPartyPraiseDataSet.getCount()-1;i>=0;i--){
		var somPartyPraiseRecord =somPartyPraiseDataSet.getAt(i);
		if(partyMemberRecord.get('memberId')==somPartyPraiseRecord.get('memberId')){
			somPartyPraiseInsertDataSet.insert(j,somPartyPraiseRecord);
			j++;
		}
	}
	var win = L5.getCmp("partyMemberWin");
	win.show();
	
	var peopleType=record.get('peopleType');
 	var dangyuan=$("dangyuanDiv");
 	var yubei=$("yubeiDiv");
 	var fazhan=$("fazhanDiv");
 	var jijifenzi=$("jijifenziDiv");
 	var shenqingren=$("shenqingrenDiv");
 	if(peopleType==5){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="block";
 	}else if(peopleType==4){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="block"; 
 		shenqingren.style.display="none";
 	}else if(peopleType==3){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="block";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 	}else if(peopleType==2){
 		dangyuan.style.display="none";
 		yubei.style.display="block"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 	}else{	
 		dangyuan.style.display="block";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 	}
}
//窗口关闭
function winClosePartyMember(){
	var win = L5.getCmp("partyMemberWin");
	win.setVisible(false);
}