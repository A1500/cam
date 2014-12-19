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
		somFlowAddDataset.newRecord({"taskCode":taskCode,"applyType":somApplyType,"dataSource":"MEND","sorgType":"J","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
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
//根据登记证号加载基金会信息
function loadSorg(){
	sorgCode=document.getElementById('sorgCode').value;
	if(sorgCode=='')return;
	somOrganDataSet.setParameter("sorg_Code",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.setParameter("sorg_status",'22');
	somOrganDataSet.load();
	somOrganDataSet.on('load',funAdd);

}
//somOrganDataset加载时触发事件
function funAdd(somOrganDataSet){
	var num=somOrganDataSet.getCount();
	if(num==0){
		L5.Msg.alert("提示","您输入的登记证号不存在！");
		document.getElementById('cnName').innerHTML='';
		document.getElementById('legalPeople').innerHTML='';
		sorgId='';
		return;
	}else{
		sorgOrganRecord= somOrganDataSet.getCurrent();
		sorgId=sorgOrganRecord.get('sorgId');
		cnName=sorgOrganRecord.get('cnName');
		document.getElementById('cnName').innerHTML=cnName;
		document.getElementById('legalPeople').innerHTML=sorgOrganRecord.get('legalPeople');
		sorgKind=sorgOrganRecord.get('sorgKind');
		somElectronicDataSet_load();//加载法律要件
	}
}
function loadUpdate(){
	somFlowAddDataset.setParameter("TASK_CODE",taskCode);
	somFlowAddDataset.load();
	somFlowAddDataset.on('load',function(){
		var sorgRecord= somFlowAddDataset.getCurrent();
		cnName=sorgRecord.get('sorgName');
		sorgKind=sorgRecord.get('sorgKind');
		sorgId=sorgRecord.get("sorgId");
		document.getElementById('cnName').innerHTML=cnName;
		document.getElementById('appDate').value=sorgRecord.get('appDate');
		document.getElementById("process").value=sorgRecord.get('process');
		var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
		var somChangeList = L5.DatasetMgr.lookup("somChangeList");
		somChangeList.setParameter("TASK_CODE",taskCode);
		somChangeList.load();
		somChangeList.on('load',forShow);
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
			sorgOrganRecord= somOrganDataSet.getCurrent();
			document.getElementById('sorgCode').value=somOrganDataSet.get('sorgCode');
			cnName=sorgOrganRecord.get('cnName');
			document.getElementById('legalPeople').innerHTML=sorgOrganRecord.get('legalPeople');
		});
		var legalPeopleDataSet=L5.DatasetMgr.lookup("legalPeopleDataSet");
		legalPeopleDataSet.setParameter("TASK_CODE",taskCode);
		legalPeopleDataSet.load();
		legalPeopleDataSet.on("load",function(ds){
			if(ds.getCount()==1){
				legalDutyId=ds.get("dutyId");
			}
		});
	});

}
function forShow(somChangeList){
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
			somLegalPeopleDataSet.setParameter("DUTY_ID",records[i].get('legalDutyId'));
			somLegalPeopleDataSet.load();//法定代表人
			somLegalPeopleDataSet.on('load',function(){
				if(somLegalPeopleDataSet.getCount()==1){
					somLegalPeople=somLegalPeopleDataSet.getCurrent();
				}
			});
		}else if(changeItem==3){
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			applyType=applyType+",230";
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
	if(somLegalPeople==''){
		L5.Msg.alert("提示","请先选择法定代表人！");
		return;
	}
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",somLegalPeopleDataSet.getCurrent().get('dutyId'));
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
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var newRecord=somFlowAddDataset.getCurrent();
	//somLegalPeople法定代表人用record
	var command = new L5.Command("com.inspur.cams.sorg.history.fund.cmd.SomFundHistoryCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeople!=''){
			command.setParameter("somLegalPeople", somLegalPeople);
		}
	}
	newRecord.set("sorgId",sorgId);
	newRecord.set("appDate",document.getElementById("appDate").value);
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("process", document.getElementById("process").value);
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
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
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
	var command = new L5.Command("com.inspur.cams.sorg.history.fund.cmd.SomFundHistoryCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeople!=''){
			command.setParameter("somLegalPeople", somLegalPeople);
		}
	}
	newRecord.set("sorgId",sorgId);
	newRecord.set("appDate",document.getElementById("appDate").value);
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("process", document.getElementById("process").value);
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
function goBack(){
	if(method=="UPDATE"){
		var data=new L5.Map();
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(document.getElementById('cnName').innerHTML)));
		data.put("searchSorgCode",_$("sorgCode"));
		url="jsp/cams/sorg/history/fund/mainChange/fundHistoryChangeList.jsp";
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
		somChangeDataset.removeAll();
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
			document.getElementById('moneyBefore').innerHTML=sorgOrganRecord.get("regMon");
			document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
		}else if(num=='5'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('borgNameBefore').value=sorgOrganRecord.get("purpose");
		}else if(num=='6'){
			var win=L5.getCmp('AddChange'+num);
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
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("1");
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
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("4");
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
	record.set('changeBefore',document.getElementById('leaPeopleNameBefore').innerHTML);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','2');
	record.set('legalDutyId',somLegalPeople.get('dutyId'));
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("2");
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
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("5");
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
	record.set('changeBefore',document.getElementById('fundTypeBefore').value);
	record.set('changeItem','6');
	record.set('changeAfter',changeAfter);
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	//判断该变更是否已经增加，已经有的话先删除再插入新的
	checkIfExist("6");
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
//修改变更
function forUpdate(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	somChangeDataset.newRecord();
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var record=records[0];
		var num=record.get('changeItem');
		changeItemNUM=num;
		if(num=='0'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('nameBefore').innerHTML=record.get('changeBefore');
			document.getElementById('nameAfter').value=record.get('changeAfter');
		}else if(num=='1'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('houseNameBefore').innerHTML=record.get('changeBefore');
			document.getElementById('houseNameAfter').value=record.get('changeAfter');
		}else if(num=='2'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('leaPeopleNameBefore').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter').value=record.get('changeAfter');
		}else if(num=='3'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
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
		}else if(num=='5'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			//document.getElementById('borgNameBefore1').value=record.get('changeBefore');
			//document.getElementById('borgNameAfter1').value=record.get('changeAfter');
		}else if(num=='6'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			document.getElementById('fundTypeBefore').value=record.get('changeBefore');
			document.getElementById('fundTypeAfter').value=record.get('changeAfter');
		}
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}


//点击输入法定代表人姓名，执行操作
function forLegalPeople(){
	somDutyDataSet.setParameter("SORG_ID",sorgId);
	somDutyDataSet.setParameter("IF_SERVE","1");
	somDutyDataSet.setParameter("REG_STATUS","1");
	somDutyDataSet.load();
	somDutyDataSet.on("load",function(){
		somDutyDataSet.filterBy(function(record, id){
			if("00001".indexOf(record.get('sorgDuties'))>-1){
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

//判断grid中是否已经有该变更
function checkIfExist(changeItem){
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	for(var i = 0;i < somChangeList.getCount();i++){
		if(changeItem==somChangeList.getAt(i).get("changeItem")){
			somChangeList.removeAt(i);
		}
	}
}