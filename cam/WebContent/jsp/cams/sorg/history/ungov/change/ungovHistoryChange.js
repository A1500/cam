var sorgId='';//社团ID
var cnName='';//社团名称
var sorgCode='';//登记证号
var applyType='118';//法律要件业务类型
var fileCodeF="M044";
var forCheck= new Array();//检验变更事项用的数组
var sorgOrganRecord='';//社会组织record
var changeItemNUM='';
var sorgDuties='';//社团职务
var sorgKind='';
var legalName="";
function init(){
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		var somFlowAddDataset= L5.DatasetMgr.lookup("somFlowAddDataset");
		somFlowAddDataset.newRecord({"taskCode":taskCode,"applyType":somApplyType,"dataSource":"MEND","sorgType":"M","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
	}else{
		loadUpdate();
	}
	L5.getCmp("legalPeopleWindow").on("beforehide",function(){
		if(_$("photoId")){
			somLegalPeopleDataSet.set("photoText",_$("photoId"));
			somLegalPeopleDataSet.set("photoPath","1");
		}
	});
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
		sorgKind=sorgRecord.get('sorgKind');
		document.getElementById('cnName').innerHTML=cnName;
		document.getElementById('acceptTime').value=sorgRecord.get('appDate');
		//document.getElementById("process").value=sorgRecord.get('process');
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=",sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',findSorg);

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
function findSorg(somOrganDataset){
	sorgOrganRecord= somOrganDataset.getCurrent();
	legalName=sorgOrganRecord.get("legalPeople");
	document.getElementById("legalPeople").innerHTML=legalName;
	document.getElementById("sorgCode").value=sorgOrganRecord.get('sorgCode');
}
//根据登记证号加载社团信息
function loadSorg(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	sorgCode=document.getElementById('sorgCode').value;
	if(sorgCode=='')return;
	somOrganDataSet.setParameter("sorg_Code@=",sorgCode);
	somOrganDataSet.setParameter("sorg_type@=","M");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.load();
	somOrganDataSet.on('load',funAdd);
}
//somOrganDataset加载时触发事件
function funAdd(somOrganDataset){
	var num=somOrganDataset.getCount();
	if(num==0){
		L5.Msg.alert("提示","您输入的登记证号不存在！");
		document.getElementById('cnName').innerHTML='';
		document.getElementById('legalPeople').innerHTML='';
		sorgId='';
		return;
	}else{
		sorgOrganRecord= somOrganDataset.getCurrent();
		sorgId=sorgOrganRecord.get('sorgId');
		cnName=sorgOrganRecord.get('cnName');
		document.getElementById('cnName').innerHTML=cnName;
		document.getElementById('legalPeople').innerHTML=sorgOrganRecord.get('legalPeople');
		sorgKind=sorgOrganRecord.get('sorgKind');
		somElectronicDataSet_load();//加载法律要件
	}
}
//变更受理保存
function saveForCreate(){
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	var newRecord=somFlowAddDataset.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.history.ungov.cmd.SomUngovHistoryCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeopleDataSet.getCurrent()!=''){
			command.setParameter("somLegalPeople", somLegalPeopleDataSet.getCurrent());
			var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
			command.setParameter("legalResumeRecords",somLegalPeopleResumeDataSet.getAllRecords());
		}
	}
	newRecord.set("taskCode",taskCode);
	newRecord.set("appDate",document.getElementById("acceptTime").value);
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","M");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties",legalDuties);
	command.setParameter("applyType", somApplyType);
	//command.setParameter("process", document.getElementById("process").value);

	if(method=="INSERT"){
		command.execute("saveChange");
	}else{
		command.execute("updateChange");
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
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	var newRecord=somFlowAddDataset.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.history.ungov.cmd.SomUngovHistoryCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeopleDataSet.getCurrent()!=''){
			command.setParameter("somLegalPeople", somLegalPeopleDataSet.getCurrent());
			var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
			command.setParameter("legalResumeRecords",somLegalPeopleResumeDataSet.getAllRecords());
		}
	}
	newRecord.set("taskCode",taskCode);
	newRecord.set("appDate",document.getElementById("acceptTime").value);
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","M");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties",legalDuties);
	command.setParameter("applyType", somApplyType);
	//command.setParameter("process", document.getElementById("process").value);
	command.execute("updateChangeOnly");
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
//点击增加变更按钮
function forAdd(){
	if(sorgId==''){
		L5.Msg.alert("提示","请先输入登记证号选择社团！");return;
	}
	var win=L5.getCmp('AddChange');
	win.show();
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
	if(method=="UPDATE"){
		var data=new L5.Map();
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(document.getElementById('cnName').innerHTML)));
		data.put("searchSorgCode",_$("sorgCode"));
		url="jsp/cams/sorg/history/ungov/change/ungovHistoryChangeList.jsp";
		L5.forward(url,'',data);
	}else{
		history.go(-1);
	}
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
		document.getElementById('houseSourceBefore').value=sorgOrganRecord.get("resideSource");
		document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
		document.getElementById('houseBorgBefore').innerHTML=sorgOrganRecord.get("housingOrgan");
		document.getElementById('houseAreaBefore').innerHTML=sorgOrganRecord.get("housingArea");
		document.getElementById('houseDateBefore').innerHTML=sorgOrganRecord.get("leasePeriod");
	}else if(num=='2'){
		var win=L5.getCmp('AddChange'+num);
		win.show();

		document.getElementById('leaPeopleNameBefore').innerHTML=sorgOrganRecord.get('legalPeople');
	}else if(num=='3'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('businessNameBefore').innerHTML=sorgOrganRecord.get("business");
	}else if(num=='4'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		//document.getElementById('moneyPeopleBefore').innerHTML=sorgOrganRecord.get("fundingPeople");
		//document.getElementById('moneyborgBefore').innerHTML=sorgOrganRecord.get("checkCapitalOrgan");
		document.getElementById('moneyBefore').innerHTML=sorgOrganRecord.get("regMon");
		document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
	}else if(num=='5'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('borgNameBefore').value=sorgOrganRecord.get("borgName");
	}else if(num=='7'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('monPeopleChangeBefore').value=sorgOrganRecord.get("fundingPeople");
	}
	changeItemNUM=num;
}
//住所变更保存
function forHouseMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var houseSourceAfter=document.getElementById('houseSourceAfter').value;
	var houseNameAfter=document.getElementById('houseNameAfter').value;
	var houseBorgAfter=document.getElementById('houseBorgAfter').value;
	var houseAreaAfter=document.getElementById('houseAreaAfter').value;
	var houseDateAfter=document.getElementById('houseDateAfter').value;

	if(!houseChangeCheck()){
		return;
	}
	var changeAfter=houseSourceAfter+';'+houseNameAfter+';'+houseBorgAfter+';'+houseAreaAfter+';'+houseDateAfter;
	var houseSourceBefore=document.getElementById('houseSourceBefore').value;
	var houseNameBefore=document.getElementById('houseNameBefore').innerHTML;
	var houseBorgBefore=document.getElementById('houseBorgBefore').innerHTML;
	var houseAreaBefore=document.getElementById('houseAreaBefore').innerHTML;
	var houseDateBefore=document.getElementById('houseDateBefore').innerHTML;
	var changeBefore=houseSourceBefore+';'+houseNameBefore+';'+houseBorgBefore+';'+houseAreaBefore+';'+houseDateBefore;
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','1');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("1");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='1';
	closeChangeWin();
	applyType=applyType+",120";
	somElectronicDataSet_load();

}
//资金变更保存
function forMoneyMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	//var moneyPeopleBefore=document.getElementById('moneyPeopleBefore').innerHTML;
	//var moneyborgBefore=document.getElementById('moneyborgBefore').innerHTML;
	var moneySourceBefore=document.getElementById('moneySourceBefore').innerHTML;
	var moneyBefore=document.getElementById('moneyBefore').innerHTML;

	var changeBefore=moneySourceBefore+';'+moneyBefore;

	//var moneyPeopleAfter=document.getElementById('moneyPeopleAfter').value;
	//var moneyborgAfter=document.getElementById('moneyborgAfter').value;
	var moneySourceAfter=document.getElementById('moneySourceAfter').value;
	var moneyAfter=document.getElementById('moneyAfter').value;


	var changeAfter=moneySourceAfter+';'+moneyAfter;
	if(!moneyChangeCheck()){
		return;
	}
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','4');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("4");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='4';
	closeChangeWin();
	applyType=applyType+",123";
	somElectronicDataSet_load();
}
//名称变更保存
function forNameMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var nameBefore=document.getElementById('nameBefore').innerHTML;
	var nameAfter=document.getElementById('nameAfter').value;

	if(!nameChangeCheck()){
		return;
	}
	//检查新的民办非企业单位名称是否已经存在
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
	closeChangeWin();
	applyType=applyType+",119";
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
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("2");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='2';
	closeChangeWin();
	applyType=applyType+",121";
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
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("3");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='3';
	closeChangeWin();
	applyType=applyType+",122";
	somElectronicDataSet_load();

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
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("5");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='5';
	closeChangeWin();
	applyType=applyType+",124";
	somElectronicDataSet_load();
}
//出资人变更保存
function forMonPeopleMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var monPeopleChangeBefore=document.getElementById('monPeopleChangeBefore').value;
	var monPeopleChangeAfter=document.getElementById('monPeopleChangeAfter').value;

	if(monPeopleChangeAfter==''){
		L5.Msg.alert("提示","出资人不能为空，未变更填写变更前内容！");return;
	}
	if(!monPeopleChangeCheck()){
		return;
	}
	record.set('changeBefore',monPeopleChangeBefore);
	record.set('changeAfter',monPeopleChangeAfter);
	record.set('changeItem','7');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("7");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='7';
	closeChangeWin();
	applyType=applyType+",125";
	somElectronicDataSet_load();
}
//检查是否重复变更
function forCheckRepeat(number){
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==number){
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
			document.getElementById('houseSourceBefore1').value=changeBefores[0];
			document.getElementById('houseNameBefore1').innerHTML=changeBefores[1];
			document.getElementById('houseBorgBefore1').innerHTML=changeBefores[2];
			document.getElementById('houseAreaBefore1').innerHTML=changeBefores[3];
			document.getElementById('houseDateBefore1').innerHTML=changeBefores[4];

			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('houseSourceAfter1').value=changeAfters[0];
			document.getElementById('houseNameAfter1').innerHTML=changeAfters[1];
			document.getElementById('houseBorgAfter1').innerHTML=changeAfters[2];
			document.getElementById('houseAreaAfter1').innerHTML=changeAfters[3];
			document.getElementById('houseDateAfter1').innerHTML=changeAfters[4];
			//document.getElementById('housechangeDesc').value=record.get('changeDesc');
			//document.getElementById('housechangeReason').value=record.get('changeReason');
		}else if(num=='2'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('leaPeopleNameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter1').innerHTML=record.get('changeAfter');
			//document.getElementById('peoplechangeDesc').value=record.get('changeDesc');
			//document.getElementById('peoplechangeReason').value=record.get('changeReason');
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
//修改变更
function forUpdate(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	somChangeDataset.newRecord();
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
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('nameBefore').innerHTML=record.get('changeBefore');
			document.getElementById('nameAfter').value=record.get('changeAfter');
			document.getElementById('nameDesc').value=record.get('changeDesc');
			document.getElementById('nameReason').value=record.get('changeReason');
		}else if(num=='1'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('houseSourceBefore').value=changeBefores[0];
			document.getElementById('houseNameBefore').innerHTML=changeBefores[1];
			document.getElementById('houseBorgBefore').innerHTML=changeBefores[2];
			document.getElementById('houseAreaBefore').innerHTML=changeBefores[3];
			document.getElementById('houseDateBefore').innerHTML=changeBefores[4];

			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('houseSourceAfter').value=changeAfters[0];
			document.getElementById('houseNameAfter').value=changeAfters[1];
			document.getElementById('houseBorgAfter').value=changeAfters[2];
			document.getElementById('houseAreaAfter').value=changeAfters[3];
			document.getElementById('houseDateAfter').value=changeAfters[4];
			document.getElementById('houseDesc').value=record.get('changeDesc');
			document.getElementById('houseReason').value=record.get('changeReason');
		}else if(num=='2'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('leaPeopleNameBefore').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter').value=record.get('changeAfter');
			document.getElementById('leaPeopleDesc').value=record.get('changeDesc');
			document.getElementById('leaPeopleReason').value=record.get('changeReason');
		}else if(num=='3'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('businessNameBefore').value=record.get('changeBefore');
			document.getElementById('businessNameAfter').value=record.get('changeAfter');
			document.getElementById('businessDesc').value=record.get('changeDesc');
			document.getElementById('businessReason').value=record.get('changeReason');
		}else if(num=='4'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneySourceBefore').innerHTML=changeBefores[0];
			document.getElementById('moneyBefore').innerHTML=changeBefores[1];

			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('moneySourceAfter').value=changeAfters[0];
			document.getElementById('moneyAfter').value=changeAfters[1];

			document.getElementById('moneyDesc').value=record.get('changeDesc');
			document.getElementById('moneyReason').value=record.get('changeReason');
		}else if(num=='5'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('borgNameBefore').value=record.get('changeBefore');
			document.getElementById('borgNameAfter').value=record.get('changeAfter');
			document.getElementById('borgDesc').value=record.get('changeDesc');
			document.getElementById('borgReason').value=record.get('changeReason');
		}else if(num=='7'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('monPeopleChangeBefore').value=record.get('changeBefore');
			document.getElementById('monPeopleChangeAfter').value=record.get('changeAfter');
			document.getElementById('monPeopleChangeDesc').value=record.get('changeDesc');
			document.getElementById('monPeopleChangeReason').value=record.get('changeReason');
		}
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//点击输入法定代表人姓名，执行操作
function forLegalPeople(){
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","121");
	somLegalPeopleElectronicDataSet.load();
	if(somLegalPeopleDataSet.getCount() == 0){
		somLegalPeopleDataSet.newRecord();
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	initPhotoDetail(null);//初始化照片
}
//法定代表人录入中输入身份证号进行查询
function checkPeopleInfo(){
	var idCard=document.getElementById("idCard").value;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		initPhotoDetail(null);//初始化照片
		return;
	}
	if(_$('idCard')!=""){
		var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
		winPeopleDataSet.setParameter("ID_CARD@=",_$('idCard'));
		winPeopleDataSet.load();
		winPeopleDataSet.on("load",function(ds){
			if(ds.getCount() > 0){
				var win_peopleValidate=L5.getCmp("win_peopleValidate");
				win_peopleValidate.show();
			}

		});
	}
	initPhoto(null);//初始化照片
}
//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	somLegalPeopleDataSet.removeAll();
	var record = somLegalPeopleDataSet.newRecord();
	record.set("idCard",idCard);
	//回填性别
	record.set("sex",getSexByCode(idCard));
	//回填出生年月
	record.set("birthday",getBirthByCode(idCard));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCard);

	var win = L5.getCmp("win_peopleValidate");
	win.hide();
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
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	somLegalPeopleDataSet.removeAll();
	var newRecord = somLegalPeopleDataSet.newRecord();

		/*var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
		command.setParameter("peopleId", record.get('peopleId'));
		command.setParameter("sorgType", record.get('sorgType'));
		command.execute("checkLegalPeopleRepeat");
		var flag=command.getReturn("flag");
		if(flag != "true"){
			L5.MessageBox.confirm('确定', record.get("name")+flag+" 是否继续选定？",function(sta){
				if(sta=="yes"){

				}
				else return;
			});
			return;
		}

		L5.MessageBox.confirm('确定', '选定[ '+record.get("name")+' ]为法定代表人？',function(sta){
			if(sta=="yes"){

			}
			else return;
		});	*/

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
	newRecord.set("ifLegal",record.get("ifLegal"));
	newRecord.set("photoId",record.get("photoId"));

	//synPhoto(newRecord.get("photoId"),null);//同步照片

	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//关闭窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//选择是否党政机关领导
function valid_ifPartyLeader_add(){
	if(document.getElementById('ifPartyLeader_add').value == '1'){
		document.getElementById('promiseOrgan_add').style.display="block";
		document.getElementById('promiseCode_add').style.display="block";
	}else{
		document.getElementById('promiseOrgan_add').style.display="none";
		document.getElementById('promiseCode_add').style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
	}
}
// 增加个人简历
function addResume(){
	var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	somLegalPeopleResumeDataSet.newRecord();
}
// 删除个人简历
function delResume(){
	var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	var record=somLegalPeopleResumeDataSet.getCurrent();
	if(record!=null){
		somLegalPeopleResumeDataSet.remove(record);
	}
}
//点击确定 保存一条负责人信息
function confirm(){
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	//校验
	var somLegalPeopleValidate = somLegalPeopleDataSet.isValidate();
	if(somLegalPeopleValidate != true){
		L5.Msg.alert("提示",somLegalPeopleValidate);
		return false;
	}

	var record=somLegalPeopleDataSet.getCurrent();
	record.set("ifServe","1");

	//处理个人简历
	var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	for(var i=somLegalPeopleResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeInsertRecord =somLegalPeopleResumeDataSet.getAt(i);
		somResumeInsertRecord.set("peopleId",record.get("peopleId"));
	}

	document.getElementById("leaPeopleNameAfter").value=record.get("name");

	var win=L5.getCmp("legalPeopleWindow");
	win.hide();
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}
function closePeopleDetailWIn(){
	var win = L5.getCmp("detailLegalPeopleWindow");
	win.hide();
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
//变更项删除，同步隐藏该变更项所需法律要件
//changeItem：变更项的值
function hideDeletedCatalog(changeItem){
	var ifNeedChangeCatalog = "0";
	//名称变更
	if(changeItem=="0"){
		applyType=applyType.replace(",119","");
		ifNeedChangeCatalog = "1";
	}
	//住所变更
	if(changeItem=="1"){
		applyType=applyType.replace(",120","");
		ifNeedChangeCatalog = "1";
	}
	//法定代表人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",121","");
		ifNeedChangeCatalog = "1";
	}
	//业务范围变更
	if(changeItem=="3"){
		applyType=applyType.replace(",122","");
		ifNeedChangeCatalog = "1";
	}
	//开办资金变更
	if(changeItem=="4"){
		applyType=applyType.replace(",123","");
		ifNeedChangeCatalog = "1";
	}
	//业务主管单位变更
	if(changeItem=="5"){
		applyType=applyType.replace(",124","");
		ifNeedChangeCatalog = "1";
	}
	//出资人变更
	if(changeItem=="7"){
		applyType=applyType.replace(",125","");
		ifNeedChangeCatalog = "1";
	}

	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
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