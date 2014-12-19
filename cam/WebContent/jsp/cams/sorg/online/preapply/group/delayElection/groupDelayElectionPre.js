function init(){
	L5.getCmp("tab").setActiveTab("0");
	
	//过滤意见枚举，去掉补齐补正
	opinionSelect.filterBy(function(record, id){
		if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
			return record;
		}
	});
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
}
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	somElectionDataSet.setParameter("TASK_CODE",taskCode);
	somElectionDataSet.load();
	
	sorgId = ds.get("sorgId");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		var sorgCode = somOrganDataSet.get("sorgCode");
		somOrganDataSetQuery.setParameter("SORG_CODE@=",sorgCode);
		somOrganDataSetQuery.setParameter("SORG_TYPE@=","S");
		somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
		somOrganDataSetQuery.load();
		somOrganDataSetQuery.on("load",function(){
			if(somOrganDataSetQuery.getCount() == 0){
				L5.Msg.alert("提示","根据录入的登记证号没有查到相应的社会组织,不能进行延期换届审批，请确认并修改登记证号！",function(){
					$("cnName").value = "";
					$("sorgCode").value = "";
					return false;
				});
			}else{
				sorgIdExist = somOrganDataSetQuery.get("sorgId");
				$("cnName").value = somOrganDataSetQuery.get("cnName");
				$("sorgCode").value = somOrganDataSetQuery.get("sorgCode");
				//从organ表里取业务主管单位
				if(typeof businessOrganSelectDic !="undefined"){
					var borgName = somOrganDataSetQuery.get('borgName');
					var records = businessOrganSelectDic.query("value",borgName);
					if(records.length>0){
						var borgCode = records.items[0].get("text");
						document.getElementById("borgName").value = borgName;
						document.getElementById("borgNameDispaly").value = borgCode;
					}
				}
			}
		});
	});
}
function checkSorgCode(){
	somOrganDataSetQuery.setParameter("SORG_CODE@=",_$("sorgCode"));
	somOrganDataSetQuery.setParameter("SORG_TYPE@=","S");
	somOrganDataSetQuery.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSetQuery.load();
}
function save(){
	if(_$('sorgCode') == '' ){
		L5.Msg.alert("提示","请填写登记证号！");
		return;
	}
	
	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionDelayApplyCmd");
	somElectionRecord.set("sorgId",sorgIdExist);
	somApplyRecord.set("sorgId",sorgIdExist);
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("create");
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			updateOnlineStatusAccept();
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
//提交流程
function submit(){
	if(_$('sorgCode') == '' ){
		L5.Msg.alert("提示","请填写登记证号！");
		return;
	}
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
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionDelayApplyCmd");
	somElectionRecord.set("sorgId",sorgIdExist);
	somApplyRecord.set("sorgId",sorgIdExist);
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("createAndSend");
	if(!command.error){
		L5.Msg.alert("提示","提交成功！",function(){
		updateOnlineStatusAccept();
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