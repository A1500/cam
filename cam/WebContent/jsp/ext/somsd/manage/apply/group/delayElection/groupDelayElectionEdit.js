function init(){
	if(method=="INSERT"){
		somElectionDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode,"electionType":'1'});
		somApplyDataSet.newRecord({"sorgName":userId,"curActivity":"受理","taskCode":taskCode,"sorgId":sorgId,"applyType":somApplyType,"dataSource":"ONLINE","sorgType":"S","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgStatus":"00","sorgId":sorgId,"sorgType":"S","ifBranch":"0","morgName":userId,"morgArea":morgArea});
		//电子档案
		somElectronicDataSet_load();
	}else{
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadElection);
	}
	//电子档案
	somElectronicDataSet_load();
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
	var borgName = somApplyDataSet.get('borgName');
	var records = businessOrganSelectDic.query("value",borgName);
	if(records.length>0){
		var borgCode = records.items[0].get("text");
		document.getElementById("borgName").value = borgName;
		document.getElementById("borgNameDispaly").value = borgCode;
	}
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load',loadAspchief);

	var sorgId = somApplyDataSet.get("sorgId");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		$("cnName").value = somOrganDataSet.get("cnName");
		$("sorgCode").value = somOrganDataSet.get("sorgCode");
		//从organ表里取业务主管单位
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = somOrganDataSet.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}
	});
}
//加载拟任负责人
function loadAspchief(ds){
	ds.set("cnName",userId);
	ds.set("sorgCode",sorgCode);
	ds.un("load",loadAspchief);
	somOrganDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	somOrganDataSet.load();
}
function save(){
	if(document.getElementById('sorgCode') == '' ){
		L5.Msg.alert("提示","请填写登记证号！");
		return;
	}

	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(_$("cnName")==""){
		L5.Msg.alert("提示","请输入社团名称！");
		return false;
	}
	if(_$("sorgCode")==""){
		L5.Msg.alert("提示","请输入登记证号！");
		return false;
	}
	//将修改后的业务主管单位维护进organ
	var somOrganRecord=somOrganDataSet.getCurrent();
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);

	var command=new L5.Command("com.inspur.cams.sorg.online.apply.delayElection.cmd.SomElectionDelayOnlineCmd");
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.setParameter("somOrganRecord",somOrganRecord);
	if(method=="INSERT"){
		command.execute("insert");
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
