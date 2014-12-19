	var sorgId='';//社团ID
	var cnName='';//社团名称
	var sorgCode='';//登记证号
	var applyType='027';//法律要件业务类型
	var fileCodeF="S064";
	var legalDutyId="";
	var forCheck= new Array();//检验变更事项用的数组
	var somLegalPeople='';//法定代表人用record
	var sorgOrganRecord='';//社会组织record
	var changeItemNUM='';
	var sorgDuties='';//社团职务
	var sorgKind='';
	var legalName="";
function init(){
	L5.getCmp("tab").setActiveTab("0");
	var somFlowAddDataset= L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.newRecord({"curOpinionId":"1"});
	var opinionSelect=L5.DatasetMgr.lookup("opinionSelect");
	var opinions=opinionSelect.getAllRecords();
	for(var i=0;i<opinions.length;i++){
		if(opinions[i].get('value') == '2' ){
			opinionSelect.remove(opinions[i]);
		}
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
			somLegalPeopleElectronicDataSet.setParameter("applyType","030");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});	
	}	
}
//根据登记证号加载社团信息
function loadSorg(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	sorgCode=document.getElementById('sorgCode').value;
	if(sorgCode=='')return;
	somOrganDataSet.setParameter("sorg_Code@=",sorgCode);
	somOrganDataSet.setParameter("sorg_TYPE@=","S");
	somOrganDataSet.setParameter("IF_BRANCH@=","1");
	somOrganDataSet.setParameter("sorg_status@=",'22');
	somOrganDataSet.load();
	somOrganDataSet.on('load',funAdd);
}
//somOrganDataset加载时触发事件
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
		var mainSorgId =sorgOrganRecord.get('mainSorgId');	
		document.getElementById('cnName').innerHTML=cnName;
		document.getElementById('charger').innerHTML=sorgOrganRecord.get('branchCharger');
		var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchChangeCmd");
		command.setParameter("sorgId", sorgId);
		command.execute("getLegalPeopleNameByTaskCode");
		document.getElementById('legalPeople').innerHTML=command.getReturn("legalPeopleName");
		sorgKind=sorgOrganRecord.get('sorgKind');
		var somOrganDataSet1 = L5.DatasetMgr.lookup("somOrganDataSet1");
		somOrganDataSet1.removeAll();
		somOrganDataSet1.setParameter("SORG_ID",mainSorgId);
		somOrganDataSet1.load();
		somOrganDataSet1.on('load',function(){
			if(somOrganDataSet1.getCount() > 0){
				var mainOrgan= somOrganDataSet1.getCurrent();
				cnNameM=mainOrgan.get('cnName');
				document.getElementById('cnNameM').innerHTML=cnNameM;
				sorgCodeM=mainOrgan.get('sorgCode');
				document.getElementById('sorgCodeM').innerHTML=sorgCodeM;
			}	
		});	
		somElectronicDataSet_load();//加载法律要件
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
//点击提交 保存流程并发送流程
function saveAndSend(){
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var newRecord=somFlowAddDataset.getCurrent();
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}	
	//somLegalPeople法定代表人用record
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchChangeCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && chargerDataSet.getCurrent()!=''){
			command.setParameter("somLegalPeople", chargerDataSet.getCurrent());
		}	
	}
	newRecord.set("taskCode",taskCode);
	newRecord.set("appDate",document.getElementById('appDate').value);
	command.setParameter("opinion", newRecord);
	command.setParameter("process", document.getElementById("process").value);
	
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","S");
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgDuties","S");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	command.execute("saveAndSendForChange");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			var url='jsp/cams/sorg/apply/group/branchChange/somGroupBranchChangeForShouliList.jsp';
			L5.forward(url,"待办任务页面");
		});	
		
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
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
	var newRecord=somFlowAddDataset.getCurrent();
	//somLegalPeople法定代表人用record
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchChangeCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && chargerDataSet.getCurrent()!=''){
			command.setParameter("somLegalPeople", chargerDataSet.getCurrent());
		}	
	}
	newRecord.set("taskCode",taskCode);
	newRecord.set("appDate",document.getElementById('appDate').value);
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","S");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","S");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	command.setParameter("process", document.getElementById("process").value);
	
	command.execute("saveForCreate");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			var url='jsp/cams/sorg/apply/group/branchChange/somGroupBranchChangeForShouliList.jsp';
			L5.forward(url,"待办任务页面");
		});	
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}	
}
function goBack(){
	history.go(-1);
}
//打印不予受理通知
function printNoAccept(){
	var cnName=$("cnNameM").innerHTML;
	if(cnName==""){
		L5.Msg.alert("提示","请先输入分支/代表机构登记证号！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));	
	window.open(url);
}
//打印受理通知
function printAccept(){
	var cnName=$("cnNameM").innerHTML;
	if(cnName==""){
		L5.Msg.alert("提示","请先输入分支/代表机构登记证号！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));	
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//点击按钮，填写法定代表人登记表
function addLegalPeople(){
	if(chargerDataSet.getCount()!=1){
		L5.Msg.alert("提示","请先备案负责人！");
		return;
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(chargerDataSet.get('idCard'));
	
	synPhotoDetail(chargerDataSet.get("photoId"),null);//同步照片
	
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",chargerDataSet.get('dutyId'));
	somResumeLegalDataSet.load();
	
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","030");
	somLegalPeopleElectronicDataSet.load();
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
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
		document.getElementById('sorgGroupKindBefore').value=sorgOrganRecord.get('sorgKind');
		document.getElementById('sorgBusScopeBefore').value=sorgOrganRecord.get('busScope');
	}else if(num=='1'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('houseSourceBefore').value=sorgOrganRecord.get("resideSource");
		document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
		document.getElementById('houseBorgBefore').innerHTML=sorgOrganRecord.get("housingOrgan");
		document.getElementById('houseAreaBefore').innerHTML=sorgOrganRecord.get("housingArea");
		document.getElementById('houseDateBefore').innerHTML=sorgOrganRecord.get("leasePeriod");
	}else if(num=='2'){			
		chargerDataSet.setParameter("SORG_ID",sorgId);
		chargerDataSet.setParameter("REG_STATUS","3");//审批中的，必须先备案才能进行负责人的变更
		chargerDataSet.load();
		chargerDataSet.on('load',function(){
			if(chargerDataSet.getCount() > 0){
				legalDutyId = chargerDataSet.get("dutyId");
				var win=L5.getCmp('AddChange'+num);
				win.show();
				document.getElementById('leaPeopleNameAfter').value=chargerDataSet.get('name');
				document.getElementById('leaPeopleNameBefore').innerHTML=sorgOrganRecord.get("branchCharger");
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
		document.getElementById('borgNameBefore').innerHTML=sorgOrganRecord.get("borgName");
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
	
	var nameBefore=document.getElementById('nameBefore').innerHTML;
	var sorgGroupKindBefore=document.getElementById('sorgGroupKindBefore').value;
	var sorgBusScopeBefore=document.getElementById('sorgBusScopeBefore').value;
	
	var nameAfter=document.getElementById('nameAfter').value;
	var sorgGroupKindAfter=document.getElementById('sorgGroupKindAfter').value;
	var sorgBusScopeAfter=document.getElementById('sorgBusScopeAfter').value;
	 
	if(!nameChangeCheck()){
		return;
	}
	//检查新的社团名称是否已经存在
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",document.getElementById('nameAfter').value);
	command.execute('cnNameUK');
	var num=command.getReturn('cnNameNum');
	if(num!=0){
		L5.Msg.alert("提示","名称已经存在!");return;
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
	record.set('legalDutyId',chargerDataSet.get('dutyId'));
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
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
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('leaPeopleNameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter1').innerHTML=record.get('changeAfter');
			document.getElementById('peoplechangeReason').value=record.get('changeReason');
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
	var win=L5.getCmp("peopleWin");
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