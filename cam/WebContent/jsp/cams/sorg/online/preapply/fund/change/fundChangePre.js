	var sorgId='';
	var sorgKind='';
	var cnName='';//基金会名称
	var sorgDuties='';//基金会职务
	var sorgRecord='';
	var catalogName='';//档案目录名
	var forCheck= new Array();//检验变更事项用的数组
	var somLegalPeople='';//法定代表人用record
	var sorgOrganRecord='';//社会组织record
	var changeItemNUM='';
	var catalogName='';//档案目录名
	var catalogId='';//档案目录ID
	var legalName="";
	var sorgIdExist='';
	var ifPeopleExist='1';
function init(){
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");

	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE@=",taskCode);
	somApplyDataSet.load();//社会组织
	somApplyDataSet.on('load',funAdd);
	var opinionSelect=L5.DatasetMgr.lookup("opinionSelect1");
	opinionSelect.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
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
			somLegalPeopleElectronicDataSet.setParameter("applyType","229");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});
	}
}
function funAdd(somApplyDataSet){
	somApplyDataSet.un('load',funAdd);
	sorgRecord= somApplyDataSet.getCurrent();
	sorgId=sorgRecord.get('sorgId');
	cnName=sorgRecord.get('sorgName');
	sorgKind=sorgRecord.get('sorgKind');

	document.getElementById('cnName').value=cnName;
	document.getElementById('appDate').value=sorgRecord.get('appDate');
	document.getElementById("process").value=sorgRecord.get('process');

	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("CN_NAME@=",cnName);
	somOrganDataSet.setParameter("IF_BRANCH@=","0");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.setParameter("sorg_type@=",'J');
	somOrganDataSet.load();
	somOrganDataSet.on('load',findSorg);

}
//社会组织
function findSorg(somOrganDataset){
	somOrganDataset.un('load',findSorg);
	if(somOrganDataset.getCount() > 0 ){
		sorgOrganRecord= somOrganDataset.getCurrent();
		sorgIdExist = sorgOrganRecord.get('sorgId');
		legalName=sorgOrganRecord.get("legalPeople");
		document.getElementById('sorgCode').innerHTML=sorgOrganRecord.get('sorgCode');
		document.getElementById('legalPeople').innerHTML=sorgOrganRecord.get('legalPeople');

		var somChangeList=L5.DatasetMgr.lookup("somChangeList");
		somChangeList.setParameter("TASK_CODE",taskCode);
		somChangeList.setParameter("CN_NAME",cnName);
		somChangeList.load();//变更
		somChangeList.on('load',forShow);
	}else{
		L5.Msg.alert("提示","没有找到此名称的社会组织的信息！");
		return false;
	}
}
//变更事项
function forShow(somChangeList){
	somChangeList.un('load',forShow);
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){//名称
			records[i].set("changeBefore",sorgOrganRecord.get('cnName'));
			forCheck[forCheck.length]='0';
		}else if(changeItem==1){//住所
			records[i].set("changeBefore",sorgOrganRecord.get("residence"));
			applyType=applyType+",228";
			forCheck[forCheck.length]='1';
		}else if(changeItem==2){
			records[i].set("changeBefore",sorgOrganRecord.get("legalPeople"));
			applyType=applyType+",229";
			forCheck[forCheck.length]='2';

			var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
			somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
			somLegalPeopleDataSet.load();//法定代表人
			somLegalPeopleDataSet.on('load',function(){
				var idCard = somLegalPeopleDataSet.get('idCard');
				legalDutyId= somLegalPeopleDataSet.get("dutyId");
				somLegalPeople = somLegalPeopleDataSet.getCurrent();

				somDutyQueryDataSet.setParameter("ID_CARD",idCard);
				somDutyQueryDataSet.setParameter("SORG_ID",sorgIdExist);
				somDutyQueryDataSet.setParameter("IF_SERVE","1");
				somDutyQueryDataSet.setParameter("SORG_DUTIES!=","00012");
				somDutyQueryDataSet.load();
				somDutyQueryDataSet.on('load',function(){
					if(somDutyQueryDataSet.getCount() >= 1){
						//somLegalPeopleDataSet.removeAll();
						var somDutyRecords=somDutyQueryDataSet.getAllRecords();
						for(var j=0;j<somDutyRecords.length;j++){
							somLegalPeopleDataSet.set("peopleId",somDutyRecords[j].get("peopleId"));
							//somDutyRecords[j].set('dutyId',legalDutyId);
							//somLegalPeopleDataSet.insert(0,somDutyRecords[j]);
							//somLegalPeople=somDutyRecords[j];
							//somDutyRecords[j].set("dutyId",legalDutyId);

						}
						records[i].set("legalDutyId",somDutyRecords[j].get("dutyId"));
					}else{
						ifPeopleExist = '0';
					}
				});
			});


		}else if(changeItem==3){
			records[i].set("changeBefore",sorgOrganRecord.get("business"));
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			var changeBefore= sorgOrganRecord.get("regMon")+";"+sorgOrganRecord.get("moneySource");
			records[i].set("changeBefore",changeBefore);
			applyType=applyType+",230";
			forCheck[forCheck.length]='4';
		}else if(changeItem==5){
			records[i].set("changeBefore",sorgOrganRecord.get("purpose"));
			forCheck[forCheck.length]='5';
		}else if(changeItem==6){
			records[i].set("changeBefore",sorgOrganRecord.get("sorgKind"));
			forCheck[forCheck.length]='6';
		}
	}
	somChangeList.commitChanges();
	somElectronicDataSet_load();//加载法律要件
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.setParameter("TASK_CODE@=",taskCode);
	somFlowAddDataset.load();
	//somFlowAddDataset.on('load',loadLegalPeopleDataSet);
}
function loadLegalPeopleDataSet(ds){
	ds.un('load',loadLegalPeopleDataSet);
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
	somLegalPeopleDataSet.load();
	somLegalPeopleDataSet.on("load",function(ds){
		if(ds.getCount()==1){
			legalDutyId=ds.get("dutyId");
		}
	});
}
//保存
function saveForCreate(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	var newRecord=somFlowAddDataset.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
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
	command.setParameter("Changes", somChangeList.getAllRecords());//变更事项
	command.setParameter("process",document.getElementById("process").value);//内部履行程序
	command.setParameter("taskCode", taskCode);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgIdExist);
	command.setParameter("sorgType","J");
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);

	if(ifPeopleExist == "1"){
		command.execute("saveForCreate");
	}
	if(ifPeopleExist == "0"){
		command.execute("savePreChangeOnline");
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
//发送下一步
function saveAndSend(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	var newRecord=somFlowAddDataset.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
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
	command.setParameter("Changes", somChangeList.getAllRecords());//变更事项
	command.setParameter("process",document.getElementById("process").value);//内部履行程序
	command.setParameter("taskCode", taskCode);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgId", sorgIdExist);
	command.setParameter("applyType", somApplyType);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgType","J");
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
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
//点击按钮法定代表人登记表
function addLegalPeople(){
	if(somLegalPeople==''){
		L5.Msg.alert("提示","请先选择法定代表人！");
		return;
	}
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("TASK_CODE",taskCode);
	somResumeLegalDataSet.load();
	somResumeLegalDataSet.on('load',function(){
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
function loadLegalPeople(ds){
	ds.un('load',loadLegalPeople);
	if(ds.getCount() == 0){
		ds.newRecord({sorgDuties:"00001","dutyId":legalDutyId,"ifServe":"1","ifPartyLeader":"0","sorgType":"J","ifLegal":"0","regStatus":"1"});
		L5.getCmp("legalPeopleWindow").show();
		initPhoto("1");//初始化照片
	}else{
		legalDutyId=ds.get("dutyId");
		var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
		somResumeLegalDataSet.setParameter("DUTY_ID",legalDutyId);
		somResumeLegalDataSet.load();
		//加载法定代表人法律要件
		somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
		somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
		somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
		somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
		somLegalPeopleElectronicDataSet.setParameter("applyType","229");
		somLegalPeopleElectronicDataSet.load();
		L5.getCmp("legalPeopleWindow").show();
		document.getElementById("labelAge").innerHTML=getAgeByCode(ds.getCurrent().get('idCard'));
		//synPhotoDetail(somLegalPeopleDataSet.get("photoId"),null);
	}
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}
//关闭变更window
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeItemNUM);
	win.hide();
}
//关闭变更window
function closeChangeDWin(){
	var win=L5.getCmp('AddChange1'+changeItemNUM);
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
		changeItemNUM=changeItem;
		if(changeItem=='0'){
			document.getElementById('nameBefore1').innerHTML=records[0].get('changeBefore');
			document.getElementById('nameAfter1').innerHTML=records[0].get('changeAfter');
		}else if(changeItem=='1'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('houseNameBefore1').innerHTML=records[0].get('changeBefore');
			document.getElementById('houseNameAfter1').innerHTML=records[0].get('changeAfter');
		}else if(changeItem=='2'){
			document.getElementById('leaPeopleNameBefore1').innerHTML=records[0].get('changeBefore');
		}else if(changeItem=='3'){

		}else if(changeItem=='4'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[1];

			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[1];
		}else if(changeItem=='5'){
			document.getElementById('borgNameBefore1').value=records[0].get('changeBefore');
		}else if(changeItem=='6'){
			var changeBefore=records[0].get('changeBefore');
			document.getElementById('fundTypeBefore1').value=changeBefore;
			var changeAfter=records[0].get('changeAfter');
			document.getElementById('fundTypeAfter1').value=changeAfter;
		}
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
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('nameBefore').innerHTML=sorgOrganRecord.get('cnName');
	}else if(num=='1'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
	}else if(num=='2'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('leaPeopleNameBefore').innerHTML=legalName;
	}else if(num=='3'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('businessNameBefore').innerHTML=sorgOrganRecord.get("business");
	}else if(num=='4'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('moneyBefore').innerHTML=sorgOrganRecord.get("regMon");
		document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
	}else if(num=='5'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('borgNameBefore').value=sorgOrganRecord.get("borgName");
	}else if(num=='6'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('fundTypeBefore').value=sorgOrganRecord.get("sorgKind");
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
	closeChangeDWin();
	applyType=applyType+",228";
	somElectronicDataSet_load();
}
//资金变更保存
function forMoneyMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var moneySourceBefore=document.getElementById('moneySourceBefore').innerHTML;
	var moneyBefore=document.getElementById('moneyBefore').innerHTML;

	var changeBefore=moneySourceBefore+';'+moneyBefore;

	var moneySourceAfter=document.getElementById('moneySourceAfter').value;
	var moneyAfter=document.getElementById('moneyAfter').value;

	var changeAfter=moneySourceAfter+';'+moneyAfter;
	if(!moneyChangeCheck()){
		return;
	}
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','4');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='4';
	closeChangeDWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",230";
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
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='0';
	closeChangeDWin();

}
//法定代表人变更保存
function forLeaPeopleMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeAfter=document.getElementById('leaPeopleNameAfter').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","法定代表人姓名不能为空！");return;
	}
	if(!leaPeopleChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('leaPeopleNameBefore').innerHTML);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','2');
	record.set('legalDutyId',somLegalPeople.get('dutyId'));
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='2';
	closeChangeDWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",229";
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
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='3';
	closeChangeDWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);


}
//主管单位变更保存
function forBorgMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var borgNameAfter=document.getElementById('borgNameAfter').value;
	if(borgNameAfter==''){
		L5.Msg.alert("提示","业务主管单位不能为空！");return;
	}
	if(!borgChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('borgNameBefore').value);
	record.set('changeItem','5');
	record.set('changeAfter',borgNameAfter);
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='5';
	closeChangeDWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);

}
//基金会类型保存
function forFundTypeMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	 var changeAfter=document.getElementById('fundTypeAfter').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","基金会类别不能为空！");return;
	}
	record.set('changeBefore',document.getElementById('fundTypeBefore').value);
	record.set('changeItem','6');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	record.set('changeAfter',changeAfter);
	forCheck[forCheck.length]='6';
	closeChangeDWin();
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
							if(forCheck[i]=="2"){
								somLegalPeopleDataSet.removeAll();
								somResumeLegalDataSet.removeAll();
								ifPeopleExist = "1";
								somLegalPeople='';
							}
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
//点击输入法定代表人姓名，执行操作
function forLegalPeople(){
	somDutyDataSet.setParameter("SORG_ID",sorgIdExist);
	somDutyDataSet.setParameter("IF_SERVE","1");
	somDutyDataSet.setParameter("REG_STATUS","1");
	somDutyDataSet.load();
	somDutyDataSet.on("load",function(){
		somDutyDataSet.filterBy(function(record, id){
			if("00001,00003,00004,00005".indexOf(record.get('sorgDuties'))>-1){
				return record;
			}
		});
	});

	var win=L5.getCmp('legalPeopleWin');
	win.show();
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
//根据登记证号加载基金会信息
function loadSorg(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var sorgName=document.getElementById('cnName').value;
	if(sorgName=='')return;
	somOrganDataSet.setParameter("CN_NAME@=",sorgName);
	somOrganDataSet.setParameter("IF_BRANCH@=","0");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.setParameter("sorg_type@=",'J');
	somOrganDataSet.load();
	somOrganDataSet.on('load',funAdd1);

}
//somOrganDataset加载时触发事件
function funAdd1(somOrganDataset){
	var num=somOrganDataset.getCount();
	if(num==0){
		L5.Msg.alert("提示","您输入的基金会名称不存在或不是正常的状态！");
		document.getElementById('sorgCode').innerHTML='';
		document.getElementById('legalPeople').innerHTML='';
		sorgIdExist='';
		return;
	}else{
		sorgOrganRecord= somOrganDataset.getCurrent();
		sorgIdExist=sorgOrganRecord.get('sorgId');
		sorgCode=sorgOrganRecord.get('sorgCode');
		document.getElementById('sorgCode').innerHTML=sorgCode;
		document.getElementById('legalPeople').innerHTML=sorgOrganRecord.get('legalPeople');
		sorgKind=sorgOrganRecord.get('sorgKind');
		var somChangeList=L5.DatasetMgr.lookup("somChangeList");
		somChangeList.setParameter("TASK_CODE@=",taskCode);
		somChangeList.load();//变更
		somChangeList.on('load',forShow);

		somElectronicDataSet_load();//加载法律要件
	}
}
