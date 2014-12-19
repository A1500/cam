	var cnName='';//社团名称
	var sorgCode='';//登记证号
	var applyType='027';//法律要件业务类型
	var fileCodeF="S064";
	var forCheck= new Array();//检验变更事项用的数组
	var somLegalPeople='';//法定代表人用record
	var sorgOrganRecord='';//社会组织record
	var changeItemNUM='';
	var sorgDuties='';//社团职务
	var sorgKind='';
	var legalName="";
	var somLegalPeople='';//分支负责人record
function init(){
	L5.getCmp("tab").setActiveTab("0");
	if(method=="INSERT"){
		var somFlowAddDataset= L5.DatasetMgr.lookup("somFlowAddDataset");
		somFlowAddDataset.newRecord({"curActivity":"受理","taskCode":taskCode,"sorgId":sorgId,"applyType":somApplyType,"dataSource":"ONLINE","sorgType":"S","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});
		somOrganDataSet.newRecord({"mainSorgName":userId,"mainSorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'22',"sorgType":"S","ifBranch":'1',"morgName":userId,"morgArea":morgArea});
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
		//	somLegalPeopleElectronicDataSet.setParameter("applyType","030");
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
//加载Flow
function loadUpdate(){
	var somFlowAddDataset= L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.setParameter("TASK_CODE",taskCode);
	somFlowAddDataset.load();
	somFlowAddDataset.on('load',loadOrgan);
}
//加载社会组织
function loadOrgan(ds){
	ds.un('load',loadOrgan);
	sorgRecord= ds.getCurrent();
	sorgId=sorgRecord.get('sorgId');
	taskCode=sorgRecord.get('taskCode');
	document.getElementById('appDate').value=sorgRecord.get('appDate');
	document.getElementById("process").value=sorgRecord.get('process');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadChange);
}
//加载变更信息
function loadChange(ds){
	ds.un('load',loadChange);
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE@=",taskCode);
	somChangeList.load();//变更
	somChangeList.on('load',forShow);
}
//处理变更
function forShow(somChangeList){
	//通过taskCode得到文件
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			applyType=applyType+",028";
			forCheck[forCheck.length]='0';
		}else if(changeItem==1){
			applyType=applyType+",029";
			forCheck[forCheck.length]='1';
		}else if(changeItem==2){
			applyType=applyType+",030";
			forCheck[forCheck.length]='2';
			var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
			somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
			somLegalPeopleDataSet.load();
			somLegalPeopleDataSet.on('load',function(){
				if(somLegalPeopleDataSet.getCount() >= 1){
					somLegalPeople=somLegalPeopleDataSet.getAt(0);
				}
				var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
				somLegalPeopleResumeDataSet.setParameter("PEOPLE_ID",somLegalPeople.get("people_id"));
				somLegalPeopleResumeDataSet.load();

			});
		}else if(changeItem==3){
			applyType=applyType+",031";
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			forCheck[forCheck.length]='4';
		}else if(changeItem==5){
			forCheck[forCheck.length]='5';
		}
	}
	somElectronicDataSet_load();//加载法律要件
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
//点击按钮，填写法定代表人登记表
function addLegalPeople(){
	if(somLegalPeopleDataSet.getCount()!=1){
		L5.Msg.alert("提示","请先备案负责人！");
		return;
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.get('idCard'));
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",somLegalPeopleDataSet.get('dutyId'));
	somResumeLegalDataSet.load();

	legalDutyId = somLegalPeopleDataSet.get("dutyId");
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","030");
	somLegalPeopleElectronicDataSet.load();
}

//变更受理保存
function saveForCreate(){
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		return false;
	}
	if(_$("appDate")==""){
		L5.Msg.alert("提示","申请时间不能为空！");return;
	}
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
	//somLegalPeople法定代表人用record
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.group.cmd.SomGroupOnlineCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeople!=''){
			command.setParameter("somLegalPeople", somLegalPeople);
		}
	}
	newRecord.set('appDate',document.getElementById('appDate').value);
	newRecord.set('sorgName',document.getElementById('cnName').value);
	newRecord.set('process',document.getElementById('process').value);
	command.setParameter("somOrganRecord", somOrganDataSet.getCurrent());
	var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	command.setParameter("legalResumeRecords", somLegalPeopleResumeDataSet.getAllRecords());
	command.setParameter("somApply", newRecord);
	command.setParameter("legalDutyId", legalDutyId);
	command.setParameter("sorgType","S");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","S");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);

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
	somChangeDataset.newRecord();

	if(num=='0'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
	}else if(num=='1'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
	}else if(num=='2'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
	}else if(num=='3'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
	}else if(num=='4'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
	}else if(num=='5'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
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
	var houseNameBefore=document.getElementById('houseNameBefore').value;
	var houseBorgBefore=document.getElementById('houseBorgBefore').value;
	var houseAreaBefore=document.getElementById('houseAreaBefore').value;
	var houseDateBefore=document.getElementById('houseDateBefore').value;
	var changeBefore=houseSourceBefore+';'+houseNameBefore+';'+houseBorgBefore+';'+houseAreaBefore+';'+houseDateBefore;
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','1');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	forCheck[forCheck.length]='1';
	closeChangeWin();
	applyType=applyType+",029";
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
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	forCheck[forCheck.length]='4';
	closeChangeWin();
}
//名称变更保存
function forNameMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var nameBefore=document.getElementById('nameBefore').value;
	var sorgGroupKindBefore=document.getElementById('sorgGroupKindBefore').value;
	var sorgBusScopeBefore=document.getElementById('sorgBusScopeBefore').value;

	var nameAfter=document.getElementById('nameAfter').value;
	var sorgGroupKindAfter=document.getElementById('sorgGroupKindAfter').value;
	var sorgBusScopeAfter=document.getElementById('sorgBusScopeAfter').value;

	if(!nameChangeCheck()){
		return;
	}
	var changeBefore=nameBefore+';'+sorgGroupKindBefore+';'+sorgBusScopeBefore;
	var changeAfter=nameAfter+';'+sorgGroupKindAfter+';'+sorgBusScopeAfter;

	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','0');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	forCheck[forCheck.length]='0';
	closeChangeWin();
	applyType=applyType+",028";
	somElectronicDataSet_load();
}
//负责人变更保存
function forLeaPeopleMove(){
	//修改逻辑，因为法定代表人改为可以修改，查看明细里边的法定代表人其实是修改的，此处如果列表中选中的是法定代表人的的，说明是对法定代表人修改的，先删除原有的那条，然后插入
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var recordSelect = sm.getSelected();
	if(recordSelect!=null && recordSelect.get("changeItem") == "2"){
		somChangeList.remove(recordSelect);
	}
	//修改逻辑，因为法定代表人改为可以修改，查看明细里边的法定代表人其实是修改的，此处如果列表中选中的是法定代表人的的，说明是对法定代表人修改的，先删除原有的那条，然后插入
	//完成

	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeAfter=document.getElementById('leaPeopleNameAfter').value;
	var changeReason=document.getElementById('leaPeopleReason').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","法定代表人姓名不能为空！");return;
	}
	if(!leaPeopleChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('leaPeopleNameBefore').value);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','2');
	record.set('changeReason',changeReason);
	somChangeList.insert(somChangeList.getCount(),record);
	forCheck[forCheck.length]='2';
	closeChangeWin();
	applyType=applyType+",030";
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
	closeChangeWin();
	applyType=applyType+",031";
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
	record.set('changeBefore',document.getElementById('borgNameBefore').innerHTML);
	record.set('changeItem','5');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	forCheck[forCheck.length]='5';
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
		var num=record.get('changeItem');
		changeItemNUM=num;
		if(num=='0'){
			var win=L5.getCmp('detail'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('nameBefore1').innerHTML=changeBefores[0];
			document.getElementById('sorgGroupKindBefore1').value=changeBefores[1];
			document.getElementById('sorgBusScopeBefore1').value=changeBefores[2];

			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('nameAfter1').innerHTML=changeAfters[0];
			document.getElementById('sorgGroupKindAfter1').value=changeAfters[1];
			document.getElementById('sorgBusScopeAfter1').value=changeAfters[2];
			document.getElementById('namechangeReason').value=record.get('changeReason');
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
			document.getElementById('housechangeReason').value=record.get('changeReason');
		}else if(num=='2'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
			somChangeDataset.newRecord();
			document.getElementById('leaPeopleNameBefore').value=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter').value=record.get('changeAfter');
			document.getElementById('leaPeopleReason').value=record.get('changeReason');
		}else if(num=='3'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('areaChangeBefore').value=record.get('changeBefore');
			document.getElementById('areaChangeAfter').value=record.get('changeAfter');
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

			document.getElementById('moneychangeReason').value=record.get('changeReason');
		}else if(num=='5'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('borgNameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('borgNameAfter1').innerHTML=record.get('changeAfter');
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
		applyType=applyType.replace(",028","");
		ifNeedChangeCatalog = "1";
	}
	//住所变更
	if(changeItem=="1"){
		applyType=applyType.replace(",029","");
		ifNeedChangeCatalog = "1";
	}
	//负责人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",030","");
		ifNeedChangeCatalog = "1";
	}
	//业务范围变更
	if(changeItem=="3"){
		applyType=applyType.replace(",031","");
		ifNeedChangeCatalog = "1";
	}
	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
}
function closeChangeWinD(){
	var win=L5.getCmp('detail'+changeItemNUM);
	win.hide();
}

function confirmInfo(){
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	//校验
	var somLegalPeopleValidate = somLegalPeopleDataSet.isValidate();
	if(somLegalPeopleValidate != true){
		L5.Msg.alert("提示",somLegalPeopleValidate);
		return false;
	}

	somLegalPeople=somLegalPeopleDataSet.getCurrent();
	//邮编
	var postCode=somLegalPeople.get("postCode");
	if(postCode!=""&&_isPostCode(postCode) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
	somLegalPeople.set("ifServe","1");
	somLegalPeople.set("promiseOrgan",document.getElementById('promiseOrgan_add').value);
	somLegalPeople.set("promiseCode",document.getElementById('promiseCode_add').value);


	document.getElementById("leaPeopleNameAfter").value=somLegalPeople.get("name");

	var win=L5.getCmp("legalPeopleWindow");
	win.hide();
}

function closePeopleWin(){
	var win=L5.getCmp('legalPeopleWindow');
	win.hide();
}

//增加法定代表人
function add(){
	if(somLegalPeople == ""){
		somLegalPeopleDataSet.newRecord();
		var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
		somLegalPeopleResumeDataSet.removeAll();
		//加载法定代表人法律要件
		somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
		somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
		somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
		somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
		somLegalPeopleElectronicDataSet.setParameter("applyType","030");
		somLegalPeopleElectronicDataSet.load();
	}
	if(somLegalPeople != "" && method == "UPDATE"){
		//加载法定代表人法律要件
		legalDutyId = somLegalPeopleDataSet.get("dutyId");
		somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
		somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
		somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
		somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
		somLegalPeopleElectronicDataSet.setParameter("applyType","030");
		somLegalPeopleElectronicDataSet.load();
	}
	var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	if(somLegalPeopleResumeDataSet.getCount() == 0 ){
		somLegalPeopleResumeDataSet.setParameter("TASK_CODE",taskCode);
		somLegalPeopleResumeDataSet.load();
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
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
function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}

//法定代表人录入中输入身份证号进行查询
function checkPeopleInfo(){
	var idCard=_$("idCard");
	//身份证号
	if(checkIDCard($("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	// 根据证件号码索引人员
	var record=somLegalPeopleDataSet.getCurrent();
	if(idCard.length==18){
		record.set("sex",getSexByCode(_$("idCard")));
		record.set("birthday",getBirthByCode(_$("idCard")));
		showAge();
	}
}

function showAge(){
	var birthday=_$("birthday");
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
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
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ifLimit=record.get("ifLimit");
	var restrictPeopleId=record.get("restrictPeopleId");
	if(ifLimit=='1'){
		L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){
			return;
		});
	}else if(ifLimit=='0'){
		var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
		command.setParameter("PEOPLE_ID",restrictPeopleId);
		command.execute("getNum");
		var num = command.getReturn("num");
		if(num>0){
			L5.MessageBox.confirm('确定', '此人有'+num+'条受限记录，确定其担任负责人？',function(sta){
				if(sta=="yes"){
					editItemInfo();
					return;
				}else{
					return;
				}
			});
		}
	}else{
		editItemInfo();
	}
}
function editItemInfo(){
	var grid = L5.getCmp("gridPeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	var peopleId = record.get("peopleId");
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	somLegalPeopleDataSet.removeAll();
	var newRecord = somLegalPeopleDataSet.newRecord();

	newRecord.set("peopleId",record.get("peopleId"));
	newRecord.set("idCard",record.get("idCard"));
	$("age").innerHTML = getAgeByCode(record.get("idCard"));
	newRecord.set("name",record.get("name"));
	newRecord.set("aliasName",record.get("aliasName"));
	newRecord.set("sex",record.get("sex"));
	newRecord.set("folk",record.get("folk"));
	newRecord.set("ifFulltime",record.get("ifFulltime"));
	newRecord.set("personUnit",record.get("personUnit"));
	newRecord.set("personUnitPhone",record.get("personUnitPhone"));
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

	synPhoto(newRecord.get("photoId"),null);//同步照片

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