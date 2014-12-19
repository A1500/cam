//校验序号用的变量
var checkNum = "";
var ciitcommand=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
ciitcommand.setParameter("id",organCode);
ciitcommand.execute("getNameById");
var cityName = ciitcommand.getReturn("cityName");
function init(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	if(method=="insert"){
		dicCityChangeDataSet.newRecord({"reqTime":reqTime,"organCode":organCode,"organName":organName,"changeType":"03","changeId":changeId,"batchId":batchId});
		//获取序号
		var numcommand=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
		numcommand.setParameter("batchId",batchId);
		numcommand.execute("getNumber");
		var num = numcommand.getReturn("maxNum");
		if(num==0){
			num=parseInt(num)+1;
		}else{
			num=parseInt(num)+5;
		}
		document.getElementById("serialNum").value=num;
	}else if(method=="update"){
		dicCityChangeDataSet.setParameter("CHANGE_ID@=",changeId);
		dicCityChangeDataSet.load(true);
		//给序号变量赋值.
		checkNum = dicCityChangeDataSet.getAt(0).get("serialNum");
		
		var dicCityDetailDataSet=L5.DatasetMgr.lookup("dicCityDetailDataSet");
		dicCityDetailDataSet.setParameter("preChangeCode",document.getElementById("preChangeCode").value);
		if(document.getElementById("preChangeCode").value.substr(9)=="000"){
			dicCityDetailDataSet.setParameter("xzxhjbquery","3");
		}else{
			dicCityDetailDataSet.setParameter("xzxhjbquery","4");
		}
		dicCityDetailDataSet.setParameter("preChangeName",document.getElementById("preChangeName").value);
		dicCityDetailDataSet.setParameter("batchId",batchId);
		dicCityDetailDataSet.load();
		document.getElementById("img").style.display = 'none';
	}else if(method=="detail"){
		dicCityChangeDataSet.setParameter("CHANGE_ID@=",changeId);
		dicCityChangeDataSet.load();
		var dicCityDetailDataSet=L5.DatasetMgr.lookup("dicCityDetailDataSet");
		dicCityDetailDataSet.setParameter("changeId",changeId);
		dicCityDetailDataSet.load();
	}
}
function save(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	var valid=dicCityChangeDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示",valid);
		return false;
	}
	var info = validate();
	if(info){
		alert(info);
		return;
	}
	var record=dicCityChangeDataSet.getCurrent();
	record.set("preChangeCode",document.getElementById("preChangeCode").value);
	record.set("preChangeName",document.getElementById("preChangeName").value);
	record.set("preUpsCode",document.getElementById("preUpsCode").value);
	record.set("preUpsName",document.getElementById("preUpsName").value);
	record.set("serialNum",document.getElementById("serialNum").value);
	//从表信息
	var dicCityDetailDataSet=L5.DatasetMgr.lookup("dicCityDetailDataSet");
	var checkdetail = dicCityDetailDataSet.isValidate();
	if(checkdetail!=true){
		L5.Msg.alert("提示",checkdetail);
		return false;
	}
	var dicCityDetailRecords = dicCityDetailDataSet.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
	command.setParameter("record",record);
	command.setParameter("dicCityDetailRecords", dicCityDetailRecords);
	if(method=="insert"){
		//校验本批次是否已录该区划
		var commandifRepeat=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
		commandifRepeat.setParameter("batchId",batchId);
		commandifRepeat.setParameter("preChangeCode",document.getElementById("preChangeCode").value);
		commandifRepeat.execute("ifRepeated");//判断本批次是否已录该区划
		var ifRepeatTips = commandifRepeat.getReturn("ifRepeatTips");
		if(ifRepeatTips){
			L5.Msg.alert("提示",ifRepeatTips);
			return false;
		}
		for(var i=0;i<dicCityDetailRecords.length; i++) {
			dicCityDetailRecords[i].set("preChangeCode",dicCityDetailRecords[i].get("ID"));
			dicCityDetailRecords[i].set("preChangeName",dicCityDetailRecords[i].get("NAME"));
			if(dicCityDetailRecords[i].get("POST_CHANGE_CODE")==""||dicCityDetailRecords[i].get("POST_CHANGE_CODE")==null){
				L5.Msg.alert("提示","有数据没录入数据迁移流向！请检查后再保存！");
				return false;
			}
			dicCityDetailRecords[i].set("postChangeCode",dicCityDetailRecords[i].get("POST_CHANGE_CODE"));
			dicCityDetailRecords[i].set("postChangeName",dicCityDetailRecords[i].get("POST_CHANGE_NAME"));
			dicCityDetailRecords[i].set("postUpsCode",dicCityDetailRecords[i].get("POST_UPS_CODE"));
			dicCityDetailRecords[i].set("postUpsName",dicCityDetailRecords[i].get("POST_UPS_NAME"));
			dicCityDetailRecords[i].set("transType",dicCityDetailRecords[i].get("TRANS_TYPE"));
			dicCityDetailRecords[i].set("batchId",batchId);
		}
		command.execute("insertD");
	}else if(method=="update"){
		for(var i=0;i<dicCityDetailRecords.length; i++) {
			dicCityDetailRecords[i].set("transId",dicCityDetailRecords[i].get("TRANS_ID"));
			dicCityDetailRecords[i].set("changeId",dicCityDetailRecords[i].get("CHANGE_ID"));
			dicCityDetailRecords[i].set("preChangeCode",dicCityDetailRecords[i].get("ID"));
			dicCityDetailRecords[i].set("preChangeName",dicCityDetailRecords[i].get("NAME"));
			if(dicCityDetailRecords[i].get("POST_CHANGE_CODE")==""||dicCityDetailRecords[i].get("POST_CHANGE_CODE")==null){
				L5.Msg.alert("提示","有数据没录入数据迁移流向！请检查后再保存！");
				return false;
			}
			dicCityDetailRecords[i].set("postChangeCode",dicCityDetailRecords[i].get("POST_CHANGE_CODE"));
			dicCityDetailRecords[i].set("postChangeName",dicCityDetailRecords[i].get("POST_CHANGE_NAME"));
			dicCityDetailRecords[i].set("postUpsCode",dicCityDetailRecords[i].get("POST_UPS_CODE"));
			dicCityDetailRecords[i].set("postUpsName",dicCityDetailRecords[i].get("POST_UPS_NAME"));
			dicCityDetailRecords[i].set("transType",dicCityDetailRecords[i].get("TRANS_TYPE"));
			dicCityDetailRecords[i].set("batchId",batchId);
		}
		command.execute("updateD");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}

/***********************校验*****************************/
function validate(){
	var ds=L5.DatasetMgr.lookup("dicCityDetailDataSet");
	var records = ds.getAllRecords();
	if(records.length==0){
		return "请选择迁移后的单位";
	}
	for(var i=0;i<records.length;i++){
		if(records[i].get("ID")==records[i].get("POST_CHANGE_CODE")){
			return "迁移前的单位和迁移后单位不能相同";
		}
	}
	//校验序号是否重复(修改时如果不发生改变,不进行校验)
	if(checkNum!=document.getElementById("serialNum").value){
		var changeCmd=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
		changeCmd.setParameter("batchId",batchId);
		changeCmd.setParameter("serialNum",document.getElementById("serialNum").value);
		changeCmd.execute("isRepeat");
		var tips = changeCmd.getReturn("flag");
		if(tips){
			return tips;
		}
	}
}
//校验是否数字
function _isNum(s){
	if(s!=""){
		if(!/^[0-9]+$/.test(s)){
			alert("序号只能为数字!");
			document.getElementById("serialNum").value="";
			return;
		}
	}
}

/**
 * 选择属地行政区划窗口
*/
var radioMaxLevel="";
if(organCode.substr(4)!="00000000"){
	radioMaxLevel=0;
}else{
	radioMaxLevel=2;
}
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel="+radioMaxLevel+"&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(cityName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("preChangeCode").value = list[0];
		document.getElementById("preChangeName").value = list[1];
		if(list[0].substr(6,3)=="999"){
			document.getElementById("xzxhjbquery").value = "4";
		}else{
			document.getElementById("xzxhjbquery").value = list[2];
		}
		document.getElementById("preUpsCode").value = list[3];
		document.getElementById("preUpsName").value = list[4].substr(0,list[4].length-list[1].length);
		var dicCityDetailDataSet=L5.DatasetMgr.lookup("dicCityDetailDataSet");
		dicCityDetailDataSet.setParameter("preChangeCode",document.getElementById("preChangeCode").value);
		dicCityDetailDataSet.setParameter("xzxhjbquery",document.getElementById("xzxhjbquery").value);
		dicCityDetailDataSet.setParameter("preChangeName",document.getElementById("preChangeName").value);
		dicCityDetailDataSet.setParameter("batchId",batchId);
		dicCityDetailDataSet.load();
	}
}

function returnBack(){
	history.go(-1);
}

/**********************************从表维护*************************************/
function edit(){
	var grid=L5.getCmp("detailGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.getCmp("transWin").show();
	document.getElementById("postCode").readOnly=true;
	document.getElementById("postName").readOnly=true;
	document.getElementById("img2").style.display = '';
	document.getElementById("changeType").innerHTML= "区划撤销";
}
function closeWin(){
	L5.getCmp("transWin").hide();
}

function confirm(){
	if(document.getElementById("upsCode").value==""){
		alert("迁移后上级单位区划代码不能为空");
		return;
	}
	if(document.getElementById("upsName").value==""){
		alert("迁移后上级单位区划名称不能为空");
		return;
	}
	if(document.getElementById("postCode").value==""){
		alert("迁移后的区划代码不能为空");
		return;
	}
	if(document.getElementById("postName").value==""){
		alert("迁移后的区划名称不能为空");
		return;
	}
	if(document.getElementById("postCode").value.length!=12){
		alert("迁移后的区划代码长度应为12位");
		return;
	}
	//如果选择区划删除校验代码重复
	if(document.getElementById("changeType").value=="1"){
		var changeCmd=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
		changeCmd.setParameter("code",document.getElementById("postCode").value);
		changeCmd.execute("query");
		var tips = changeCmd.getReturn("tips");
		if(tips){
			return tips;
		}
	}
	
	var upsCode=document.getElementById("upsCode").value;
	var postCode=document.getElementById("postCode").value;
	if(upsCode.substr(0,9)!=postCode.substr(0,9)){
		alert("迁移后的区划代码前九位应与上级单位的前九位相同!");
		return;
	}
	var grid=L5.getCmp("detailGrid");
	var records=grid.getSelectionModel().getSelections();
	records[0].set("TRANS_TYPE","0");
	records[0].set("POST_UPS_CODE",upsCode);
	records[0].set("POST_UPS_NAME",document.getElementById("upsName").value);
	records[0].set("POST_CHANGE_CODE",postCode);
	records[0].set("POST_CHANGE_NAME",document.getElementById("postName").value);
	closeWin();
}
/**
 * 选择属地行政区划窗口
*/
var radioMaxLevel1="";
if(organCode.substr(4)!="00000000"){
	radioMaxLevel1=0;
}else{
	radioMaxLevel1=2;
}
var organCode1="";
function func_Select1() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel="+radioMaxLevel1+"&level=3&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(cityName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("upsCode").value = list[0];
		document.getElementById("upsName").value = list[1];
	}
}
function func_Select2() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=3&organCode="
					+ document.getElementById("upsCode").value + "&organName="
					+ escape(encodeURIComponent(document.getElementById("upsName").value)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("postCode").value = list[0];
		document.getElementById("postName").value = list[1];
	}
}