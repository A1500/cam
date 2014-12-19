var fileCodeF="J055";
var legalDutyId="";
var sorgId='';
var sorgKind='';
var cnName='';//基金会名称
var cnNameM='';
var sorgDuties='';//基金会职务
var taskCode='';
var changeNUM='';
var sorgRecord='';
var catalogName='';//档案目录名
var forCheck= new Array();//检验变更事项用的数组
var somLegalPeople='';//法定代表人用record
var sorgOrganRecord='';//社会组织record
var changeItemNUM='';
var legalName="";
var chargeRecord='';//分支负责人record
function init(){
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		var somApplyDataSet= L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"taskCode":taskCode,"applyType":somApplyType,"dataSource":"MEND","sorgType":"J","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
	}else{
		loadUpdate();
	}
	
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
}
function loadUpdate(){
	var somApplyDataSet= L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',funLoad);
}
function save(){
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	//var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchChangeCmd");
	var command = new L5.Command("com.inspur.cams.sorg.history.fund.cmd.SomFundHistoryCmd");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var chargerDataSet1=L5.DatasetMgr.lookup("chargerDataSet1");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somApplyDataSet.isValidate();
	var newRecord=somApplyDataSet.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	newRecord.set("appDate",document.getElementById('appDate').value);
	command.setParameter("opinion", newRecord);//意见
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && chargerDataSet1.getCount()!=0){
			command.setParameter("somLegalPeople", chargerDataSet1.getCurrent());//负责人
		}	
	}
	command.setParameter("Changes", somChangeList.getAllRecords());//变更事项
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","J");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("applyType", somApplyType);
	command.setParameter("process", document.getElementById("process").value);
	if(method=="INSERT"){
		command.execute("saveBranchChange");
	}else{
		command.execute("updateBranchChange");
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			//goBack();
			method="UPDATE";
			loadUpdate();
		});	
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}	
}
//修订保存
function reviseSave(){
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	//var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchChangeCmd");
	var command = new L5.Command("com.inspur.cams.sorg.history.fund.cmd.SomFundHistoryCmd");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var chargerDataSet1=L5.DatasetMgr.lookup("chargerDataSet1");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somApplyDataSet.isValidate();
	var newRecord=somApplyDataSet.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	newRecord.set("appDate",document.getElementById('appDate').value);
	command.setParameter("opinion", newRecord);//意见
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && chargerDataSet1.getCount()!=0){
			command.setParameter("somLegalPeople", chargerDataSet1.getCurrent());//负责人
		}	
	}
	command.setParameter("Changes", somChangeList.getAllRecords());//变更事项
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","J");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("applyType", somApplyType);
	command.setParameter("process", document.getElementById("process").value);
	command.execute("updateBranchChangeOnly");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			//goBack();
			method="UPDATE";
			loadUpdate();
		});	
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}	
}
function funLoad(somApplyDataSet){
	sorgRecord= somApplyDataSet.getCurrent();
	sorgId=sorgRecord.get('sorgId');
	taskCode=sorgRecord.get('taskCode');
	cnName=sorgRecord.get('sorgName');	
	sorgKind=sorgRecord.get('sorgKind');
	document.getElementById('cnName').innerHTML=cnName;
	document.getElementById('appDate').value=sorgRecord.get('appDate');
	document.getElementById("process").value=sorgRecord.get('process');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		sorgOrganRecord= somOrganDataSet.getCurrent();
		document.getElementById('sorgCode').value=sorgOrganRecord.get('sorgCode');
		legalName=sorgOrganRecord.get('branchCharger');
		document.getElementById('charger').innerHTML=legalName;
		
		var mainSorgId =sorgOrganRecord.get('mainSorgId');	
		var somOrganDataSet1 = L5.DatasetMgr.lookup("somOrganDataSet1");
		somOrganDataSet1.removeAll();
		somOrganDataSet1.setParameter("SORG_ID",mainSorgId);
		somOrganDataSet1.load();
		somOrganDataSet1.on('load',function(){
			if(somOrganDataSet1.getCount() > 0){
				var mainOrgan= somOrganDataSet1.getCurrent();
				document.getElementById('sorgCodeM').innerHTML=mainOrgan.get('sorgCode');
				document.getElementById('cnNameM').innerHTML=mainOrgan.get('cnName');
				document.getElementById('legalPeople').innerHTML=mainOrgan.get('legalPeople');
			}	
		});	
	});
	
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE@=",taskCode);
	somChangeList.load();//变更
	somChangeList.on('load',forShow);
}
function funAdd(somOrganDataset){
	var cnNameM='';
	var sorgCodeM='';
	var num=somOrganDataset.getCount();
	if(num==0){
		L5.Msg.alert("提示","您输入的登记证号不存在！");
		document.getElementById('cnName').innerHTML='';
		document.getElementById('legalPeople').innerHTML='';
		document.getElementById('cnNameM').innerHTML='';
		document.getElementById('sorgCodeM').innerHTML='';
		document.getElementById('charger').innerHTML='';
		sorgId='';
		cnName='';
		cnNameM='';
		sorgCodeM='';
		sorgOrganRecord='';
		legalName='';
		return;
	}else{
		sorgOrganRecord= somOrganDataset.getCurrent();
		sorgId=sorgOrganRecord.get('sorgId');
		cnName=sorgOrganRecord.get('cnName');
		document.getElementById('cnName').innerHTML=cnName;
		
		document.getElementById('sorgCode').value=sorgOrganRecord.get('sorgCode');
		legalName=sorgOrganRecord.get('branchCharger');
		document.getElementById('charger').innerHTML=legalName;
		var mainSorgId =sorgOrganRecord.get('mainSorgId');	
		var somOrganDataSet1 = L5.DatasetMgr.lookup("somOrganDataSet1");
		somOrganDataSet1.removeAll();
		somOrganDataSet1.setParameter("SORG_ID",mainSorgId);
		somOrganDataSet1.load();
		somOrganDataSet1.on('load',function(){
			if(somOrganDataSet1.getCount() > 0){
				var mainOrgan= somOrganDataSet1.getCurrent();
				sorgCodeM=mainOrgan.get('sorgCode');
				document.getElementById('sorgCodeM').innerHTML=sorgCodeM;
				cnNameM=mainOrgan.get('cnName');
				document.getElementById('cnNameM').innerHTML=cnNameM;
				document.getElementById('legalPeople').innerHTML=mainOrgan.get('legalPeople');
			}	
		});	
		somElectronicDataSet_load();//加载法律要件
	}
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
				var chargerDataSet1=L5.DatasetMgr.lookup("chargerDataSet1");
				chargerDataSet1.setParameter("DUTY_ID",records[i].get('legalDutyId'));
				chargerDataSet1.load();
				chargerDataSet1.on('load',function(){
					if(chargerDataSet1.getCount() == 1){
						chargeRecord=chargerDataSet1.getCurrent();
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
//关闭变更window
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeNUM);
	win.hide();
}
//查看变更明细
function detailForChange(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var id=records[0].get("id");
		var somChangeDetail=L5.DatasetMgr.lookup("somChangeDetail");
		somChangeDetail.removeAll();
		somChangeDetail.insert(0,records[0]);
		var changeItem=records[0].get('changeItem');
		var win=L5.getCmp('detail'+changeItem);
		win.show();
		if(changeItem=='0'){
			document.getElementById('nameBefore1').innerHTML=records[0].get('changeBefore');
			var changeAfter=records[0].get('changeAfter');
			document.getElementById('nameAfter1').innerHTML=records[0].get('changeAfter');
			
		}else if(changeItem=='1'){
			document.getElementById('houseNameBefore1').innerHTML=records[0].get('changeBefore');
			document.getElementById('houseNameAfter1').innerHTML=records[0].get('changeAfter');
		}else if(changeItem=='2'){
			document.getElementById('leaPeopleNameBefore1').innerHTML=records[0].get('changeBefore');
		}else if(changeItem=='3'){
			
		}else if(changeItem=='4'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneyPeopleBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyborgBefore1').innerHTML=changeBefores[1];
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[2];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[3];
			
			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('moneyPeopleAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyborgAfter1').innerHTML=changeAfters[1];
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[2];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[3];
		}else if(changeItem=='5'){
			document.getElementById('borgNameBefore1').value=records[0].get('changeBefore');
		}
		changeItemNUM=changeItem;
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//查看变更明细
//修改变更
function forUpdate(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	somChangeDataset.newRecord();
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var id=records[0].get("id");
		var changeItem=records[0].get('changeItem');
		var win=L5.getCmp('AddChange'+changeItem);
		win.show();
		if(changeItem=='0'){
			document.getElementById('nameBefore').innerHTML=records[0].get('changeBefore');
			var changeAfter=records[0].get('changeAfter');
			document.getElementById('nameAfter').value=records[0].get('changeAfter');
			document.getElementById('nameReason').value=records[0].get('changeReason');	
			
		}else if(changeItem=='1'){
			document.getElementById('houseNameBefore').innerHTML=records[0].get('changeBefore');
			document.getElementById('houseNameAfter').value=records[0].get('changeAfter');
			document.getElementById('houseReason').value=records[0].get('changeReason');
		}else if(changeItem=='2'){
			document.getElementById('leaPeopleNameBefore').innerHTML=records[0].get('changeBefore');
			document.getElementById('leaPeopleNameAfter').value=records[0].get('changeAfter');
			document.getElementById('leaPeopleReason').value=records[0].get('changeReason');
		}else if(changeItem=='3'){
			
		}else if(changeItem=='4'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneyPeopleBefore').innerHTML=changeBefores[0];
			document.getElementById('moneyborgBefore').innerHTML=changeBefores[1];
			document.getElementById('moneySourceBefore').innerHTML=changeBefores[2];
			document.getElementById('moneyBefore').innerHTML=changeBefores[3];
			
			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('moneyPeopleAfter').value=changeAfters[0];
			document.getElementById('moneyborgAfter').value=changeAfters[1];
			document.getElementById('moneySourceAfter').value=changeAfters[2];
			document.getElementById('moneyAfter').value=changeAfters[3];
		}else if(changeItem=='5'){
			document.getElementById('borgNameBefore').value=records[0].get('changeBefore');
		}
		changeItemNUM=changeItem;
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//添加新的变更
function forAdd(){
	var win=L5.getCmp('AddChange');
	win.show();
}
//选择完变更项目后点击确定
function forChangeItem(num){
	if(num == ""){
		L5.Msg.alert("提示","请选择变更事项!");return;
	}
	if(!forCheckRepeat(num)){
		return;
	}
	var win=L5.getCmp('AddChange');
	win.hide();	
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	somChangeDataset.newRecord();
	if(num=='0'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('nameBefore').innerHTML=sorgOrganRecord.get('cnName');
	}else if(num=='1'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
	}else if(num=='2'){
		chargerDataSet1.setParameter("SORG_ID",sorgId);
		chargerDataSet1.setParameter("REG_STATUS","3");//批准中的，必须先备案才能进行负责人的变更
		chargerDataSet1.load();
		chargerDataSet1.on('load',function(){
			if(chargerDataSet1.getCount() > 0){
				legalDutyId = chargerDataSet1.get("dutyId");
				chargeRecord = chargerDataSet1.getCurrent();
				var win=L5.getCmp('AddChange'+num);
				win.show();
				document.getElementById('leaPeopleNameAfter').value=chargeRecord.get('name');
				document.getElementById('leaPeopleNameBefore').innerHTML=sorgOrganRecord.get('branchCharger');
			}else{
				L5.Msg.alert("提示","请先进行负责人的备案！");return;
			}
		});
	}else if(num=='3'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('businessNameBefore').innerHTML=sorgOrganRecord.get("business");
	}else if(num=='4'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('moneyPeopleBefore').innerHTML=sorgOrganRecord.get("fundingPeople");
		document.getElementById('moneyborgBefore').innerHTML=sorgOrganRecord.get("checkCapitalOrgan");
		document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
	}else if(num=='5'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('borgNameBefore').value=sorgOrganRecord.get("borgName");
	}	
	
	changeItemNUM=num;
}

//住所变更保存	
function forHouseMove(){
	
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var houseNameAfter=document.getElementById('houseNameAfter').value;	
	var houseReason=document.getElementById('houseReason').value;
	
	if(!fundHouseCheck()){
		return;
	}
	var changeAfter=houseNameAfter;
	var houseNameBefore=document.getElementById('houseNameBefore').innerHTML;
	var changeBefore=houseNameBefore;
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','1');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("1");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='1';
	closeChangeWinD();
	applyType=applyType+",232";
	somElectronicDataSet_load();
	
}

//名称变更保存
function forNameMove(){
	
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	
	var nameBefore=document.getElementById('nameBefore').innerHTML;
	
	var nameAfter=document.getElementById('nameAfter').value;
	if(nameAfter==''){
		L5.Msg.alert("提示","名称不能为空！");return;
	}
	if(!nameChangeCheck()){
		return;
	}
	//检查新的基金会名称是否已经存在
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",document.getElementById('nameAfter').value);
	command.execute('cnNameUK');
	var num=command.getReturn('cnNameNum');
	if(num!=0){
		L5.Msg.alert("提示","名称已经存在!");return;
	}
	var changeBefore=nameBefore;
	var changeAfter=nameAfter;
	
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','0');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("0");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='0';
	closeChangeWinD();
	
}
//负责人变更保存
function forLeaPeopleMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeAfter=document.getElementById('leaPeopleNameAfter').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","负责人姓名不能为空！");return;
	}
	if(!leaPeopleChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('leaPeopleNameBefore').innerHTML);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','2');
	record.set('legalDutyId',chargeRecord.get('dutyId'));
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='2';
	closeChangeWinD();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("2");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",233";
	somElectronicDataSet_load();
	somChangeList.commitChanges();
}
//业务范围变更保存
function forBusinessMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeBefore=document.getElementById('businessNameBefore').innerHTML;
	var changeAfter=record.get('changeAfter');
	if(changeAfter==''){
		L5.Msg.alert("提示","业务范围不能为空！");return;
	}	
	if(!businessChangeCheck()){
		return;
	}
	record.set('changeBefore',changeBefore);
	record.set('changeItem','3');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='3';
	closeChangeWinD();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("3");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	
}
//检查是否重复变更
function forCheckRepeat(number){
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		if(records[i].get('changeItem')==number){
			L5.Msg.alert("提示","该变更事项已经存在!");return false;
		}	
	}
	return true;
}
//关闭变更窗口
function closeChangeWin(){
	var win=L5.getCmp('detail'+changeItemNUM);
	win.hide();
}
//关闭变更窗口
function closeChangeWinD(){
	var win=L5.getCmp('AddChange'+changeItemNUM);
	win.hide();
}
//点击删除变更按钮，删除一条变更
function forDelete(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				L5.Msg.alert("提示","删除成功!",function(){
					var somChangeList = L5.DatasetMgr.lookup("somChangeList");
					for(var i=0;i<forCheck.length;i++){
						if(records[0].get('changeItem')==forCheck[i]){
							hideDeletedCatalog(forCheck[i]);
							forCheck[i]='delete';
						}
					}
					somChangeList.remove(records[0]);
				});
			}
			else{
				return;
			}
		});		
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//关闭负责人明细窗口
function closePeopleWin(){
	var win=L5.getCmp("legalPeopleWindow");
	win.hide();
}
//变更项删除，同步隐藏该变更项所需法律要件
//changeItem：变更项的值
function hideDeletedCatalog(changeItem){
	var ifNeedChangeCatalog = "0";
	//住所变更
	if(changeItem=="1"){
		applyType=applyType.replace(",232","");
		ifNeedChangeCatalog = "1";
	}
	//负责人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",233","");
		ifNeedChangeCatalog = "1";
	}
	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
}
//点击按钮，填写法定代表人登记表
function addLegalPeople(){
	if(chargerDataSet1.getCount()!=1){
		L5.Msg.alert("提示","请先选择负责人！");
		return;
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(chargerDataSet1.get('idCard'));
	
	//synPhotoDetail(chargerDataSet1.get("photoId"),null);//同步照片
	
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",chargerDataSet1.get('dutyId'));
	somResumeLegalDataSet.load();
	
	legalDutyId = chargerDataSet1.get("dutyId");
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","233");
	somLegalPeopleElectronicDataSet.load();
}
//回退
function goBack(){
	if(method=="UPDATE"){
		var data=new L5.Map();
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(document.getElementById('cnName').innerHTML)));
		data.put("searchSorgCode",_$("sorgCode"));	
		url="jsp/cams/sorg/history/fund/branchChange/fundBranchHistoryChangeList.jsp";
		L5.forward(url,'',data);
	}else{
		history.go(-1);
	}
}
function loadSorg(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	sorgCode=document.getElementById('sorgCode').value;
	if(sorgCode=='')return;
	somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE@=","J");
	somOrganDataSet.setParameter("IF_BRANCH@=","1");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.load();
	somOrganDataSet.on('load',funAdd);
}
//判断grid中是否已经有该变更
function checkIfExist(changeItem){
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	for(var i = 0;i < somChangeList.getCount();i++){
		if(changeItem==somChangeList.getAt(i).get("changeItem")){
			somChangeList.removeAt(i);
		}
	}
}