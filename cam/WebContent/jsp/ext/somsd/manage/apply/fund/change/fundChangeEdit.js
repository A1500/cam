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
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'22',
			"sorgType":"J","ifBranch":'0',"morgName":userId,"morgArea":morgArea});

		somFlowAddDataset.newRecord({"curActivity":"受理","taskCode":taskCode,
		"sorgId":sorgId,"applyType":somApplyType,"dataSource":"ONLINE","sorgType":"J",
		"acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});
	}else{
		loadUpdate();
	}
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
	document.getElementById('appDate').value=sorgRecord.get('appDate');
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
//点击增加变更按钮
function forAdd(){
	if(sorgId==''){
		L5.Msg.alert("提示","请先输入登记证号选择基金会！");return;
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

//变更受理保存
function saveForCreate(){
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}

	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	if(somOrganDataSetIsValidate != true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		return false;
	}
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var newRecord=somFlowAddDataset.getCurrent();
	//somLegalPeople法定代表人用record
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeople!=''){
			command.setParameter("somLegalPeople", somLegalPeople);
		}
	}
	var organRecord = somOrganDataSet.getCurrent();
	newRecord.set("sorgId",sorgId);
	newRecord.set("appDate",document.getElementById("appDate").value);
	newRecord.set('sorgId',sorgId);
	newRecord.set('taskCode',taskCode);
	newRecord.set('sorgKind',sorgKind);
	newRecord.set('sorgName',organRecord.get('cnName'));

	command.setParameter("cnName", organRecord.get('cnName'));
	command.setParameter("sorgKind", sorgKind);
	command.setParameter("organRecord", organRecord);
	command.setParameter("opinion", newRecord);
	command.setParameter("sorgId", sorgId);
	command.setParameter("taskCode", taskCode);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("process", document.getElementById("process").value);

	command.setParameter("somResume", somResumeInsertDataSet.getAllRecords());

	command.execute("saveChange");

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
function goBack(){
	history.go(-1);
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
		somChangeDataset.removeAll();
		somChangeDataset.newRecord();

		if(num=='0'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
		//	document.getElementById('nameBefore').innerHTML=sorgOrganRecord.get('cnName');
		}else if(num=='1'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
		//	document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
		}else if(num=='2'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			//document.getElementById('leaPeopleNameBefore').innerHTML=sorgOrganRecord.get('legalPeople');
		}else if(num=='3'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
		//	document.getElementById('businessNameBefore').innerHTML=sorgOrganRecord.get("business");
		}else if(num=='4'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			//document.getElementById('moneyBefore').innerHTML=sorgOrganRecord.get("regMon");
			//document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
		}else if(num=='5'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			//document.getElementById('borgNameBefore').value=sorgOrganRecord.get("purpose");
		}else if(num=='6'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			//document.getElementById('fundTypeBefore').value=sorgOrganRecord.get("sorgKind");
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
	var houseNameBefore=document.getElementById('houseNameBefore').value;
	var changeBefore=houseNameBefore;
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','1');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='1';
	closeChangeWin();
	applyType=applyType+",228";
	somElectronicDataSet_load();
}
//资金变更保存
function forMoneyMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var moneySourceBefore=document.getElementById('moneySourceBefore').value;
	var moneyBefore=document.getElementById('moneyBefore').value;

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
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='4';
	closeChangeWin();
	applyType=applyType+",230";
	somElectronicDataSet_load();
}
//名称变更保存
function forNameMove(){

	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var nameBefore=document.getElementById('nameBefore').value;
	var nameAfter=document.getElementById('nameAfter').value;
	if(nameAfter==''){
		L5.Msg.alert("提示","名称不能为空！");return;
	}
	if(!nameChangeCheck()){
		return;
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
	closeChangeWin();
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
	record.set('changeBefore',document.getElementById('leaPeopleNameBefore').value);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','2');
	record.set('legalDutyId',somLegalPeople.get('dutyId'));
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='2';
	closeChangeWin();
	applyType=applyType+",229";
	somElectronicDataSet_load();
}
//业务范围变更保存
function forBusinessMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeBefore=document.getElementById('businessNameBefore').value;
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
	somChangeList.commitChanges();
	forCheck[forCheck.length]='3';
	closeChangeWin();

}
//宗旨变更保存
function forBorgMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var borgNameAfter=document.getElementById('borgNameAfter').value;
	if(borgNameAfter==''){
		L5.Msg.alert("提示","宗旨变更为不能为空！");return;
	}
	if(!borgChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('borgNameBefore').value);
	record.set('changeItem','5');
	record.set('changeAfter',borgNameAfter);
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='5';
	closeChangeWin();
}
//基金会类别变更保存
function forFundTypeMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	//var changeAfter=record.get('changeAfter');
	  var changeAfter=document.getElementById('fundTypeAfter').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","基金会类别不能为空！");return;
	}
	sorgKind = document.getElementById('fundTypeBefore').value;
	record.set('changeBefore',document.getElementById('fundTypeBefore').value);
	record.set('changeItem','6');
	record.set('changeAfter',changeAfter);
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	closeChangeWin();
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
//校验身份证
function idCardCheck(){
	if(_$("idCard")=="") return;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	//如果为身份证号，获取出生年月和性别
	if(_$("idCard").length==18){
		var record = somLegalPeopleDataSet.getCurrent();
		record.set("sex",getSexByCode(_$("idCard")));
		record.set("birthday",getBirthdayByCode(_$("idCard")));
		showAge();
	}
}
function ifPartyLeaderChange(){
	if(_$("ifPartyLeader")=="1"){
		$("promiseOrgan").style.display="block";
		$("promiseCode").style.display="block";
	}else{
		$("promiseOrgan").value="";
		$("promiseCode").value="";
		$("promiseOrgan").style.display="none";
		$("promiseCode").style.display="none";
	}
}
// 增加个人简历
function addResume(){
	somResumeInsertDataSet.newRecord({"dutyId":legalDutyId});
}

// 删除个人简历
function delResume(){
	var grid = L5.getCmp('somResumeGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				somResumeInsertDataSet.remove(records[0]);
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function confirm(){
	var IsValidate = somLegalPeopleDataSet.isValidate();
	if(IsValidate != true){
		L5.Msg.alert("提示",IsValidate);
		return false;
	}
	var record=somLegalPeopleDataSet.getCurrent();
	//维护照片信息
	if(_$("photoId1")){
		var newPhotoId = savePhoto(_$("photoId1"),"J");//保存照片到数据库并返回photoId
		if(newPhotoId!=null){
			somLegalPeopleDataSet.set("photoId",newPhotoId);
		}
	}

	if(record.get('ifServe')=='0'){
		record.set("regStatus","2");
	}
	record.set("nation",document.getElementById('nation').value);
	document.getElementById('leaPeopleNameAfter').value = record.get('name');
	somLegalPeople = somLegalPeopleDataSet.getCurrent();
	L5.getCmp("peopleWin").setVisible(false);
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}
function closePeopleWIns(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
function showAge(){
	var birthday=_$("birthday");
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}