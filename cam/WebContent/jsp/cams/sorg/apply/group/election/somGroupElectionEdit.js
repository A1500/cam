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
	if(method=="INSERT"){
		somElectionDataSet.newRecord({"sorgId":sorgId,"taskCode":taskCode,"electionType":'0'});
		somApplyDataSet.newRecord({"sorgId":sorgId,"sorgType":"S","taskCode":taskCode,"ifFinish":'0',"curOpinionId":'1',"dataSource":'LOCAL'});
		//电子档案
		somElectronicDataSet_load();
	}else{
		somApplyDataSet.setParameter("TASK_CODE",taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load',loadElection);
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

	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}

	//显示职务列表
	L5.getCmp("gridPeople").on("rowclick",function(g,rowIndex,e){
		winDutyDataSet.removeAll();
		var sm = g.getSelectionModel();
		var record = sm.getSelected();
		winDutyDataSet.setParameter("PEOPLE_ID",record.get("peopleId"));
		//社团只查社团的人员
		winDutyDataSet.setParameter("SORG_TYPE",'S');
		winDutyDataSet.load();
	});
	//身份验证window关闭时把数据清空
	L5.getCmp("win_peopleValidate").on("beforehide",function(){
		winDutyDataSet.removeAll();
	});
	L5.getCmp("aspchiefGrid").on("cellclick",getColCode);
	L5.getCmp("aspchiefGrid").on("afteredit",func);

}
//当前编辑列
var editColumn;
//当前编辑列的代码值
var code;
function getColCode(grid, rowIndex, columnIndex,e){
	code="";
	editColumn=columnIndex;
	var aspchiefGrid=L5.getCmp("aspchiefGrid");
	var cell = aspchiefGrid.getSelections();
	if(cell[0].get("name")){
		code=cell[0].get("name");
	}
}
function func(e){
	var aspchiefGrid=L5.getCmp("aspchiefGrid");
	var cell = aspchiefGrid.getSelections();
	if(editColumn==3){
			var winPeopleDataSet=L5.DatasetMgr.lookup("winPeopleDataSet");
			winPeopleDataSet.setParameter("NAME",cell[0].get("name"));
			winPeopleDataSet.load();
			winPeopleDataSet.on('load', function(){
				if(winPeopleDataSet.getCount()>0){
					L5.getCmp("win_peopleValidate").show();
				}
			});
	}
}
//加载环节审批信息
function loadElection(ds){
	ds.un("load",loadElection);
	sorgId = somApplyDataSet.get('sorgId');

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
	ds.un("load",loadAspchief);
	$("chiefNum").innerHTML=ds.get("chiefNum");
	somOrganDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgCode);
}
//获取登记证号
function getSorgCode(ds){
	ds.un("load",getSorgCode);
//	if(ds.getCount() == 1){
//		document.getElementById('sorgCode').value = ds.get('sorgCode');
//		document.getElementById('cnName').value = ds.get('cnName');
//	}
	somAspchiefDataSet.setParameter("TASK_CODE",taskCode);
	somAspchiefDataSet.load();
	somAspchiefDataSet.on('load',loadElectronic);
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
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var validate=somAspchiefDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	if(document.getElementById('cnName').value == '' ){
		L5.Msg.alert("提示","请填写社团名称！");
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

	var somElectionRecord=somElectionDataSet.getCurrent();
	if(method=="INSERT"){
		//组装会议名称
		var meetingName = "第"+somElectionRecord.get("meetingName")+"次";
		if(_$("meetingNameSelect")==0){
			meetingName+="会员代表大会";
		}
		if(_$("meetingNameSelect")==1){
			meetingName+="会员大会";
		}
		somElectionRecord.set("meetingName",meetingName);
	}
	if(method=="UPDATE"){
		somElectionRecord.set("meetingName",somElectionRecord.get("meetingName"));
	}
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionApplyCmd");
	somElectionRecord.set("chiefNum",$("chiefNum").innerHTML);
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
	var cnName=_$("cnName");
	if(cnName==''){
		L5.Msg.alert('提示','请先填写社会团体名称！');
		return;
	}
	/*
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
	*/
	var win = L5.getCmp("printPartyWin");
	win.show();
}
var partyNum='';
function confirmPrint(){
	var cnName=_$("cnName");
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
	var validate=somElectionDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var validate=somAspchiefDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	if(document.getElementById('cnName').value == '' ){
		L5.Msg.alert("提示","请填写社团名称！");
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
	var validate=somApplyDataSet.isValidate(true);
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
	if(method=="INSERT"){
		//组装会议名称
		var meetingName = "第"+somElectionRecord.get("meetingName")+"次";
		if(_$("meetingNameSelect")==0){
			meetingName+="会员代表大会";
		}
		if(_$("meetingNameSelect")==1){
			meetingName+="会员大会";
		}
		somElectionRecord.set("meetingName",meetingName);
	}
	if(method=="UPDATE"){
		somElectionRecord.set("meetingName",somElectionRecord.get("meetingName"));
	}

	//将修改后的业务主管单位维护进organ
	somApplyRecord.set('borgName',document.getElementById("borgName").value);
	var command=new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupElectionApplyCmd");
	somElectionRecord.set("chiefNum",$("chiefNum").innerHTML);
	command.setParameter("somElectionRecord",somElectionRecord);
	command.setParameter("somAspchiefRecord", somAspchiefDataSet.getAllRecords());
	command.setParameter("somApplyRecord",somApplyRecord);
	if(method=="INSERT"){
		command.execute("createAndSend");
	}else{
		command.execute("send");
	}
	if(!command.error){
		L5.Msg.alert("提示","提交成功！",function(){
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
		//L5.Msg.alert("提示","您输入的登记证号或批准筹备文号不存在，请重新输入！");
//		sorgId='';
		//document.getElementById('cnName').value='';
//		somElectionDataSet.set('sorgId','');
//		somApplyDataSet.set('sorgName','');
//		somApplyDataSet.set('sorgId','');
//		somApplyDataSet.set('borgName','');
//		$("cnName").disabled = false;
		return;
	}else{
		sorgId=ds.get('sorgId');
		somElectionDataSet.set('sorgId',ds.get('sorgId'));
		somElectionDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',ds.get('sorgId'));

		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = ds.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgName").value = borgName;
				document.getElementById("borgNameDispaly").value = borgCode;
			}
		}

		somApplyDataSet.set('borgName',ds.get('borgName'));
		$("cnName").disabled = true;
	}
}
//输入社团名称，加载社会组织
function fillOrganInfo(name){
	if(name.trim() == ''){
		return;
	}
	somOrganDataSet.removeAll();
	somOrganDataSet.setParameter("CN_NAME",name);
	somOrganDataSet.setParameter("IF_BRANCH","0");
	somOrganDataSet.setParameter("SORG_STATUS@IN","12");
	somOrganDataSet.setParameter("SORG_TYPE","S");
	somOrganDataSet.load();
	somOrganDataSet.on('load',getSorgId);
}
//获取社会组织
function getSorgId(ds){
	ds.un("load",getSorgId);
	if(ds.getCount() == 0){
		L5.Msg.alert("提示","该社会团体尚未筹备登记，无法进行换届（成立）事先报批！");
		sorgId='';
		document.getElementById('cnName').value='';
		somElectionDataSet.set('sorgId','');
		somApplyDataSet.set('sorgName','');
		somApplyDataSet.set('sorgId','');
		//$("sorgCode").disabled = false;
		return;
	}else{
		sorgId=ds.get('sorgId');
		somElectionDataSet.set('sorgId',ds.get('sorgId'));
		somApplyDataSet.set('sorgName',ds.get('cnName'));
		somApplyDataSet.set('sorgId',ds.get('sorgId'));
		//$("sorgCode").disabled = false;
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

var queryPeopleIdCard = "";
function queryPeople(value) {
	if(queryPeopleIdCard == value){
		return value;
	}
	if(value.length==18){
		var winPeopleDataSet=L5.DatasetMgr.lookup("winPeopleDataSet");
		winPeopleDataSet.setParameter("ID_CARD",value.toUpperCase());
		winPeopleDataSet.load();
		winPeopleDataSet.on('load', function(){
			if(winPeopleDataSet.getCount()>0){
				L5.getCmp("win_peopleValidate").show();
			}
		});
		queryPeopleIdCard = value;
	}
	return value;
}

//关闭人员索引窗口
function closeItem(){
	L5.getCmp("win_peopleValidate").setVisible(false);
}

function getIfLimit(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + '是' + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + '否' + '</a>';
	}else{
		return "";
	}
}
function showRestrict(restrictPeopleId){
	var somRestrictPeopleDetailDataSet=L5.DatasetMgr.lookup("somRestrictPeopleDetailDataSet");
	somRestrictPeopleDetailDataSet.setParameter("PEOPLE_ID",restrictPeopleId);
	somRestrictPeopleDetailDataSet.load();
	var win = L5.getCmp("restrictWin");
	win.show();
}
function closeRestrictWin(){
	var win = L5.getCmp("restrictWin");
	win.hide();
}

function fillBackOtherInfo(){
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var otherDuty = "";
	for(var i =0;i<winDutyDataSet.getCount();i++){
		var name ="";
		sorgNameSelect.each(function(record, index){
		if(record.get('value') == winDutyDataSet.getAt(i).get("sorgId")){
				otherDuty +=record.get('text');
			}
		});
		sorgDutiesSelect.each(function(record, index){
		if(record.get('value') == winDutyDataSet.getAt(i).get("sorgDuties")){
				otherDuty +=record.get('text');
			}
		});
		ifServeSelect.each(function(record, index){
		if(record.get('value') == winDutyDataSet.getAt(i).get("ifServe")){
				otherDuty +=record.get('text');
			}
		});
		if(i!=winDutyDataSet.getCount()-1){
			otherDuty +=","
		}
	}
	var grid2=L5.getCmp("aspchiefGrid");
	var record2=grid2.getSelectionModel().getSelected();
	record2.set("otherDuties",otherDuty);
	closeItem();
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

function checkSessionIfExsist(obj){
		//根据会议名称查询是否已经做过换届
		var somMeetingQueryDataSet=L5.DatasetMgr.lookup("somMeetingQueryDataSet");
		somMeetingQueryDataSet.setParameter("SORG_ID@=",sorgId);
		var meetingName = "第"+obj.value+"次";
		if(_$("meetingNameSelect")==0){
			meetingName+="会员代表大会";
		}
		if(_$("meetingNameSelect")==1){
			meetingName+="会员大会";
		}
		somMeetingQueryDataSet.setParameter("MEETING_NAME@=",meetingName);
		somMeetingQueryDataSet.load();
		somMeetingQueryDataSet.on("load",function(){
			if(somMeetingQueryDataSet.getCount()>0){
				L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
				somElectionDataSet.getCurrent().set("meetingName","");
			}
		});
}

function checkSessionIfExsistUpdate(obj){
		//根据会议名称查询是否已经做过换届
		var somMeetingQueryDataSet=L5.DatasetMgr.lookup("somMeetingQueryDataSet");
		somMeetingQueryDataSet.setParameter("SORG_ID@=",sorgId);
		var meetingName = obj.value;
		somMeetingQueryDataSet.setParameter("MEETING_NAME@=",meetingName);
		somMeetingQueryDataSet.load();
		somMeetingQueryDataSet.on("load",function(){
			if(somMeetingQueryDataSet.getCount()>0){
				L5.Msg.alert("提示","根据会议名称查询该社会组织已经办理过该届次的换届备案，请检查！");
				somElectionDataSet.getCurrent().set("meetingName","");
			}
		});
}


