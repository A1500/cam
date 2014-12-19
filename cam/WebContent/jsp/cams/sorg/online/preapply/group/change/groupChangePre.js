var sorgId='';
var sorgIdExist='';
var sorgKind='';
var cnName='';//社会团体名称
var sorgDuties='';//社会团体职务
var taskCode='';
var changeNUM='';
var sorgRecord='';
var catalogName='';//档案目录名
var forCheck= new Array();//检验变更事项用的数组
var somLegalPeople='';//法定代表人用record
var sorgOrganRecord='';//社会组织record
var changeItemNUM='';
var legalName="";
var fileCodeF="S028";
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
			somLegalPeopleElectronicDataSet.setParameter("applyType","023");
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
	sorgRecord.set("curOpinionId","1");

	document.getElementById('cnName').value=cnName;
	document.getElementById('appDate').value=sorgRecord.get('appDate');
	document.getElementById("process").value=sorgRecord.get('process');

	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("CN_NAME@=",cnName);
	somOrganDataSet.setParameter("IF_BRANCH@=","0");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.setParameter("sorg_type@=",'S');
	somOrganDataSet.load();
	somOrganDataSet.on('load',findSorg);

}
function findSorg(ds){
	ds.un('load',findSorg);
	if(ds.getCount() > 0 ){
		sorgOrganRecord= ds.getCurrent();
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

function forShow(somChangeList){
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			applyType=applyType+",021";
			forCheck[forCheck.length]='0';
		}else if(changeItem==1){
			applyType=applyType+",022";
			forCheck[forCheck.length]='1';
		}else if(changeItem==2){
			var changeRecord =records[i];
			applyType=applyType+",023";
			forCheck[forCheck.length]='2';

			var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
			somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
			somLegalPeopleDataSet.load();//法定代表人
			somLegalPeopleDataSet.on('load',function(){
				var idCard = somLegalPeopleDataSet.get('idCard');
				legalDutyId=somLegalPeopleDataSet.getCurrent().get("dutyId");
				somLegalPeople = somLegalPeopleDataSet.getCurrent();

				somDutyQueryDataSet.setParameter("ID_CARD",idCard);
				somDutyQueryDataSet.setParameter("SORG_ID",sorgIdExist);
				somDutyQueryDataSet.setParameter("IF_SERVE","1");
				somDutyQueryDataSet.setParameter("SORG_DUTIES!=","00012");
				somDutyQueryDataSet.load();
				somDutyQueryDataSet.on('load',function(){
				if(somDutyQueryDataSet.getCount() >= 1){
					var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
					//somLegalPeopleDataSet.removeAll();
					var somDutyRecords=somDutyQueryDataSet.getAllRecords();
					for(var j=0;j<somDutyRecords.length;j++){
						somLegalPeopleDataSet.set("peopleId",somDutyRecords[j].get("peopleId"));
						//somDutyRecords[j].set('dutyId',legalDutyId);
						//somLegalPeopleDataSet.insert(0,somDutyRecords[j]);
						//somLegalPeople=somDutyRecords[j];
						//somDutyRecords[j].set("dutyId",legalDutyId);
					}
					changeRecord.set("legalDutyId",legalDutyId);
				}else{
					ifPeopleExist = '0';
				}
				somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
				somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
				somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
				somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
				somLegalPeopleElectronicDataSet.setParameter("applyType","023");
				somLegalPeopleElectronicDataSet.load();
				var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
				somResumeLegalDataSet.setParameter("TASK_CODE",taskCode);
				somResumeLegalDataSet.load();
			});
		});
		}else if(changeItem==3){
			applyType=applyType+",024";
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			applyType=applyType+",025";
			forCheck[forCheck.length]='4';
		}else if(changeItem==5){
			applyType=applyType+",026";
			forCheck[forCheck.length]='5';
		}
		records[i].set("sorgId",sorgOrganRecord.get("sorgId"));
	}
	somElectronicDataSet_load();//加载法律要件
}
//保存
function saveOpinion(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somApplyDataSet.isValidate();
	var newRecord=somApplyDataSet.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	if(_$("appDate")==""){
		L5.Msg.alert("提示","申请时间不能为空！",function(){
			$("appDate").focus();
		});
		return false;
	}else{
		newRecord.set("appDate",_$("appDate"));
	}
	newRecord.set("sorgId",sorgIdExist);
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
	var somChangeRecords=somChangeList.getAllRecords();
	for(var i=0;i<somChangeRecords.length;i++){
		somChangeRecords[i].set("sorgId",sorgIdExist);
	}
	command.setParameter("Changes", somChangeRecords);//变更事项
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	command.setParameter("legalResumeRecords", somResumeLegalDataSet.getAllRecords());
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgIdExist);
	command.setParameter("sorgType","S");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","S");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("process", document.getElementById("process").value);

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
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somApplyDataSet.isValidate();
	var newRecord=somApplyDataSet.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	if(_$("appDate")==""){
		L5.Msg.alert("提示","申请时间不能为空！",function(){
			$("appDate").focus();
		});
		return false;
	}else{
		newRecord.set("appDate",_$("appDate"));
	}
	newRecord.set("sorgId",sorgIdExist);
	if(somLegalPeopleDataSet.getCount()!=0){
		var somLegalPeopleReocord = somLegalPeopleDataSet.getCurrent();
		somLegalPeopleReocord.set("taskCode",taskCode);
		if(ifPeopleExist == "0"){
				somLegalPeopleReocord.set("peopleId","");
		}
		command.setParameter("somLegalPeople", somLegalPeopleReocord);//法定代表人
	}

	var somChangeRecords=somChangeList.getAllRecords();
	for(var i=0;i<somChangeRecords.length;i++){
		somChangeRecords[i].set("sorgId",sorgIdExist);
	}
	command.setParameter("Changes", somChangeRecords);//变更事项
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	command.setParameter("legalResumeRecords", somResumeLegalDataSet.getAllRecords());
	command.setParameter("opinion", newRecord);
	command.setParameter("process", document.getElementById("process").value);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgIdExist);
	command.setParameter("sorgType","S");
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("taskCode", taskCode);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties","S");//使后台查不到此职务
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
//点击按钮法定代表人登记表
function addLegalPeople(){
	var changeAfter=document.getElementById('leaPeopleNameAfter').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","请先选择法定代表人！");
		return;
	}
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var num=somLegalPeopleDataSet.getCount();
	if(num == 0){
		L5.Msg.alert("提示","数据错误！");
		return;
	}
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",somLegalPeople.get('dutyId'));
	somResumeLegalDataSet.load();
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.getCurrent().get('idCard'));
	//加载照片
	synPhotoDetail(somLegalPeopleDataSet.get("photoId"),null);
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","023");
	somLegalPeopleElectronicDataSet.load();
}
//点击按钮查看法定代表人登记表
function detailLegalPeople(){
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.getCurrent().get('idCard'));
	//加载照片
	synPhotoDetail(somLegalPeopleDataSet.get("photoId"),null);
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","023");
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
		//somChangeDetail.setParameter("ID@=",id);
		//somChangeDetail.load();
		//somChangeDetail.on('load',forChangeShow);
		somChangeDetail.removeAll();
		somChangeDetail.insert(0,records[0]);
		var changeItem=records[0].get('changeItem');
		var win=L5.getCmp('AddChange'+changeItem);
		win.show();
		if(changeItem=='0'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('nameBefore1').innerHTML=changeBefores[0];
			document.getElementById('sorgGroupKindBefore1').value=changeBefores[1];
			document.getElementById('sorgBusScopeBefore1').value=changeBefores[2];

			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('nameAfter1').innerHTML=changeAfters[0];
			document.getElementById('sorgGroupKindAfter1').value=changeAfters[1];
			document.getElementById('sorgBusScopeAfter1').value=changeAfters[2];

		}else if(changeItem=='1'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('houseSourceBefore1').value=changeBefores[0];
			document.getElementById('houseNameBefore1').innerHTML=changeBefores[1];
			document.getElementById('houseBorgBefore1').innerHTML=changeBefores[2];
			document.getElementById('houseAreaBefore1').innerHTML=changeBefores[3];
			document.getElementById('houseDateBefore1').innerHTML=changeBefores[4];

			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('houseSourceAfter1').value=changeAfters[0];
			document.getElementById('houseNameAfter1').innerHTML=changeAfters[1];
			document.getElementById('houseBorgAfter1').innerHTML=changeAfters[2];
			document.getElementById('houseAreaAfter1').innerHTML=changeAfters[3];
			document.getElementById('houseDateAfter1').innerHTML=changeAfters[4];
		}else if(changeItem=='2'){
			document.getElementById('leaPeopleNameBefore1').innerHTML=records[0].get('changeBefore');
			document.getElementById('leaPeopleNameAfter1').value=records[0].get('changeAfter');
		}else if(changeItem=='3'){

		}else if(changeItem=='4'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[1];

			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');;
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[1];
		}else if(changeItem=='5'){
			document.getElementById('borgNameBefore1').value=records[0].get('changeBefore');
			document.getElementById('borgNameAfter1').value=records[0].get('changeAfter');
		}
		changeNUM=changeItem;
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
	var win=L5.getCmp('AddChange');
	win.hide();
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	somChangeDataset.newRecord();
	if(num=='0'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('nameBefore').innerHTML=sorgOrganRecord.get('cnName');
		document.getElementById('sorgGroupKindBefore').value=sorgOrganRecord.get('sorgKind');
		document.getElementById('sorgBusScopeBefore').value=sorgOrganRecord.get('busScope');
	}else if(num=='1'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('houseSourceBefore').value=sorgOrganRecord.get("resideSource");
		document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
		document.getElementById('houseBorgBefore').innerHTML=sorgOrganRecord.get("housingOrgan");
		document.getElementById('houseAreaBefore').innerHTML=sorgOrganRecord.get("housingArea");
		document.getElementById('houseDateBefore').innerHTML=sorgOrganRecord.get("leasePeriod");
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
	}

	changeItemNUM=num;
}

//住所变更保存
function forHouseMove(){
	if(!forCheckRepeat(1)){
		return;
	}
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var houseSourceAfter=document.getElementById('houseSourceAfter').value;
	var houseNameAfter=document.getElementById('houseNameAfter').value;
	var houseBorgAfter=document.getElementById('houseBorgAfter').value;
	var houseAreaAfter=document.getElementById('houseAreaAfter').value;
	var houseDateAfter=document.getElementById('houseDateAfter').value;

	var changeAfter=houseSourceAfter+';'+houseNameAfter+';'+houseBorgAfter+';'+houseAreaAfter+';'+houseDateAfter;
	if(!houseChangeCheck()){
		return;
	}
	var houseSourceBefore=document.getElementById('houseSourceBefore').value;
	var houseNameBefore=document.getElementById('houseNameBefore').innerHTML;
	var houseBorgBefore=document.getElementById('houseBorgBefore').innerHTML;
	var houseAreaBefore=document.getElementById('houseAreaBefore').innerHTML;
	var houseDateBefore=document.getElementById('houseDateBefore').innerHTML;
	var changeBefore=houseSourceBefore+';'+houseNameBefore+';'+houseBorgBefore+';'+houseAreaBefore+';'+houseDateBefore;
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','1');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='1';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	//somChangeList.reload();
	applyType=applyType+",022";
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
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",025";
	somElectronicDataSet_load();
}
//名称变更保存
function forNameMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var nameBefore=document.getElementById('nameBefore').innerHTML;
	var sorgGroupKindBefore=document.getElementById('sorgGroupKindBefore').value;
	var sorgBusScopeBefore=document.getElementById('sorgBusScopeBefore').value;
	var changeBefore=nameBefore+';'+sorgGroupKindBefore+';'+sorgBusScopeBefore;

	var nameAfter=document.getElementById('nameAfter').value;
	var sorgGroupKindAfter=document.getElementById('sorgGroupKindAfter').value;
	var sorgBusScopeAfter=document.getElementById('sorgBusScopeAfter').value;

	if(!nameChangeCheck()){
		return;
	}
	//检查新的社会团体名称是否已经存在
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",document.getElementById('nameAfter').value);
	command.execute('cnNameUK');
	var num=command.getReturn('cnNameNum');
	if(num!=0){
		L5.Msg.alert("提示","名称已经存在!");return;
	}
	var changeAfter=nameAfter+';'+sorgGroupKindAfter+';'+sorgBusScopeAfter;

	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','0');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='0';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",021";
	somElectronicDataSet_load();

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
	record.set("legalDutyId",somLegalPeople.get('dutyId'));
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='2';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",023";
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
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",024";
	somElectronicDataSet_load();

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
	applyType=applyType+",026";
	somElectronicDataSet_load();

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
	var win=L5.getCmp('AddChange1'+changeItemNUM);
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
							if(forCheck[i]=="2"){
								somLegalPeopleDataSet.removeAll();
								somResumeLegalDataSet.removeAll();
								ifPeopleExist = "0";
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
	somDutyDataSet.setParameter("SORG_ID",sorgId);
	somDutyDataSet.setParameter("IF_SERVE","1");
	somDutyDataSet.setParameter("REG_STATUS","1");
	somDutyDataSet.load();
	somDutyDataSet.on("load",function(){
		var records=somDutyDataSet.getAllRecords();
		for(var i=0;i<records.length;i++){
			if(records[i].get('sorgDuties') == legalDuties){
				somDutyDataSet.remove(records[i]);
			}
		}
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
	//名称变更
	if(changeItem=="0"){
		applyType=applyType.replace(",021","");
		ifNeedChangeCatalog = "1";
	}
	//住所变更
	if(changeItem=="1"){
		applyType=applyType.replace(",022","");
		ifNeedChangeCatalog = "1";
	}
	//法定代表人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",023","");
		ifNeedChangeCatalog = "1";
	}
	//业务范围变更
	if(changeItem=="3"){
		applyType=applyType.replace(",024","");
		ifNeedChangeCatalog = "1";
	}
	//注册资金变更
	if(changeItem=="4"){
		applyType=applyType.replace(",025","");
		ifNeedChangeCatalog = "1";
	}
	//业务主管单位变更
	if(changeItem=="5"){
		applyType=applyType.replace(",026","");
		ifNeedChangeCatalog = "1";
	}

	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
}
//点击上传法定代表人员附件按钮
function clickUploadLegalPeopleFile(){
	if($("labelIdCard").innerHTML == ""){
		L5.Msg.alert('提示','请先选中法定代表人');
		return false;
	}
	uploadLegalPeopleFile();
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
	printRecord.put("APPLY_ITEM","社会团体主体变更");
	printRecord.put("ADD_ITEM",addItem);
	var curPeople='<%=BspUtil.getEmpOrgan().getOrganName()%>';
	printRecord.put("CUR_PEOPLE",curPeople);
	var curOrgan='<%=BspUtil.getOrganName()%>';
	printRecord.put("CUR_ORGAN",curOrgan);
	printReport(getPrintDataByMap(printTitle,printRecord),L5.webPath+'/jsp/cams/sorg/apply/group/mainChange/polish.fr3');

}

//打印不予受理通知书
function printNoAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印受理通知书
function printAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}

function sendForPolishing(){

}
//打印变更证明
function printChangeSign(){

}

//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“登记证号！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
//根据登记证号加载基金会信息
function loadSorg(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var sorgName=document.getElementById('cnName').value;
	if(sorgName=='')return;
	somOrganDataSet.setParameter("CN_NAME@=",sorgName);
	somOrganDataSet.setParameter("IF_BRANCH@=","0");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.setParameter("sorg_type@=",'S');
	somOrganDataSet.load();
	somOrganDataSet.on('load',funAdd1);

}
//somOrganDataset加载时触发事件
function funAdd1(somOrganDataset){
	var num=somOrganDataset.getCount();
	if(num==0){
		L5.Msg.alert("提示","您输入的社会团体名称不存在或不是正常的状态！");
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