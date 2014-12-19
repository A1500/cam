var checkNum="";
var ciitcommand=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
ciitcommand.setParameter("id",organCode);
ciitcommand.execute("getNameById");
var cityName = ciitcommand.getReturn("cityName");
function init(){
	var dicCityInsertDataSet=L5.DatasetMgr.lookup("dicCityInsertDataSet");
	if(method=="insert"){
		dicCityInsertDataSet.newRecord({"reqTime":reqTime,"organCode":organCode,"organName":organName,"changeType":"01","changeId":changeId,"batchId":batchId});
		document.getElementById("dmjb1").style.display = '';
		document.getElementById("dmjb2").style.display = 'none';
		document.getElementById("dmjb3").style.display = 'none';
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
		document.getElementById("dmjb1").style.display = 'none';
		document.getElementById("dmjb2").style.display = 'none';
		document.getElementById("dmjb3").style.display = 'none';
		dicCityInsertDataSet.setParameter("CHANGE_ID@=",changeId);
		dicCityInsertDataSet.load(true);
		checkNum = dicCityInsertDataSet.getAt(0).get("serialNum");
		var preUpsCode = dicCityInsertDataSet.getAt(0).get("preUpsCode");
		if(preUpsCode.substr("4")=="00000000"){
			document.getElementById("dmjb3").style.display = '';
		}else if(preUpsCode.substr("6")=="000000"){
			document.getElementById("dmjb2").style.display = '';
		}else{
			document.getElementById("dmjb1").style.display = '';
		}
	}else if(method=="detail"){
		dicCityInsertDataSet.setParameter("CHANGE_ID@=",changeId);
		dicCityInsertDataSet.load();
	}
}
function save(){
	var dicCityInsertDataSet=L5.DatasetMgr.lookup("dicCityInsertDataSet");
	var valid=dicCityInsertDataSet.isValidate(true);
	//关于区划编写规则的校验
	var info = validate();
	if(info){
		alert(info);
		return;
	}
	var record=dicCityInsertDataSet.getCurrent();
	record.set("preChangeCode",document.getElementById("preChangeCode").value);
	record.set("preChangeName",document.getElementById("preChangeName").value);
	record.set("preUpsCode",document.getElementById("preUpsCode").value);
	record.set("preUpsName",document.getElementById("preUpsName").value);
	record.set("serialNum",document.getElementById("serialNum").value);
	if(valid!=true){
		L5.Msg.alert("提示",valid);
		return false;
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

function returnBack(){
	history.go(-1);
}

/**
 * 选择属地行政区划窗口
*/

function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&level=3&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(cityName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("preUpsCode").value = list[0];
		document.getElementById("preUpsName").value = list[1];
		var ds=L5.DatasetMgr.lookup("dicCityInsertDataSet");
		if(list[0].substr(4)=="00000000"){
			document.getElementById("dmjb1").style.display = 'none';
			document.getElementById("dmjb2").style.display = 'none';
			document.getElementById("dmjb3").style.display = '';
			document.getElementById("preChangeCode").value = list[0].substr(0,4);
			ds.getCurrent().set("codeLeve",document.getElementById("codeLeve3"));
		}else if(list[0].substr(6)=="000000"){
			document.getElementById("dmjb1").style.display = 'none';
			document.getElementById("dmjb2").style.display = '';
			document.getElementById("dmjb3").style.display = 'none';
			document.getElementById("preChangeCode").value = list[0].substr(0,6);
			ds.getCurrent().set("codeLeve",document.getElementById("codeLeve2"));
		}else if(list[0].substr(9)=="000"){
			document.getElementById("dmjb1").style.display = '';
			document.getElementById("dmjb2").style.display = 'none';
			document.getElementById("dmjb3").style.display = 'none';
			document.getElementById("preChangeCode").value = list[0].substr(0,9);
			ds.getCurrent().set("codeLeve",document.getElementById("codeLeve1"));
		}else{
			document.getElementById("dmjb1").style.display = '';
			document.getElementById("dmjb2").style.display = 'none';
			document.getElementById("dmjb3").style.display = 'none';
			document.getElementById("preChangeCode").value = list[0];
			ds.getCurrent().set("codeLeve",document.getElementById("codeLeve1"));
		}
		
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
/*var radioMaxlevel = 2;
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
	var codeLeve = document.getElementById("codeLeve1").value;
	if(codeLeve==""){
		codeLeve = document.getElementById("codeLeve2").value;
		if(codeLeve==""){
			codeLeve = document.getElementById("codeLeve3").value;
		}
	}
	var	code = document.getElementById("preChangeCode").value;
	var	upsCode = document.getElementById("preUpsCode").value;
	//查询是否重复.
	var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
	command.setParameter("code",code);
	command.execute("query");
	var tips = command.getReturn("tips");
	if(tips){
		return tips;
	}
	
	if(code.length<12){
		return "区划代码应为12位";
	}
	if(document.getElementById("preUpsCode").value==""){
		return "上级区划代码不能为空";
	}
	if(document.getElementById("preUpsName").value==""){
		return "上级区划名称不能为空";
	}
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
	if(organCode.substr(4)!="00000000" && codeLeve.substr(0,1)=="2"){
		return "区县级单位不能新增该类别的区划代码";
	}
	if(codeLeve=="21"){
		if(code.substr(4,2)>20){
			return "市辖区的行政区划代码第三层应为01~20";
		}
	}
	if(codeLeve=="22"){
		if(code.substr(4,2)<21 || code.substr(4,2)>80){
			return "县的行政区划代码第三层应为21~80";
		}
	}
	if(codeLeve=="23"){
		if(code.substr(4,2)<81 || code.substr(4,2)>90){
			return "县级市的行政区划代码第三层应为81~89";
		}
	}
	if(codeLeve=="24"){
		if(code.substr(4,2)<91 || code.substr(4,2)>99){
			return "县级市的行政区划代码第三层应为90~99";
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

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("dicCityExportDataSet");
	dataset.setParameter("ID@LIKE",areaCode+"%");
	dataset.load();
	L5.dataset2excel(dataset,"/jsp/cams/comm/diccityChange/dicCityExcel.jsp?userName="+organName);
}
