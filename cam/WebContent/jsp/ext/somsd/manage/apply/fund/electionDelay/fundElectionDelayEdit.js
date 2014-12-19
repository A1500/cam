function init(){
	L5.getCmp("tab").setActiveTab("0");

	if(method=="INSERT"){
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'22',
			"sorgType":"J","ifBranch":'0',"morgName":userId,"morgArea":morgArea});

		somApplyDataSet.newRecord({"curActivity":"受理","taskCode":taskCode,
			"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"J",
				"acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});

		somElectionDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode,"electionType":'1'});

		//电子档案
		somElectronicDataSet_load();
	}else{
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadElection);
	}

	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
}
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load',loadAspchief);

	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somApplyDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
}
//加载拟任负责人
function loadAspchief(ds){
	ds.set("cnName",userId);
	ds.set("sorgCode",sorgCode);
	ds.un("load",loadAspchief);
	somOrganDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgCode);
}
//获取登记证号
function getSorgCode(ds){
	ds.un("load",getSorgCode);
	if(ds.getCount() == 1){
		document.getElementById('sorgCode').value = ds.get('sorgCode');
		document.getElementById('cnName').value = ds.get('cnName');
	}
	somElectronicDataSet_load();
}
function save(){
	var validate=somApplyDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	var organRecord = somOrganDataSet.getCurrent();

	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");

	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.setParameter("organRecord",organRecord);
	command.execute("saveElectionDelay");
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
