var meetingNameGlobal='';
function init(){
	if(method=="INSERT"){
		var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
		somElectionDataSet.newRecord({"sorgName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"taskCode":taskCode,"electionType":'0'});
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.newRecord({"taskCode":taskCode,"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"S","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgStatus":"00","sorgId":sorgId,"sorgType":"S","ifBranch":"0","morgName":userId,"morgArea":morgArea});
	}else{
		var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
		somElectionDataSet.setParameter("TASK_CODE@=",taskCode);
		somElectionDataSet.load();
		somElectionDataSet.on('load', function(ds){
			ds.set("cnName",userId);
			ds.set("sorgCode",sorgCode);
			var record=somElectionDataSet.getCurrent();
			if(meetingNameGlobal!=''){
				record.set("meetingName",meetingNameGlobal);
			}
			somAspchiefDataSet.setParameter("TASK_CODE",taskCode);
			somAspchiefDataSet.load();
			var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
			somApplyDataSet.setParameter("TASK_CODE",taskCode);
			somApplyDataSet.load();
			somApplyDataSet.on("load",function(){
				somOrganDataSet.setParameter("SORG_ID@=",somApplyDataSet.get("sorgId"));
				somOrganDataSet.load();
				somOrganDataSet.on("load",function(){
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
			});
		});
	}
	if(sorgCode == ""){
		document.getElementById('choubeiTd').style.display='block';
	}else{
		document.getElementById('sorgCodeTd').style.display='block';
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

	sexDataSet.on("load",function addBlank(){
		sexDataSet.un("load",addBlank);
		var record = sexDataSet.newRecord({"text":"请选择","value":""});
		var recordCopy = record.copy();
		sexDataSet.insert(0,recordCopy);
		sexDataSet.removeAt(sexDataSet.indexOf(record));
	});
	politicsSelect.on("load",function addBlank(){
		politicsSelect.un("load",addBlank);
		var record = politicsSelect.newRecord({"text":"请选择","value":""});
		var recordCopy = record.copy();
		politicsSelect.insert(0,recordCopy);
		politicsSelect.removeAt(politicsSelect.indexOf(record));
	});
	sorgDutiesDataSet.on("load",function addBlank(){
		sorgDutiesDataSet.un("load",addBlank);
		var record = sorgDutiesDataSet.newRecord({"text":"请选择","value":""});
		var recordCopy = record.copy();
		sorgDutiesDataSet.insert(0,recordCopy);
		sorgDutiesDataSet.removeAt(sorgDutiesDataSet.indexOf(record));
	});
}

// 增加拟任负责人
function addAspchief(){
	somAspchiefDataSet.newRecord();
	$("chiefNum").innerHTML=somAspchiefDataSet.getCount();
}
// 删除拟任负责人
function delAspchief(){
	var record=somAspchiefDataSet.getCurrent();
	if(record!=null)
		somAspchiefDataSet.remove(record);
		$("chiefNum").innerHTML=somAspchiefDataSet.getCount();
}
function save(){
	var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}

	var somAspchiefDataSetvalidate=somAspchiefDataSet.isValidate(true);
	if(somAspchiefDataSetvalidate!=true){
		L5.Msg.alert("提示","校验未通过，"+somAspchiefDataSetvalidate);
		return;
	}
	var somAspchiefRecords=somAspchiefDataSet.getAllRecords();
	for(var i=0;i<somAspchiefRecords.length;i++){
		var idCard=somAspchiefRecords[i].get("idCard");
		if(idCard!="" && validIDCard(idCard)!=true){
			L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
			return;
		}
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somElectionRecord=somElectionDataSet.getCurrent();
	var somApplyRecord=somApplyDataSet.getCurrent();
	var somOrganRecord=somOrganDataSet.getCurrent();
	somOrganRecord.set("borgName",_$("borgName"));

	//组装会议名称
	if(method=="INSERT"){
		var meetingName = "第"+somElectionRecord.get("meetingName")+"次";
		meetingNameGlobal=_$("meetingName");
		if(_$("meetingNameSelect")==0){
			meetingName+="会员代表大会";
		}
		if(_$("meetingNameSelect")==1){
			meetingName+="会员大会";
		}
		somElectionRecord.set("meetingName",meetingName);
	}
	if(method=="UPDATE"&&meetingNameGlobal!=''){
		var meetingName = "第"+somElectionRecord.get("meetingName")+"次";
		meetingNameGlobal=_$("meetingName");
		if(_$("meetingNameSelect")==0){
			meetingName+="会员代表大会";
		}
		if(_$("meetingNameSelect")==1){
			meetingName+="会员大会";
		}
		somElectionRecord.set("meetingName",meetingName);
	}
	//将修改后的业务主管单位维护进organ
	var command=new L5.Command("com.inspur.cams.sorg.online.apply.election.cmd.SomElectionOnlineCmd");
	command.setParameter("somOrganRecord",somOrganRecord);
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somAspchiefRecord", somAspchiefDataSet.getAllRecords());
	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="INSERT"){
		command.execute("insert");
	}else if(method=="UPDATE"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			method="UPDATE";
			init();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	window.history.go(-1);
}

//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“社会团体中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
function printParty(){
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

function ifNumber(obj){
	var reg = new RegExp("^[0-9]*$");
	if(!reg.test(obj.value)){
        	L5.Msg.alert('提示',"请输入数字！");
        	obj.value="";
        	obj.focus();
        	return;
 		}
}
//校验身份证号
function validIDCard(o){
	if(o=="") return true;
	if(o=="000000000000000000") return true;
	var val=o.toUpperCase();
	if(val.length==15){
		if(!is15IDCard(val)){
			return false;
		}
	}else if(val.length==18){
		if(!is18IDCard(val)){
			return false;
		}
	}else{
		return false;
	}
	return true;
}