var sorgId='';//社团ID
var cnName='';//社团名称
var sorgCode='';//登记证号
var applyType='118';//法律要件业务类型
var fileCodeF="M044";
var forCheck= new Array();//检验变更事项用的数组
var sorgOrganRecord='';//社会组织record
var changeItemNUM='';
var sorgDuties='';//社团职务
var legalName="";
var somLegalPeople="";
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
			somLegalPeopleElectronicDataSet.setParameter("applyType","121");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});	
	}	
}
function loadUpdate(){
	var somFlowAddDataset= L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.setParameter("TASK_CODE",taskCode);
	somFlowAddDataset.load();
	somFlowAddDataset.on('load',function(){
		sorgRecord= somFlowAddDataset.getCurrent();
		sorgId=sorgRecord.get('sorgId');
		taskCode=sorgRecord.get('taskCode');
		cnName=sorgRecord.get('sorgName');
		document.getElementById('cnName').value=cnName;
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=",sorgId);
		somOrganDataSet.load();
		
		var somChangeList=L5.DatasetMgr.lookup("somChangeList");
		somChangeList.setParameter("TASK_CODE@=",taskCode);
		somChangeList.load();//变更
		somChangeList.on('load',forShow);
		
		var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
		somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
		somLegalPeopleDataSet.load();//法定代表人
		somLegalPeopleDataSet.on("load",function(ds){
			if(ds.getCount()==1){
				legalDutyId=ds.get("dutyId");
				//加载法定代表人法律要件
				somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
				somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
				somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
				somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
				somLegalPeopleElectronicDataSet.setParameter("applyType","121");
				somLegalPeopleElectronicDataSet.load();
				//加载人员简历
				var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
				somLegalPeopleResumeDataSet.setParameter("TASK_CODE",taskCode);
				somLegalPeopleResumeDataSet.load();
			}
		});
	});
}
function forShow(somChangeList){
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			applyType=applyType+",119";
		}else if(changeItem==1){
			applyType=applyType+",120";
		}else if(changeItem==2){
			applyType=applyType+",121";
			var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
			somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
			somLegalPeopleDataSet.load();//法定代表人
			somLegalPeopleDataSet.on('load',function(){
				if(somLegalPeopleDataSet.getCount() == 1){
					legalDutyId=somLegalPeopleDataSet.getCurrent().get("dutyId");
					somLegalPeople = somLegalPeopleDataSet.getCurrent();
				}
			});
		}else if(changeItem==3){
			applyType=applyType+",122";
		}else if(changeItem==4){
			applyType=applyType+",123";
		}else if(changeItem==5){
			applyType=applyType+",124";
		}else if(changeItem==7){
			applyType=applyType+",125";
		}
		forCheck[forCheck.length]=changeItem;
	}
	somElectronicDataSet_load();//加载法律要件
}
//点击按钮，查看法定代表人登记表
function detailLegalPeople(){
	var win=L5.getCmp("detailLegalPeopleWindow");
	win.show();
	document.getElementById("detailAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.get('idCard'));
	L5.getCmp("detailLegalPeopleTab").setActiveTab("0");//不加照片会错误显示
	if(!somLegalPeopleDataSet.get("photoPath")){
		//synPhotoDetail(somLegalPeopleDataSet.get("photoId"),"1");
	}else{
		initPhotoDetail("1");
		initUpload($("filePath1"), 1,"RELATIONER_PHOTOC_IMG1");
	}
}
function goBack(){
	history.go(-1);
}
//关闭变更窗口
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeItemNUM);
	win.hide();
}
//关闭变更窗口
function closeChangeWinD(){
	var win=L5.getCmp('detail'+changeItemNUM);
	win.hide();
}
//查看变更
function forDetail(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var record=records[0];
		var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
		somChangeDataset.removeAll();
		somChangeDataset.remove(somChangeDataset.newRecord());
		somChangeDataset.insert(0,record);
		var num=record.get('changeItem');		
		changeItemNUM=num;
		if(num=='0'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('nameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('nameAfter1').innerHTML=record.get('changeAfter');
			//document.getElementById('namechangeDesc').value=record.get('changeDesc');
			//document.getElementById('namechangeReason').value=record.get('changeReason');	
		}else if(num=='1'){
			var win=L5.getCmp('detail'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('houseNameBefore1').innerHTML=changeBefores[4];
		
			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('houseNameAfter1').innerHTML=changeAfters[4];
			//document.getElementById('housechangeDesc').value=record.get('changeDesc');
			//document.getElementById('housechangeReason').value=record.get('changeReason');
		}else if(num=='2'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
			somChangeDataset.newRecord();
			document.getElementById('leaPeopleNameBefore').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter').innerHTML=record.get('changeAfter');
			document.getElementById('leaPeopleDesc').value=record.get('changeDesc');
			document.getElementById('leaPeopleReason').value=record.get('changeReason');
		}else if(num=='3'){
			var win=L5.getCmp('detail'+num);
			win.show();		
			document.getElementById('areaChangeBefore').value=record.get('changeBefore');
			document.getElementById('areaChangeAfter').value=record.get('changeAfter');
			//document.getElementById('areaChangeDesc').value=record.get('changeDesc');
			//document.getElementById('areaChangeReason').value=record.get('changeReason');	
		}else if(num=='4'){	
			var win=L5.getCmp('detail'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			//document.getElementById('moneyPeopleBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[1];
		
			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			//document.getElementById('moneyPeopleAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[1];
			
			//document.getElementById('moneychangeDesc').value=record.get('changeDesc');
			//document.getElementById('moneychangeReason').value=record.get('changeReason');
		}else if(num=='5'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('borgNameBefore1').value=record.get('changeBefore');
			document.getElementById('borgNameAfter1').value=record.get('changeAfter');
			//document.getElementById('borgchangeDesc').value=record.get('changeDesc');
			//document.getElementById('borgchangeReason').value=record.get('changeReason');	
		}else if(num=='7'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('monPeopleChangeBefore1').value=record.get('changeBefore');
			document.getElementById('monPeopleChangeAfter1').value=record.get('changeAfter');
			//document.getElementById('monPeopleDesc1').value=record.get('changeDesc');
			//document.getElementById('monPeopleReason1').value=record.get('changeReason');	
		}	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//点击输入法定代表人姓名，执行操作
function forLegalPeople(){
	if(somLegalPeople == ""){
		somLegalPeopleDataSet.newRecord();
		var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
		somLegalPeopleResumeDataSet.removeAll();
		somLegalPeople = somLegalPeopleDataSet.getCurrent();
		
	}
	if(somLegalPeople != "" && method == "UPDATE"){
		//加载法定代表人法律要件
		var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
		somLegalPeopleResumeDataSet.setParameter("TASK_CODE",taskCode);
		somLegalPeopleResumeDataSet.load();
	}
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","023");
	somLegalPeopleElectronicDataSet.load();
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	initPhotoDetail(null);//初始化照片
}	
function showAge(){
	var birthday=_$("birthday");
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}

function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}
function closePeopleDetailWIn(){
	var win = L5.getCmp("detailLegalPeopleWindow");
	win.hide();
}
