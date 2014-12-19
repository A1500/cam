	var sorgId='';//基金会ID
	var cnName='';//基金会名称
	var sorgCode='';//登记证号
	var applyType='231';//法律要件业务类型
	var fileCodeF="J055";
	var legalDutyId="";
	var forCheck= new Array();//检验变更事项用的数组
	var somLegalPeople='';//法定代表人用record
	var sorgOrganRecord='';//社会组织record
	var changeItemNUM='';
	var sorgDuties='';//基金会职务
	var sorgKind='';
	var legalName="";
	var chargeRecord='';//分支负责人record
function init(){
	//过滤意见枚举，去掉补齐补正
	var opinionSelect=L5.DatasetMgr.lookup("opinionSelect");
	var opinions=opinionSelect.getAllRecords();
	for(var i=0;i<opinions.length;i++){
		if(opinions[i].get('value') == '2' ){
			opinionSelect.remove(opinions[i]);
		}
	}
	L5.getCmp("tab").setActiveTab("0");
	var somFlowAddDataset= L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.newRecord({"curOpinionId":"1"});
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
			somLegalPeopleElectronicDataSet.setParameter("applyType","233");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});	
	}	
}
//根据登记证号加载基金会信息
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
		document.getElementById('cnName').innerHTML=cnName;
		document.getElementById('charger').innerHTML=sorgOrganRecord.get('branchCharger');
		var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchChangeCmd");
		command.setParameter("sorgId", sorgId);
		command.execute("getLegalPeopleNameByTaskCode");
		document.getElementById('legalPeople').innerHTML=command.getReturn("legalPeopleName");
		sorgKind=sorgOrganRecord.get('sorgKind');
		
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
			}	
		});	
		somElectronicDataSet_load();//加载法律要件
	}
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
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchChangeCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && chargeRecord!=''){
			command.setParameter("somLegalPeople", chargeRecord);
		}	
	}
	newRecord.set("taskCode",taskCode);
	newRecord.set("appDate",document.getElementById('appDate').value);
	command.setParameter("opinion", newRecord);
	command.setParameter("process", document.getElementById("process").value);
	
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","J");
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	command.execute("saveAndSendForChange");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			var url='jsp/cams/sorg/apply/fund/branchChange/somFundBranchChangeForShouliList.jsp';
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
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchChangeCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && chargeRecord!=''){
			command.setParameter("somLegalPeople", chargeRecord);
		}	
	}
	newRecord.set("taskCode",taskCode);
	newRecord.set("appDate",document.getElementById('appDate').value);
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","J");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("sorgDuties","J");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	command.setParameter("process", document.getElementById("process").value);
	
	command.execute("saveForCreate");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			var url='jsp/cams/sorg/apply/fund/branchChange/somFundBranchChangeForShouliList.jsp';
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
		chargerDataSet.setParameter("SORG_ID",sorgId);
		chargerDataSet.setParameter("REG_STATUS","3");//批准中的，必须先备案才能进行负责人的变更
		chargerDataSet.load();
		chargerDataSet.on('load',function(){
			if(chargerDataSet.getCount() > 0){
				legalDutyId = chargerDataSet.get("dutyId");
				chargeRecord = chargerDataSet.getCurrent();
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
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='1';
	closeChangeWin();
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
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='0';
	closeChangeWin();
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
		var num=record.get('changeItem');	
		changeItemNUM=num;
		if(num=='0'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('nameBefore1').innerHTML=record.get('changeBefore');	
			document.getElementById('nameAfter1').innerHTML=record.get('changeAfter');
			document.getElementById('namechangeReason').value=record.get('changeReason');
		}else if(num=='1'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('houseNameBefore1').innerHTML=record.get('changeBefore');	
			document.getElementById('houseNameAfter1').innerHTML=record.get('changeAfter');
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
			document.getElementById('borgNameBefore1').value=record.get('changeBefore');
			document.getElementById('borgNameAfter1').value=record.get('changeAfter');
			document.getElementById('borgchangeReason').value=record.get('changeReason');	
		}	
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
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}
//点击按钮，填写法定代表人登记表
function addLegalPeople(){
	if(chargeRecord==''){
		L5.Msg.alert("提示","请先选择负责人！");
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
	somLegalPeopleElectronicDataSet.setParameter("applyType","233");
	somLegalPeopleElectronicDataSet.load();
	
}