function init(){

	L5.getCmp("tab").setActiveTab("0");
	//过滤意见枚举，去掉补齐补正
	if(act == 'examin' || act == 'check' || act == 'audit' ){
	}else{
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
				return record;
			}
		});
	}
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadElection);

	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
	if(method == "yiban" || method == "end"){
		var tab=L5.getCmp("tab");
		var ipinionPanel=L5.getCmp("ipinionPanel");
		tab.remove(ipinionPanel);
	}
	if(act=='inform'){//是通知受理人
		var tab = L5.getCmp("tab");
		for(var i = tab.items.length-1;i>=0;i--){
			tab.setActiveTab(i);
		}
		document.getElementById("curOpinionId").disabled="disabled";
	}
}
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	if(method == "daiban"){
		ds.set('curOpinionId','1');
	}
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load',loadAspchief);

}
//加载拟任负责人
function loadAspchief(ds){
	ds.un("load",loadAspchief);
	sorgId = ds.get('sorgId');
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgCode);
}
//获取登记证号
function getSorgCode(ds){
	ds.un("load",getSorgCode);
//	if(ds.getCount() == 1){
//		document.getElementById('sorgCode').innerHTML = ds.get('sorgCode');
//		document.getElementById('cnName').innerHTML = ds.get('cnName');
//	}
	somAspchiefDataSet.setParameter("TASK_CODE",taskCode);
	somAspchiefDataSet.load();
	somAspchiefDataSet.on('load',loadsomFlowDataset);
}
function loadsomFlowDataset(ds){
	ds.un("load",loadsomFlowDataset);
	somFlowDataset.setParameter("TASK_CODE",taskCode);
	somFlowDataset.load();
	somFlowDataset.on('load',loadElectronic);
}
//加载电子档案
function loadElectronic(ds){
	ds.un("load",loadElectronic);
	//电子档案
	somElectronicDataSet_load();
}
// 增加拟任负责人
function addAspchief(){
	somAspchiefDataSet.newRecord();
}
// 删除拟任负责人
function delAspchief(){
	var record=somAspchiefDataSet.getCurrent();
	if(record!=null)
		somAspchiefDataSet.remove(record);
}
function save(){
	var validate=somAspchiefDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	if(document.getElementById('sorgCode') == '' ){
		L5.Msg.alert("提示","请填写登记证号！");
		return;
	}

	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionApplyCmd");
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somAspchiefRecord", somAspchiefDataSet.getAllRecords());
	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="INSERT"){
		command.execute("create");
	}else{
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.history.back(-1);
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
function printParty(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“登记证号！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	var somPartyMemberDataSet = L5.DatasetMgr.lookup("somPartyMemberDataSet");
	somPartyMemberDataSet.setParameter("SORG_ID",sorgId);
	somPartyMemberDataSet.setParameter("PEOPLE_TYPE",'1');
	somPartyMemberDataSet.load();
	somPartyMemberDataSet.on('load',function(ds){
		partyNum=ds.getCount();
		if(partyNum<3){
			L5.Msg.alert('提示','正式党员不足三人，不需建立党组织！');
			return;
		}
		var win = L5.getCmp("printPartyWin");
		win.show();
	});
}
var partyNum='';
function confirmPrint(){
	var linkmanName=encodeURIComponent(encodeURIComponent(_$('linkmanName')));
	var linkmanPhone=_$('linkmanPhone');
	if(linkmanName==''||linkmanPhone==''){
		L5.Msg.alert('提示','请先填写完整的联系人信息！');
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/partyBuildInformForPrint.jsp?cnName="+encodeURIComponent(encodeURIComponent(cnName))
	+'&linkmanName='+linkmanName+'&linkmanPhone='+linkmanPhone+'&taskCode='+taskCode+'&partyNum='+partyNum;
	window.open(url);
}
function closePrintWin(){
	var win = L5.getCmp("printPartyWin");
	win.setVisible(false);
}
//提交流程
function submit(){
	var validate=somAspchiefDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	if(document.getElementById('sorgCode') == '' ){
		L5.Msg.alert("提示","请填写登记证号！");
		return;
	}
	var validate=somApplyDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionApplyCmd");
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somAspchiefRecord", somAspchiefDataSet.getAllRecords());
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("send");
	if(!command.error){
		L5.Msg.alert("提示","提交成功！",function(){
		if(act == 'audit'){
			if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
				updateOnlineStatusPass(somApplyRecord.get("taskCode"));
			}
			if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
				updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
			}
		}
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
//输入登记证号，加载社会组织名称
function fillSorgInfo(){
	var sorgCode=document.getElementById('sorgCode').value;
	somOrganDataSet.removeAll();
	if(sorgCode == '' ){
		return ;
	}else{
		somOrganDataSet.setParameter("SORG_CODE",sorgCode);
		somOrganDataSet.setParameter("SORG_STATUS",'22');
		somOrganDataSet.setParameter("SORG_TYPE",'S');
		somOrganDataSet.load();
		somOrganDataSet.on('load',getSorgName);
	}
}
//获取社会组织名称
function getSorgName(ds){
	ds.un("load",getSorgName);
	var num=ds.getCount();
	if(num==0){
		L5.Msg.alert("提示","您输入的登记证号不存在，请重新输入！");
		sorgId='';
		document.getElementById('sorgCode').value='';
		document.getElementById('cnName').innerHTML='';
		somElectionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		return;
	}else{
		sorgId=ds.get('sorgId');
		somElectionDataSet.set('sorgId',ds.get('sorgId'));
		document.getElementById('cnName').innerHTML=ds.get('cnName');
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',ds.get('sorgId'));
	}
}