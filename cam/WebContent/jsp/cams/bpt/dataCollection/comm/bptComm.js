var idCard;
var idCardValue;
var idCardValue1;
var stype;
/*
 * 由身份证自动生成出生日期
 */
function func_ShowBirthday() {
	var val = document.forms[0].idCard.value;
	var birthdayValue;
	if (15 == val.length) { // 15位身份证号码
		birthdayValue = val.charAt(6) + val.charAt(7);
		if (parseInt(birthdayValue) < 10) {
			birthdayValue = '20' + birthdayValue;
		} else {
			birthdayValue = '19' + birthdayValue;
		}
		birthdayValue = birthdayValue + '-' + val.charAt(8) + val.charAt(9)
				+ '-' + val.charAt(10) + val.charAt(11);
		BaseinfoPeopleDataSet.getCurrent().set("birthday", birthdayValue);
	}
	if (18 == val.length) { // 18位身份证号码
		birthdayValue = val.charAt(6) + val.charAt(7) + val.charAt(8)
				+ val.charAt(9) + '-' + val.charAt(10) + val.charAt(11) + '-'
				+ val.charAt(12) + val.charAt(13);
		BaseinfoPeopleDataSet.getCurrent().set("birthday", birthdayValue);
	}
}

// 验证身份证合法性
function func_QueryIdCard() {
	idCard = document.forms[0].idCard;
	stype = document.forms[0].stype.value;
	idCardValue = idCard.value;
	if (idCardValue == null || idCardValue == "") {
		return;
	}
	if (!checkIDCard(idCard)) {
		L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	idCardValue1 = document.getElementById("idCard").value;
	BaseinfoPeopleDataSet.setParameter("ID_CARD@=", idCardValue1);
	BaseinfoPeopleDataSet.load();
	BaseinfoPeopleDataSet.on('load', func_QueryCheck);
}
//判断是否是多重身份人员
function isDouID(BaseinfoPeopleDataSet,stype){
	if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1'&&stype!='01'){
		var s =  getBptState(BaseinfoPeopleDataSet.get("disabilityStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为伤残人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("dependantFlag")=='1'&&stype=='10'){
		var s = getBptState(BaseinfoPeopleDataSet.get("dependantStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为三属人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'&&!(stype=='13'||stype=='12')){
		var s = getBptState(BaseinfoPeopleDataSet.get("demobilizedStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为在乡复员或带病回乡人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("warFlag")=='1'&&stype!='14'){
		var s = getBptState(BaseinfoPeopleDataSet.get("warStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为参战或参试人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1'&&stype!='B1'){
		var s = getBptState(BaseinfoPeopleDataSet.get("martyrOffspringStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为部分烈士（错杀被平反人员）子女，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("retiredFlag")=='1'&&stype!='81'){
		var s = getBptState(BaseinfoPeopleDataSet.get("retiredStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为60岁以上农村籍退役军人，状态:"+s);
		return ;
	}
	
}
function func_QueryCheck(BaseinfoPeopleDataSet){
	if(BaseinfoPeopleDataSet.getCount()!=0){
	    if(stype=='01'){
	       if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1' /*&& BaseinfoPeopleDataSet.get("disabilityStateCode") != 6*/){
	           L5.Msg.alert("提示", "该人员已经是伤残人员!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='10'){
	         if(BaseinfoPeopleDataSet.get("dependantFlag")=='1'/*&& BaseinfoPeopleDataSet.get("dependantStateCode") != 6*/){
	           L5.Msg.alert("提示", "该人员已经是三属人员!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='13'||stype=='12'){
	       if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'/*&& BaseinfoPeopleDataSet.get("demobilizedStateCode") != 6*/){
	           L5.Msg.alert("提示", "该人员已经是在乡复员军人!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       
       	if(stype=='14'){
	      if(BaseinfoPeopleDataSet.get("warFlag")=='1' /*&& BaseinfoPeopleDataSet.get("warStateCode") != 6*/){
	           L5.Msg.alert("提示", "该人员已经是参战参试人员!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='B1'){
	      if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1' /*&& BaseinfoPeopleDataSet.get("martyrOffspringStateCode") != '6'*/){
	           L5.Msg.alert("提示", "该人员已经是部分烈士（错杀被平反人员）子女!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='81'){
  	      if(BaseinfoPeopleDataSet.get("retiredFlag")=='1' /*&& BaseinfoPeopleDataSet.get("retiredStateCode") != '6'*/){
  	           L5.Msg.alert("提示", "该人员已经是60岁以上农村籍退役军人!");
  	           document.forms[0].reset();
  	           return false;
  	       }
         	}
       	//alert("00000");
       	document.forms[0].flag.value="";	
        commShowPhoto(BaseinfoPeopleDataSet.get("photoTemp"));
        isDouID(BaseinfoPeopleDataSet,stype);
    }else{
          BaseinfoPeopleDataSet.newRecord();
          //BaseinfoPeopleDataSet.set("idCard",idCardValue);
          document.getElementById("idCard").value = idCardValue1;
          BaseinfoPeopleDataSet.set("idCard",idCardValue1);
          func_ShowBirthday();
          document.forms[0].flag.value="1";	
          commShowPhoto("../comm/default.jpg");
    }
	if(checkDoublePerson(idCardValue1)){
 		
        L5.Msg.alert("提示", "此人员已经存在黑名单内,详细信息请询问民政厅!");
        //document.forms[0].reset();
       // return false;
     }
}
/**
 * 人员照片显示
**/
function commShowPhoto(path) {
	if(path != null && path != "") {
		var obj = document.getElementsByTagName("img");
		for(var i=0;i<obj.length;i++) {
			if(obj[i].getAttribute("name") == "RELATIONER_PHOTOC_IMG") {
				obj[i].src=path;
			}
		}
	}	
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {

	var revalue = window.showModalDialog(
			"../../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("domicileCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("domicileName", list[4]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName", list[4]);
	}
}

/**
 * 选择住址行政区划窗口
 */
function func_ForApanageSelect() {
	var revalue = window.showModalDialog(
			"../../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.open("../../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+escape(encodeURIComponent(organName)));
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName", list[4]);
	}
}
function changes() {
	document.getElementById("address").value = document.getElementById("domicileAddress").value;
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}

function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}
//手动输入时间格式
function changeDateStyle(obj) {
	var temp = obj.value;
	if(temp!=""&&temp.length == 4) {
		obj.value = temp + '-';
	} else if (temp!=""&&temp.length==7) {
		obj.value = temp + '-';
	} 
}
function getBptState(state){
	switch (parseInt(state)){
		case 1:return "受理";
		break;
		case 2:return "享受待遇";
		break;
		case 3:return "身份认定不享受待遇";
		break;
		case 4:return "停发";
		break;
		case 5:return "迁移";
		break;
		case 6:return "不予认定";
		break;
		case 7:return "去世";
		break;
		case 8:return "取消";
		break;
		case 9:return "中止";
		break;
		default: return"";
	}
}
function writeAble(idCard,objectType,isApply) {
	var vcommand = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleValidateCommand");
	vcommand.setParameter("idCard",idCard);
	vcommand.setParameter("objectType",objectType);
	vcommand.setParameter("isApply",isApply);
	vcommand.execute("writeAble");
	var wflag = vcommand.getReturn("wflag");
	return wflag;
}
//判段此身份证号是否在黑名单
function checkDoublePerson(idCard){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
	command.setParameter("idCard", idCard);
	command.execute("checkDoublePerson");
	var flag = command.getReturn("flag");//0;没有重复 ,1:有重复
	if ("1"==flag) {
		return true;
	}else if("0"==flag){
		return false;
	}
}
