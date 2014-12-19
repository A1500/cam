var  orgName ;
function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		}
	else if (method=="INSERT"){
		var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
		retiredSoldierDataset.newRecord();
		retiredSoldierDataset.set("retiredSoldierType",5);
		retiredSoldierDataset.set("sex", "1");
		retiredSoldierDataset.set("naton", "01");
		retiredSoldierDataset.set("disabilityFlag", "0");
		retiredSoldierDataset.set("flag", "1");
	}
	else if (method=="UPDATE"){
		var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
		retiredSoldierDataset.setParameter("SOLDIERSID",idField);
		retiredSoldierDataset.load();
		retiredSoldierDataset.on("load",function(){
			//初始化服役时间
			var servicedTime = retiredSoldierDataset.get("servicedTime");
			var year = parseInt(servicedTime/12);
			var month = parseInt(servicedTime%12);
			document.getElementById("servicedTimeTrs").disabled=true;
			retiredSoldierDataset.set("servicedTimeTrs",year+"年"+month+"个月");
		});
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+orgCode+"'");
	OrgNameDataset.load();
	OrgNameDataset.on("load",function() {
	orgName = OrgNameDataset.get("text");
});
}
function save() {
	var idCard = document.getElementById("idcardNo");
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	var birthday = document.getElementById("birthday").value;
	if(birthday!=""){
		if(!checkBirthday(birthday)){
		    L5.Msg.alert("提示", "出生日期格式或者内容不正确，出生日期不能大于当前时间!");
		    return false;
		}
	}
	//身份证号码
	var idCardValue = document.getElementById("idcardNo").value;
	if(idCardValue != "" && birthday != "") {
		var birthdayValue;
		if (15 == idCardValue.length) { // 15位身份证号码
			birthdayValue = idCardValue.substring(6,8);
			if (parseInt(birthdayValue) < 10) {
				birthdayValue = '20' + birthdayValue;
			} else {
				birthdayValue = '19' + birthdayValue;
			}
			
		}
		if (18 == idCardValue.length) { // 18位身份证号码
			birthdayValue = idCardValue.substring(6,14);
		}
		var bday = birthday.replace(/-/g,"");
		if(bday != birthdayValue) {
			 L5.Msg.alert("提示", "出生日期和身份证号出生日期不符!");
			 return false;
		}
	}
	var enlistTime = document.getElementById("enlistTime").value;
	if(enlistTime!=""){
		if(!checkBirthday(enlistTime)){
		    L5.Msg.alert("提示", "入伍时间格式或者内容不正确，入伍时间不能大于当前时间!");
		    return false;
		}
	}
	//入伍时间不能早于出生日期
	if(birthday != "" && enlistTime != "") {
		if(birthday > enlistTime) {
			L5.Msg.alert("提示", "入伍时间不能早于出生日期!");
		    return false;
		}
	}
	var retiredTime = document.getElementById("retiredTime").value;
	if(retiredTime!=""){
		if(!checkBirthday(retiredTime)){
		    L5.Msg.alert("提示", "退役时间格式或者内容不正确，退役时间不能大于当前时间!");
		    return false;
		}
	}
	//退役时间不能早于入伍时间
	if(retiredTime != "" && enlistTime != "") {
		if(retiredTime < enlistTime) {
			L5.Msg.alert("提示", "退役时间不能早于入伍时间!");
		    return false;
		}
	}
	var filesReceiveTime = document.getElementById("filesReceiveTime").value;
	if(filesReceiveTime!=""){
		if(!checkBirthday(filesReceiveTime)){
		    L5.Msg.alert("提示", "档案接收时间格式或者内容不正确!");
		    return false;
		}
	}
	var retiredTime = document.getElementById("retiredTime").value;
	if(retiredTime!=""){
		if(!checkBirthday(retiredTime)){
		    L5.Msg.alert("提示", "退役时间格式或者内容不正确!",function(){
		    	document.getElementById("retiredTime").focus();
		    });
		    return false;
		}
	}
	var filesReceiveTime = document.getElementById("filesReceiveTime").value;
	if(filesReceiveTime!=""){
		if(!checkBirthday(filesReceiveTime)){
		    L5.Msg.alert("提示", "档案接收日期格式或者内容不正确!",function(){
		    	document.getElementById("filesReceiveTime").focus();
		    });
		    return false;
		}
	}
	var arriveTime = document.getElementById("arriveTime").value;
	if(!checkBirthday(arriveTime)&&(arriveTime!="")){
	    L5.Msg.alert("提示", "报到时间格式或者内容不正确!");
	    return false;
	}
	var planYear = document.getElementById("planYear").value;
	if((planYear=="")||(!checkBirthday(planYear+"-01-01"))){
		    L5.Msg.alert("提示", "计划年度格式或者内容不正确!",function(){
		    	document.getElementById("planYear").value="";
		    	document.getElementById("planYear").focus();
		    });
		    return false;
	}
	//判断联系方式格式
	var tel = document.getElementById("tel").value;
	if(tel != "") {
		var tel_validate = validateTel(tel);
		if(!tel_validate) {
			L5.Msg.alert("提示", "请输入正确的联系方式!");
		    return false;
		}
	}
	//验证姓名
	var name = document.getElementById("name").value;
	if(name != "") {
		if(!validateName(name)) {
			L5.Msg.alert("提示", "请输入正确的姓名!");
		    return false;
		}
	}
	serveTime();
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var commandSoldier = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
	commandSoldier.setParameter("recordSoldier", recordSoldier);	
	if(method=="INSERT"){
		recordSoldier.set("soldiersId",soldierID);
    	var isValidate = retiredSoldierDataset.isValidate(true);
    	if(isValidate !== true){
    		L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
       	 	return false;
       	 }
       	 commandSoldier.execute("saveSoldier");
	}else if(method =="UPDATE"){
		var isValidate = retiredSoldierDataset.isValidate(true);
    	if(isValidate !== true){
    		L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
       		return false;
    	}
		commandSoldier.execute("updateSoldier");
	}
	if (!commandSoldier.error) {
		if(method=="INSERT"){
			L5.Msg.alert("提示","保存成功！",function(){
				var data = new L5.Map();
				data.put("method","UPDATE");
				data.put("idField",soldierID);
				data.put("type","1");
				var url='jsp/cams/prs/retiredcadres/retiredcadres_edit.jsp';
				var text = '修改复员士官信息';
				L5.forward(url,text,data);
			});
		}else{
			L5.Msg.alert("提示","保存成功！");
		}
	}else{
		L5.Msg.alert("错误",commandSoldier.error);
	}
}
function getServicedTime(){
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var timeStart = recordSoldier.get("enlistTime").split("-")[0];
	var timeEnd =recordSoldier.get("retiredTime"). split("-")[0];
	var servicedtime = timeEnd - timeStart+1;
	return servicedtime;
}

 function back()
 {	
 	history.go(-1);
 }
 
 function forHelp() {
	//	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+orgCode+"&organName="+orgName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	var organName="山东省";
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+orgCode+"&organName="+encodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[4];
		var retiredSoldierDataset = L5.DatasetMgr
				.lookup("retiredSoldierDataset");
		var recordSoldier = retiredSoldierDataset.getCurrent();
		if(list[0].substring(6)=="999000"){
			recordSoldier.set("wherePlacemen", list[0].substring(0,6)+"000000");
			recordSoldier.set("domicileName", list[4]);
		}else{
			recordSoldier.set("wherePlacemen", list[0]);
			recordSoldier.set("domicileName", list[4]);
		}
	}
 }

  function func_ForDomicileSelect() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		recordSoldier.set("enlistPlace",list[0]);
		recordSoldier.set("enlistPlaceName",list[4]);
	}
}
 function func_QueryIdCard() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var idCard = document.getElementById("idcardNo");
	var idCardValue = idCard.value;
	if (idCardValue == null || idCardValue == "") {
		return;
	}
	if (!checkIDCard(idCard)) {
		L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	var birthdayValue;
	if (15 == idCardValue.length) { // 15位身份证号码
		birthdayValue = idCardValue.charAt(6) + idCardValue.charAt(7);
		if (parseInt(birthdayValue) < 10) {
			birthdayValue = '20' + birthdayValue;
		} else {
			birthdayValue = '19' + birthdayValue;
		}
		birthdayValue = birthdayValue + '-' + idCardValue.charAt(8)
				+ idCardValue.charAt(9) + '-' + idCardValue.charAt(10)
				+ idCardValue.charAt(11);
		retiredSoldierDataset.getCurrent().set("birthday", birthdayValue);
	}
	if (18 == idCardValue.length) { // 18位身份证号码
		birthdayValue = idCardValue.charAt(6) + idCardValue.charAt(7)
				+ idCardValue.charAt(8) + idCardValue.charAt(9) + '-'
				+ idCardValue.charAt(10) + idCardValue.charAt(11) + '-'
				+ idCardValue.charAt(12) + idCardValue.charAt(13);
		retiredSoldierDataset.getCurrent().set("birthday", birthdayValue);
	}
 }
/**
 * 计算服役时间
 */
function serveTime(){
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var enlistTime = document.getElementById("enlistTime").value;
	var retiredTime = document.getElementById("retiredTime").value;
	if(retiredTime==""||enlistTime==""||!validateDateFormat(retiredTime)||!validateDateFormat(enlistTime)){
		retiredSoldierDataset.set("servicedTimeTrs",null);//清空服役年限
	}
	else{
		var a=enlistTime;
		var b=retiredTime;
		var datea=a.split("-");//将格式为yyyy-mm-dd的日期分开存于字符串
		var dateb=b.split("-");
		if(datea[1].substr(0,1)=="0"){//去掉月份中的0，例如09就转化为9
			datea[1]=datea[1].substr(1,1);
		}
		if(dateb[1].substr(0,1)=="0"){//去掉月份中的0，例如09就转化为9
			dateb[1]=dateb[1].substr(1,1);
		}
		var montha = parseInt(datea[0])*12+parseInt(datea[1]);//计算月数，用于下一步计算月数差
		var monthb = parseInt(dateb[0])*12+parseInt(dateb[1]);
		var monthAll = parseInt(monthb)-parseInt(montha);//计算月数差（年数*12转移到月数中）
		var year = parseInt(dateb[0])-parseInt(datea[0]);//计算年数差
		var month = 0;
		if(parseInt(datea[1])<=parseInt(dateb[1])){//计算月数差
			month =parseInt(dateb[1])-parseInt(datea[1]);
		}else{
			year = parseInt(year)-1;
			month = parseInt(dateb[1])+12-parseInt(datea[1]);
		}
		var servicedTime = monthAll;//传后台值
		var servicedTimeTrs = year+"年"+month+"个月";//传前台值
		document.getElementById("servicedTimeTrs").disabled = true;
		retiredSoldierDataset.set("servicedTime",servicedTime);//前台hidden
		retiredSoldierDataset.set("servicedTimeTrs",servicedTimeTrs);//填写计算好的服役时间
	}
}
/**
 * 时间格式yyyy-mm-dd验证
 * @param date
 * @returns {Boolean}
 */
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
/**
 * 判断联系电话
 */
function validateTel(tel) {
	var reg_1 = /^((((\d{3}[-]){0,1})|((\d{4}[-]){0,1})){0,1}\d{7,9})$/;
	var reg_2 = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9])\d{8}$/;
	if(reg_1.test(tel.trim()) || reg_2.test(tel.trim())) {
	    return true;
	} else {
		return false;
	}
}
/**
 * 姓名验证
 */
function validateName(name) {
	var reg = /^[\u4e00-\u9fa5]*$/;
	if(reg.test(name.trim())) {
		return true;
	} else {
		return false;
	}
}
/**
 * 名字去空格
 */
function nameNew(){
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var name = document.getElementById("name").value;
	name = name.replace(/\s/ig,'');//去掉空格符，制表符，换行符等一系列空白符
	retiredSoldierDataset.set("name",name);
	document.getElementById("name").value = name;
}
