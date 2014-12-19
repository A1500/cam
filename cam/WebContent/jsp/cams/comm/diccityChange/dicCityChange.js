//校验序号用的变量
var checkNum = "";
var ciitcommand=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
ciitcommand.setParameter("id",organCode);
ciitcommand.execute("getNameById");
var cityName = ciitcommand.getReturn("cityName");
function init(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	if(method=="insert"){
		dicCityChangeDataSet.newRecord({"reqTime":reqTime,"organCode":organCode,"organName":organName,"batchId":batchId,"changeId":changeId});
		document.getElementById("dmjb1").style.display = 'none';
		document.getElementById("dmjb2").style.display = 'none';
		document.getElementById("dmjb7").style.display = 'none';
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
		var code= dicCityChangeDataSet.getAt(0).get("postChangeCode");
		//给序号变量赋值.
		checkNum = dicCityChangeDataSet.getAt(0).get("serialNum");
		if(code.substr(6)=="000000") {
			document.getElementById("dmjb2").style.display = 'none';
			document.getElementById("dmjb1").style.display = 'none';
			document.getElementById("dmjb7").style.display = '';
			document.getElementById("codeLeve3").value=dicCityChangeDataSet.getAt(0).get("codeLeve");
		}else if(code.substr(9) == "000"){
			document.getElementById("dmjb1").style.display = '';
			document.getElementById("dmjb2").style.display = 'none';
			document.getElementById("dmjb7").style.display = 'none';
			document.getElementById("codeLeve").value=dicCityChangeDataSet.getAt(0).get("codeLeve");
		}else{
			document.getElementById("dmjb2").style.display = '';
			document.getElementById("dmjb1").style.display = 'none';
			document.getElementById("dmjb7").style.display = 'none';
			document.getElementById("codeLeve2").value=dicCityChangeDataSet.getAt(0).get("codeLeve");
		}
		document.getElementById("img").style.display = 'none';
	}else if(method=="detail"){
		dicCityChangeDataSet.setParameter("CHANGE_ID@=",changeId);
		dicCityChangeDataSet.load(true);
	}
}
function save(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	var record=dicCityChangeDataSet.getCurrent();
	record.set("preChangeCode",document.getElementById("preChangeCode").value);
	record.set("preChangeName",document.getElementById("preChangeName").value);
	record.set("preUpsCode",document.getElementById("preUpsCode").value);
	record.set("preUpsName",document.getElementById("preUpsName").value);
	record.set("postChangeCode",document.getElementById("postChangeCode").value);
	record.set("postChangeName",document.getElementById("postChangeName").value);
	record.set("postUpsCode",document.getElementById("postUpsCode").value);
	record.set("postUpsName",document.getElementById("postUpsName").value);
	record.set("serialNum",document.getElementById("serialNum").value);
	var code = document.getElementById("codeLeve").value;
	if(code==""){
		code=document.getElementById("codeLeve2").value;
		if(code==""){
			code=document.getElementById("codeLeve3").value;
		}
	}
	record.set("codeLeve",code);
	var valid=dicCityChangeDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示",valid);
		return false;
	}
	//关于区划编写规则的校验
	var info = validate();
	if(info){
		alert(info);
		return;
	}
	var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
	command.setParameter("record",record);
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
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
/**
 * 选择属地行政区划窗口
*/
var radioMaxLevel="";
if(organCode.substr(4)!="00000000"){
	radioMaxLevel=0;
}else{
	radioMaxLevel=1;
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
		document.getElementById("xzxhjbquery").value = list[2];
		document.getElementById("preUpsCode").value = list[3];
		var upsName = list[4].substr(0,list[4].length-list[1].length);
		document.getElementById("preUpsName").value = upsName;
		if(document.getElementById("changeType").value=="022"){
			document.getElementById("postChangeCode").value = list[0];
			document.getElementById("postUpsCode").value = list[3];
			document.getElementById("postUpsName").value = upsName;
			changeSelect(list[0]);
		}
	}
}
/**
 * 选择属地行政区划窗口
*/
var radioMaxLevel2="";
if(organCode.substr(4)!="00000000"){
	radioMaxLevel2=-2;
}else{
	radioMaxLevel2=0;
}
function func_ForDomicileSelect1() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel="+radioMaxLevel2+"&level=3&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(cityName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("postUpsCode").value = list[0];
		document.getElementById("postUpsName").value = list[4];
		if(list[0].substr("4")=="00000000"){
			document.getElementById("postChangeCode").value = list[0].substr(0,4);
		}else if(list[0].substr("6")=="000000"){
			document.getElementById("postChangeCode").value = list[0].substr(0,6);
		}else if(list[0].substr("9")=="000"){
			document.getElementById("postChangeCode").value = list[0].substr(0,9);
		}else{
			document.getElementById("postChangeCode").value = list[0];
		}
	}
}

function returnBack(){
	history.go(-1);
}

function changeSelect(value){
	if(value.substr(6)=="000000") {
		document.getElementById("dmjb2").style.display = 'none';
		document.getElementById("dmjb1").style.display = 'none';
		document.getElementById("dmjb7").style.display = '';
	}else if(value.substr(9) == "000"){
		document.getElementById("dmjb1").style.display = '';
		document.getElementById("dmjb2").style.display = 'none';
		document.getElementById("dmjb7").style.display = 'none';
	}else{
		document.getElementById("dmjb2").style.display = '';
		document.getElementById("dmjb1").style.display = 'none';
		document.getElementById("dmjb7").style.display = 'none';
	}
}
/***************************区划代码树**********************************/

/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   id:organCode,
	
   name:cityName,
	
   leve:'-1',
	
   ups:'',
	
   flag:'',
	
   recordType : 'dicCityRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
 var level = "4" ;
function getParent(rec){
	var parentObjId = rec.get('id');
	var levelValue = rec.get("leve");
	if(levelValue < level) {
		return parentObjId?parentObjId:organCode;
	} else {
		return "000000000000";
	}
}
function getUserInfo(record){
	var rcdTp = record.recordType;
	if(rcdTp == "dicCityRecord"){
		var userId=record.get("id");
		var userName=record.get("name");
		if(userName!=null&&userName!='')
		return userId+"【"+userName+"】";
		else
			return userName;
	}
	return "";
}
function getDicCitydisabled(rec){
	return rec.get('id')=='';
}
/*var radioMaxlevel = 2 
function getChoiceBox(record){
   if(record.get("leve")*1<=radioMaxlevel*1)
      return '';
   else
      return  radioType;
}*/
//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var leve=rec.get('leve');
	var value=parseInt(leve);
	switch(value){
			case 1: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 2: // 二级节点
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 3: // 三级节点
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			default: // 四级节点
				file = figpath+"/l5/bsp_post.png";
    }
	return file;
}

/***************************校验**********************************/
function validate(){
	var code = document.getElementById("postChangeCode").value;
	var codeLeve = document.getElementById("codeLeve").value;
	if(codeLeve==""){
		codeLeve = document.getElementById("codeLeve2").value;
		if(codeLeve==""){
			codeLeve = document.getElementById("codeLeve3").value;
		}
	}
	if(code.length<12){
		return "区划代码应为12位";
	}
	
	if(codeLeve==""){
		return "代码类别不能为空";
	}
	
	//如果不是单独变更名称,校验区划代码是否重复
	var changeType = document.getElementById("changeType").value;
	if(changeType!="022"){
		//查询是否重复.
		var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
		command.setParameter("code",code);
		command.execute("query");
		var tips = command.getReturn("tips");
		if(tips){
			return tips;
		}
	}
	
	//变更类型
	
	var preChangeName = document.getElementById("preChangeName").value;
	var postChangeName = document.getElementById("postChangeName").value;
	var preChangeCode = document.getElementById("preChangeCode").value;
	var postChangeCode = document.getElementById("postChangeCode").value;
	if(changeType=="021"){
		if(preChangeCode==postChangeCode){
			return "变更代码,变更前后不能相同";
		}
	}
	if(changeType=="022"){
		if(preChangeName==postChangeName){
			return "变更名称,变更前后不能相同";
		}
		if(preChangeCode!=postChangeCode){
			return "变更名称,代码不能发生变化";
		}
	}
	
	if(changeType=="023"){
		if(preChangeCode==postChangeCode){
			return "变更代码,变更前后不能相同";
		}
		if(preChangeName==postChangeName){
			return "变更名称,变更前后不能相同";
		}
	}
	
	var upsCode = document.getElementById("postUpsCode").value;
	//校验前几位与上级单位代码一致
	if(upsCode.substr("4")=="00000000"){
		if(code.substr(0,4) != upsCode.substr(0,4)){
			return "区划代码前4位应与上级单位代码保持一致";
		}
	}else if(upsCode.substr("6")=="000000"){
		if(code.substr(0,6) != upsCode.substr(0,6)){
			return "区划代码前6位应与上级单位代码保持一致";
		}
	}else if(upsCode.substr("9")=="000"){
		if(code.substr(0,9) != upsCode.substr(0,9)){
			return "区划代码前9位应与上级单位代码保持一致";
		}
	}
	
	if(postChangeCode.substr(6,6)=="000000" && changeType!="022"){
		return "区县级的变更支持名称变更，不支持代码的变更！";
	}
	
	if(codeLeve=="01"){
		if(code.substr(6,1)!="0"){
			return "街道的行政区划代码第七位应为0";
		}
	}
	if(codeLeve=="02"){
		if(code.substr(6,1)!="1"){
			return "镇的行政区划代码第七位应为1";
		}
	}
	if(codeLeve=="03"){
		if(code.substr(6,1)!="2" && code.substr(6,1)!="3"){
			return "乡的行政区划代码第七位应为2或3";
		}
	}
	if(codeLeve=="04"){
		if(code.substr(6,1)!="4"){
			return "政企合一单位的行政区划代码第七位应为4";
		}
	}
	if(codeLeve=="05"){
		if(code.substr(6,1)!="6"){
			return "开发区的行政区划代码第七位应为6";
		}
	}
	if(codeLeve=="09"){
		if(code.substr(6,3)!="999"){
			return "区县本级的行政区划代码后三位应为999";
		}
	}
	if(codeLeve=="11"){
		if(code.substr(9,1)!="0" && code.substr(9,1)!="1"){
			return "社区的行政区划代码第十位应为0或1";
		}
	}
	if(codeLeve=="12"){
		if(code.substr(9,1)!="2" && code.substr(9,1)!="3"){
			return "村的行政区划代码第十位应为2或3";
		}
	}
	if(codeLeve=="13"){
		if(code.substr(9,1)!="4" && code.substr(9,1)!="5"){
			return "非法定的村的行政区划代码第十位应为4或5";
		}
	}
	if(codeLeve=="14"){
		if(code.substr(9,1)!="8"){
			return "本级所属单位的行政区划代码第十位应为8";
		}
	}
	if(codeLeve=="19"){
		if(code.substr(9)!="999"){
			return "乡镇本级的行政区划代码后三位应为999";
		}
	}
	if(codeLeve=="21"){
		if(code.substr(4,2)>20){
			return "市辖区的行政区划代码第三层应为01~20";
		}
	}
	if(codeLeve=="22"){
		if(code.substr(4,2)<20 || code.substr(4,2)>80){
			return "县的行政区划代码第三层应为21~80";
		}
	}
	//校验序号是否重复
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
	var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
	command.setParameter("code",code);
	command.setParameter("batchId",batchId);
	command.execute("isRepeatOneBatch");
	var warn = command.getReturn("warn");
	if(warn){
		return warn;
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
//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("dicCityExportDataSet");
	dataset.setParameter("ID@LIKE",areaCode+"%");
	dataset.load();
	L5.dataset2excel(dataset,"/jsp/cams/comm/diccityChange/dicCityExcel.jsp?userName="+organName);
}