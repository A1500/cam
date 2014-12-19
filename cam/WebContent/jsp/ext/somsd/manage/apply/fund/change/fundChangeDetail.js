	var sorgId='';//基金会ID
	var cnName='';//基金会名称
	var sorgCode='';//登记证号
	var applyType='227';//法律要件业务类型
	var fileCodeF="J022";
	var forCheck= new Array();//检验变更事项用的数组
	var somLegalPeople='';//法定代表人用record
	var sorgOrganRecord='';//社会组织record
	var changeItemNUM='';
	var sorgDuties='';//基金会职务
	var sorgKind='';
	var legalName="";
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
			somLegalPeopleElectronicDataSet.setParameter("applyType","229");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});	
	}	
}
//加载
function loadUpdate(){
	somFlowAddDataset.setParameter("TASK_CODE",taskCode);
	somFlowAddDataset.load();
	somFlowAddDataset.on('load',loadOrgan);
}
//加载社会组织信息
function loadOrgan(ds){
	ds.un("load",loadOrgan);
	var sorgRecord= somFlowAddDataset.getCurrent();
	cnName=sorgRecord.get('sorgName');
	sorgKind=sorgRecord.get('sorgKind');
	sorgId=sorgRecord.get("sorgId");
	document.getElementById('appDate').innerHTML=sorgRecord.get('appDate');
	document.getElementById("process").value=sorgRecord.get('process');
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadChange);
}
//加载变更事项
function loadChange(ds){
	ds.un("load",loadChange);
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE",taskCode);
	somChangeList.load();
	somChangeList.on('load',forShow);
}
//解析变更
function forShow(somChangeList){
	somChangeList.un("load",forShow);
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			forCheck[forCheck.length]='0';
		}else if(changeItem==1){
			applyType=applyType+",228";
			forCheck[forCheck.length]='1';
		}else if(changeItem==2){
			applyType=applyType+",229";
			forCheck[forCheck.length]='2';
			var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");	
			somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
			somLegalPeopleDataSet.load();//法定代表人
			somLegalPeopleDataSet.on('load',loadElectronic);
		}else if(changeItem==3){
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			applyType=applyType+",230";
			forCheck[forCheck.length]='4';
		}else if(changeItem==5){
			forCheck[forCheck.length]='5';
		}
	}
}
//加载文件
function loadElectronic(ds){
	ds.un("load",loadElectronic);
	if(ds.getCount()==1){
		legalDutyId=ds.get("dutyId");
		somLegalPeople=somLegalPeopleDataSet.getCurrent();
	}
	somElectronicDataSet_load();//加载法律要件
}


//点击按钮，填写法定代表人登记表
function addLegalPeople(){
	var somResumeInsertDataSet= L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.setParameter("DUTY_ID",somLegalPeopleDataSet.getCurrent().get('dutyId'));
	somResumeInsertDataSet.load();
	somResumeInsertDataSet.on('load',function(){
		var win=L5.getCmp("legalPeopleWindow");
		win.show();
		document.getElementById("labelAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.getCurrent().get('idCard'));
		//synPhotoDetail(somLegalPeople.get("photoId"),null);//同步照片
		//加载法定代表人法律要件
		somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
		somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
		somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
		somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
		somLegalPeopleElectronicDataSet.setParameter("applyType","229");
		somLegalPeopleElectronicDataSet.load();
	});
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
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
		var somChangeDataset= L5.DatasetMgr.lookup("somChangeDataset");
		somChangeDataset.removeAll();
		somChangeDataset.insert(0,record);
		var num=record.get('changeItem');	
		changeItemNUM=num;
		if(num=='0'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('nameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('nameAfter1').innerHTML=record.get('changeAfter');	
		}else if(num=='1'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('houseNameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('houseNameAfter1').innerHTML=record.get('changeAfter');
		}else if(num=='2'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('leaPeopleNameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter1').innerHTML=record.get('changeAfter');
		}else if(num=='3'){
			var win=L5.getCmp('detail'+num);
			win.show();			
		}else if(num=='4'){	
			var win=L5.getCmp('detail'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[1];
		
			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[1];
		}else if(num=='5'){
			var win=L5.getCmp('detail'+num);
			win.show();
			//document.getElementById('borgNameBefore1').value=record.get('changeBefore');
			//document.getElementById('borgNameAfter1').value=record.get('changeAfter');
		}else if(num=='6'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('fundTypeBefore1').value=record.get('changeBefore');
			document.getElementById('fundTypeAfter1').value=record.get('changeAfter');
		}	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}


//点击输入法定代表人姓名，执行操作
function forLegalPeople(){
	/*
	somLegalPeopleDataSet.setParameter("SORG_ID",sorgId);
	somLegalPeopleDataSet.setParameter("IF_SERVE","1");
	somLegalPeopleDataSet.setParameter("REG_STATUS","1");
	somLegalPeopleDataSet.load();
	somLegalPeopleDataSet.on("load",function(){
		somLegalPeopleDataSet.filterBy(function(record, id){
			if("00001,00003,00004,00005".indexOf(record.get('sorgDuties'))>-1){
				return record;
			}
		});
	});
	
	var win=L5.getCmp('legalPeopleWin');
	win.show();
	*/
	if(somLegalPeopleDataSet.getCount() == 0){
		somLegalPeopleDataSet.newRecord({sorgDuties:"00001","dutyId":legalDutyId,"ifServe":"1","ifPartyLeader":"0","sorgType":"J","ifLegal":"0","regStatus":"1"});
		L5.getCmp("peopleWin").show();
		initPhoto("1");//初始化照片
	}else{
		//加载法定代表人法律要件
		somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
		somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
		somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
		somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
		somLegalPeopleElectronicDataSet.setParameter("applyType","229");
		somLegalPeopleElectronicDataSet.load();
		L5.getCmp("peopleWin").show();
	}
	
}
//点击选定为法定代表人
function chooseLegal(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
		command.setParameter("peopleId", records[0].get('peopleId'));
		command.setParameter("sorgType", records[0].get('sorgType'));
		command.setParameter("sorgId",sorgId);
		command.execute("checkLegalPeopleRepeat");
		var flag=command.getReturn("flag");
		if(flag != "true"){
			L5.MessageBox.confirm('确定', records[0].get("name")+flag+" 是否继续选定？",function(sta){
				if(sta=="yes"){
					document.getElementById("leaPeopleNameAfter").value=records[0].get("name");
					somLegalPeopleDataSet.removeAll();
					somLegalPeopleDataSet.insert(0,records[0]);
					somLegalPeople=records[0];
					var win=L5.getCmp('legalPeopleWin');
					win.hide();
				}
				else return;
			});	
			return;
		}
		
		L5.MessageBox.confirm('确定', '选定[ '+records[0].get("name")+' ]为法定代表人？',function(sta){
			if(sta=="yes"){
				document.getElementById("leaPeopleNameAfter").value=records[0].get("name");
				somLegalPeopleDataSet.removeAll();
				somLegalPeopleDataSet.insert(0,records[0]);
				somLegalPeople=records[0];
				var win=L5.getCmp('legalPeopleWin');
				win.hide();
			}
			else return;
		});		
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

//变更项删除，同步隐藏该变更项所需法律要件
//changeItem：变更项的值
function hideDeletedCatalog(changeItem){
	var ifNeedChangeCatalog = "0";
	//住所变更
	if(changeItem=="1"){
		applyType=applyType.replace(",228","");
		ifNeedChangeCatalog = "1";
	}
	//法定代表人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",229","");
		ifNeedChangeCatalog = "1";
	}
	//原始基金变更
	if(changeItem=="4"){
		applyType=applyType.replace(",230","");
		ifNeedChangeCatalog = "1";
	}
	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
}
function closeChangeDWin(){
	var win=L5.getCmp('detail'+changeItemNUM);
	win.hide();
}


function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}
function closePeopleWIns(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}

