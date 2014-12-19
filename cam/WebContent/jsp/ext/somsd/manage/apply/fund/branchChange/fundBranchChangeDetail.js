	var cnName='';//基金会名称
	var sorgCode='';//登记证号
	var applyType='231';//法律要件业务类型
	var fileCodeF="J055";
	var forCheck= new Array();//检验变更事项用的数组
	var somLegalPeople='';//法定代表人用record
	var sorgOrganRecord='';//社会组织record
	var changeItemNUM='';
	var sorgDuties='';//基金会职务
	var sorgKind='';
	var legalName="";
	var somLegalPeople='';//分支负责人record
	var isPeopleInsert = true;
function init(){
	L5.getCmp("tab").setActiveTab("0");
		loadUpdate();
	somElectronicDataSet_load();//加载法律要件
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	var win=L5.getCmp("uploadLegalPeopleList");
	if(win!=null){
		win.on("hide",function(el){
			somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
			somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
			somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
			somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
			somLegalPeopleElectronicDataSet.setParameter("applyType","233");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});	
	}	
	
	//过滤负责人职务：法定代表人
	sorgDutiesSelect.filterBy(function(record, id){
		if("00002".indexOf(record.get('value')) > -1){
			return record;
		}
	});
}
function loadUpdate(){
	var somFlowAddDataset= L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.setParameter("TASK_CODE",taskCode);
	somFlowAddDataset.load();
	somFlowAddDataset.on('load',function(){
		sorgRecord= somFlowAddDataset.getCurrent();
		sorgId=sorgRecord.get('sorgId');
		taskCode=sorgRecord.get('taskCode');
		document.getElementById('appDate').innerHTML=sorgRecord.get('appDate');
		document.getElementById("process").value=sorgRecord.get('process');
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=",sorgId);
		somOrganDataSet.load();
		
		var somChangeList=L5.DatasetMgr.lookup("somChangeList");
		somChangeList.setParameter("TASK_CODE@=",taskCode);
		somChangeList.load();//变更
		somChangeList.on('load',forShow);
		
	});
}
function forShow(somChangeList){
	//通过taskCode得到文件
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			forCheck[forCheck.length]='0';
		}else if(changeItem==1){
			applyType=applyType+",232";
			forCheck[forCheck.length]='1';
		}else if(changeItem==2){
			applyType=applyType+",233";
			forCheck[forCheck.length]='2';
			somLegalPeopleDataSet.setParameter("DUTY_ID",records[i].get('legalDutyId'));
			somLegalPeopleDataSet.load();
			somLegalPeopleDataSet.on('load',function(){
				if(somLegalPeopleDataSet.getCount() == 1){
					chargeRecord=somLegalPeopleDataSet.getCurrent();
				}
			});
		}else if(changeItem==3){
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			forCheck[forCheck.length]='4';
		}else if(changeItem==5){
			forCheck[forCheck.length]='5';
		}
	}
	somElectronicDataSet_load();//加载法律要件
}


//点击按钮，填写法定代表人登记表
function addLegalPeople(){

	isPeopleInsert = false;
	if(somLegalPeopleDataSet.getCount() < 0){
		L5.Msg.alert("提示","请先备案负责人！");
		return;
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	
	document.getElementById("labelAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.get('idCard'));
	
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").innerHTML = '';
		var nation = somLegalPeopleDataSet.get('nation');
		var records = countrySelectDic.query("value",nation);
		
		if(records.length == 1){
			var nationCode = records.items[0].get("text");
			document.getElementById("nationDispaly").innerHTML = nationCode;
			
		}
		
	}
	
	//synPhotoDetail(somLegalPeopleDataSet.get("photoId"),null);//同步照片
	
	var somLegalPeopleResumeDataSet= L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	somLegalPeopleResumeDataSet.setParameter("DUTY_ID",somLegalPeopleDataSet.get('dutyId'));
	somLegalPeopleResumeDataSet.load();
	
	legalDutyId = somLegalPeopleDataSet.get("dutyId");
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","233");
	somLegalPeopleElectronicDataSet.load();
}

function goBack(){
	history.go(-1);
}

//关闭变更窗口
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeItemNUM);
	win.hide();
}
//查看变更
function forDetail(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var record=records[0];
		var num=record.get('changeItem');	
		changeItemNUM=num;
		if(num=='0'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('nameBefore1').innerHTML=record.get('changeBefore');	
			document.getElementById('nameAfter1').innerHTML=record.get('changeAfter');
			document.getElementById('namechangeDesc').value=record.get('changeDesc');
			document.getElementById('namechangeReason').value=record.get('changeReason');
		}else if(num=='1'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('houseNameBefore1').innerHTML=record.get('changeBefore');	
			document.getElementById('houseNameAfter1').innerHTML=record.get('changeAfter');
			document.getElementById('housechangeDesc').value=record.get('changeDesc');
			document.getElementById('housechangeReason').value=record.get('changeReason');
		}else if(num=='2'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('leaPeopleNameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter1').innerHTML=record.get('changeAfter');
			document.getElementById('peoplechangeDesc').value=record.get('changeDesc');
			document.getElementById('peoplechangeReason').value=record.get('changeReason');
		}else if(num=='3'){
			var win=L5.getCmp('detail'+num);
			win.show();		
			document.getElementById('areaChangeBefore').value=record.get('changeBefore');
			document.getElementById('areaChangeAfter').value=record.get('changeAfter');
			document.getElementById('areaChangeDesc').value=record.get('changeDesc');
			document.getElementById('areaChangeReason').value=record.get('changeReason');	
		}else if(num=='4'){	
			var win=L5.getCmp('detail'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneyPeopleBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyborgBefore1').innerHTML=changeBefores[1];
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[2];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[3];
		
			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('moneyPeopleAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyborgAfter1').innerHTML=changeAfters[1];
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[2];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[3];
			
			document.getElementById('moneychangeDesc').value=record.get('changeDesc');
			document.getElementById('moneychangeReason').value=record.get('changeReason');
		}else if(num=='5'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('borgNameBefore1').value=record.get('changeBefore');
			document.getElementById('borgNameAfter1').value=record.get('changeAfter');
			document.getElementById('borgchangeDesc').value=record.get('changeDesc');
			document.getElementById('borgchangeReason').value=record.get('changeReason');	
		}	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//关闭负责人明细窗口
function closePeoplewin(){
	var win=L5.getCmp("legalPeopleWindow");
	win.hide();
}

function closeChangeWinD(){
	var win=L5.getCmp('detail'+changeItemNUM);
	win.hide();
}


function closePeopleWin(){
	var win=L5.getCmp('legalPeopleWindow');
	win.hide();
}

function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}


//关闭窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}

