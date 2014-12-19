var sorgId='';
var sorgKind='';
var cnName='';//基金会名称
var cnNameM='';
var sorgDuties='';//基金会职务
var changeNUM='';
var sorgRecord='';
var catalogName='';//档案目录名
var forCheck= new Array();//检验变更事项用的数组
var somLegalPeople='';//法定代表人用record
var sorgOrganRecord='';//社会组织record
var changeItemNUM='';
var legalName="";
var sorgIdExist='';
var ifPeopleExist='1';
function init(){
	var tab=L5.getCmp("tab");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
	somApplyDataSet.load();//社会组织
	somApplyDataSet.on('load',funAdd);
	var opinionSelect=L5.DatasetMgr.lookup("opinionSelect1");
	opinionSelect.filterBy(function(record, id){
		if("0,1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
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

function funAdd(somApplyDataSet){
	sorgRecord= somApplyDataSet.getCurrent();
	sorgRecord.set("curOpinionId","1");
	sorgId=sorgRecord.get('sorgId');
	cnName=sorgRecord.get('sorgName');	
	sorgKind=sorgRecord.get('sorgKind');
	document.getElementById('cnName').innerHTML=cnName;
	document.getElementById('changeDate').innerHTML=sorgRecord.get('appDate');
	document.getElementById("process").value=sorgRecord.get('process');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("CN_NAME@=",cnName);
	somOrganDataSet.setParameter("SORG_TYPE@=","J");
	somOrganDataSet.setParameter("SORG_STATUS@=","22");
	somOrganDataSet.setParameter("IF_BRANCH@=","1");
	somOrganDataSet.load();
	//查询系统中已经设立的分支的那条数据
	somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() > 0 ){
			sorgOrganRecord= somOrganDataSet.getCurrent();
			sorgIdExist = sorgOrganRecord.get("sorgId");
			document.getElementById('sorgCodeLab').innerHTML=sorgOrganRecord.get('sorgCode');
			legalPeopleDataSet.setParameter("SORG_ID",sorgOrganRecord.get("sorgId"));
			legalPeopleDataSet.setParameter("IF_SERVE","1");
			legalPeopleDataSet.setParameter("REG_STATUS","1");
			legalPeopleDataSet.load();
			legalPeopleDataSet.on('load',function(){
				if(legalPeopleDataSet.getCount() > 0){
					legalName=legalPeopleDataSet.getCurrent().get('name');
					document.getElementById('charger').innerHTML=legalName;
				}
			});
			//查询主体的名称
			var mainSorgCode =sorgOrganRecord.get('mainSorgCode');	
			var somOrganDataSet1 = L5.DatasetMgr.lookup("somOrganDataSet1");
			somOrganDataSet1.removeAll();
			somOrganDataSet1.setParameter("SORG_CODE",mainSorgCode);
			somOrganDataSet1.load();
			somOrganDataSet1.on('load',function(){
				if(somOrganDataSet1.getCount() > 0){
					var mainOrgan= somOrganDataSet1.getCurrent();
					cnNameM=mainOrgan.get('cnName');
					document.getElementById('cnNameM').innerHTML=cnNameM;
					$("legalPeople").innerHTML = mainOrgan.get("legalPeople");
				}else{
					L5.Msg.alert("提示","没有找到此分支的主体社会组织的信息！");
					return false;
				}	
			});	
			var somChangeList=L5.DatasetMgr.lookup("somChangeList");
			somChangeList.setParameter("TASK_CODE",taskCode);
			somChangeList.setParameter("CN_NAME",cnName);
			somChangeList.load();//变更
			somChangeList.on('load',forShow);
		}else{
			L5.Msg.alert("提示","没有找到此名称的社会组织的信息！");
			return false;
		}
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
				var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
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
//保存
function saveOpinion(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somApplyDataSet.isValidate();
	var newRecord=somApplyDataSet.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	newRecord.set("sorgId",sorgIdExist);
	var somChangeRecords=somChangeList.getAllRecords();
	for(var i=0;i<somChangeRecords.length;i++){
		somChangeRecords[i].set("sorgId",sorgIdExist);
	}
	command.setParameter("opinion", newRecord);//意见
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeopleDataSet.getCount()!=0){
			var somLegalPeopleReocord = somLegalPeopleDataSet.getCurrent();
			somLegalPeopleReocord.set("taskCode",taskCode);
			if(ifPeopleExist == "0"){
				somLegalPeopleReocord.set("peopleId","");
			}
			command.setParameter("somLegalPeople", somLegalPeopleReocord);//负责人
		}	
	}
	command.setParameter("Changes", somChangeRecords);//变更事项
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	command.setParameter("legalResumeRecords", somResumeLegalDataSet.getAllRecords());
	command.setParameter("process",document.getElementById("process").value);//内部履行程序
	
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgIdExist);
	command.setParameter("sorgType","J");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	if(ifPeopleExist == "1"){
		command.execute("saveForCreate"); 
	}
	if(ifPeopleExist == "0"){
		command.execute("saveForCreateOnline"); 
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功!",function(){
			updateOnlineStatusAccept();
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//提交
function sendNext(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somApplyDataSet.isValidate();
	var newRecord=somApplyDataSet.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	newRecord.set("sorgId",sorgIdExist);
	var somChangeRecords=somChangeList.getAllRecords();
	for(var i=0;i<somChangeRecords.length;i++){
		somChangeRecords[i].set("sorgId",sorgIdExist);
	}
	command.setParameter("opinion", newRecord);//意见
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeopleDataSet.getCount()!=0){
			var somLegalPeopleReocord = somLegalPeopleDataSet.getCurrent();
			somLegalPeopleReocord.set("taskCode",taskCode);
			if(ifPeopleExist == "0"){
					somLegalPeopleReocord.set("peopleId","");
			}
			command.setParameter("somLegalPeople", somLegalPeopleReocord);//法定代表人
		}
	}
	command.setParameter("Changes", somChangeRecords);//变更事项
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	command.setParameter("legalResumeRecords", somResumeLegalDataSet.getAllRecords());
	command.setParameter("process",document.getElementById("process").value);//内部履行程序
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgIdExist);
	command.setParameter("sorgType","J");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	
	if(ifPeopleExist == "1"){
		command.execute("saveAndSendForChange");
	}
	if(ifPeopleExist == "0"){
		command.execute("saveAndSendForChangeOnline");
	}
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
		updateOnlineStatusAccept();
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}


//关闭变更window
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeNUM);
	win.hide();
}
//点击按钮负责人登记表
function addLegalPeople(){
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var num=somLegalPeopleDataSet.getCount();
	if(num == 0){
		L5.Msg.alert("提示","请先选择负责人！");
		return
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.getCurrent().get('idCard'));
	
	synPhotoDetail(somLegalPeopleDataSet.get("photoId"),null);
		
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",somLegalPeopleDataSet.getCurrent().get('dutyId'));
	somResumeLegalDataSet.load();
	
	legalDutyId=somLegalPeopleDataSet.getCurrent().get('dutyId');
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","233");
	somLegalPeopleElectronicDataSet.load();
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
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
		var win=L5.getCmp('AddChange'+changeItem);
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
//关闭变更窗口
function closeChangeWinD(){
	var win=L5.getCmp('AddChange1'+changeItemNUM);
	win.hide();
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
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('nameBefore').innerHTML=sorgOrganRecord.get('cnName');
	}else if(num=='1'){
		var win=L5.getCmp('AddChange1'+num);
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
				var win=L5.getCmp('AddChange1'+num);
				win.show();
				document.getElementById('leaPeopleNameAfter').value=chargeRecord.get('name');
				document.getElementById('leaPeopleNameBefore').innerHTML=sorgOrganRecord.get('branchCharger');
			}else{
				L5.Msg.alert("提示","请先进行负责人的备案！");return;
			}
		});
	}else if(num=='3'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('businessNameBefore').innerHTML=sorgOrganRecord.get("business");
	}else if(num=='4'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('moneyPeopleBefore').innerHTML=sorgOrganRecord.get("fundingPeople");
		document.getElementById('moneyborgBefore').innerHTML=sorgOrganRecord.get("checkCapitalOrgan");
		document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
	}else if(num=='5'){
		var win=L5.getCmp('AddChange1'+num);
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
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='1';
	closeChangeWin();
	applyType=applyType+",232";
	somElectronicDataSet_load();
	
}
//资金变更保存
function forMoneyMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var moneyPeopleBefore=document.getElementById('moneyPeopleBefore').innerHTML;
	var moneyborgBefore=document.getElementById('moneyborgBefore').innerHTML;
	var moneySourceBefore=document.getElementById('moneySourceBefore').innerHTML;
	var moneyBefore=document.getElementById('moneyBefore').innerHTML;

	var changeBefore=moneyPeopleBefore+';'+moneyborgBefore+';'+moneySourceBefore+';'+moneyBefore;
	
	var moneyPeopleAfter=document.getElementById('moneyPeopleAfter').value;
	var moneyborgAfter=document.getElementById('moneyborgAfter').value;
	var moneySourceAfter=document.getElementById('moneySourceAfter').value;
	var moneyAfter=document.getElementById('moneyAfter').value;
	 
	var changeAfter=moneyPeopleAfter+';'+moneyborgAfter+';'+moneySourceAfter+';'+moneyAfter;
	if(!moneyChangeCheck()){
		return;
	}
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','4');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='4';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
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
	somChangeList.insert(somChangeList.getCount(),record);
	forCheck[forCheck.length]='2';
	closeChangeWin();
	somChangeList.commitChanges();
	applyType=applyType+",233";
	somElectronicDataSet_load();
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
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	forCheck[forCheck.length]='3';
	somChangeList.commitChanges();
	closeChangeWin();
	
}
//主管单位变更保存
function forBorgMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeAfter=record.get('changeAfter');
	if(changeAfter==''){
		L5.Msg.alert("提示","业务主管单位不能为空！");return;
	}
	if(!borgChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('borgNameBefore').value);
	record.set('changeItem','5');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='5';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	
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
//返回
function returnForLegalPeople(){
	var win=L5.getCmp("legalPeopleWin");
	win.hide();
}
//关闭负责人明细窗口
function closePeoplewin(){
	var win=L5.getCmp("peopleWin");
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
	//法定代表人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",233","");
		ifNeedChangeCatalog = "1";
	}
	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
}
//回退
function goBack(){
	history.go(-1);
}
//查看状态
function showStatus(){
	
}
//打印一次性补正材料通知书
function forPolishing(){
	var win=L5.getCmp("polishWin");
	win.show();	
}

//打印一次性补正材料通知书
function forAddItem(){
	var win=L5.getCmp("polishWin");
	win.hide();
	var addItem=document.getElementById("addItem").innerHTML;
	var printTitle="申办材料补正通知书";
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var record=somApplyDataSet.getCurrent();
	var printRecord = new L5.Map();
	var date=record.get('appDate');
	printRecord.put("ACCEPT_DATE",dataFormatForChange(date));
	printRecord.put("TASK_CODE",record.get('taskCode'));
	printRecord.put("APPLY_ITEM","基金会分支（代表）机构变更");
	printRecord.put("ADD_ITEM",addItem);
	var curPeople='<%=BspUtil.getEmpOrgan().getOrganName()%>';
	printRecord.put("CUR_PEOPLE",curPeople);
	var curOrgan='<%=BspUtil.getOrganName()%>';
	printRecord.put("CUR_ORGAN",curOrgan);
	printReport(getPrintDataByMap(printTitle,printRecord),L5.webPath+'/jsp/cams/sorg/apply/fund/mainChange/polish.fr3');
	
}

//打印不予受理通知书
function printNoAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;	
	window.open(url);	
}
//打印受理通知书
function printAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;	
	window.open(url);
}

function sendForPolishing(){

}
//打印变更证明
function printChangeSign(){
	
}
