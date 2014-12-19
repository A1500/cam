 /*---------------------------------------------------------\
|     检查输入域的值是否符合规定                           |
| author: 王先明 (mailto:wangxianming@langchao.com)		   |
|                                                          |
|  说明：                                                  | 
|    输入域的类型：                                        | 
|       idcode----15或18位的身份证                         |
|														   |
\---------------------------------------------------------*/

//校验身份证+扩展码
function checkIDCard(elementName, chinaName) {
	var flag=true;
	var obj=document.getElementsByName(elementName)[0];
	if(!checkIDCard2(elementName,chinaName)&&!checkMaxCode(elementName)) {
		flag=false;
	}
	if(!flag){
		alert("请输入正确的身份证号码，如果没有身份证，请点击自动生成编号。");
		obj.value="";
		
		
	}
	return flag;
}
//救助方案身份证验证
function checkIDCardJzfa(elementName, chinaName) {
	var flag=true;
	var obj=document.getElementsByName(elementName)[0];
	if(!checkIDCard2(elementName,chinaName)&&!checkMaxCode(elementName)) {
		flag=false;
	}
	if(!flag){
		alert("请输入正确的身份证号码！");
		obj.value="";
		
	}
	return flag;
}
//校验自动生成身份证格式
function checkMaxCode(elementName){
	var obj=document.getElementsByName(elementName)[0];
	if(obj.value.length!=18){
		return false;
	}else{
		//var organ=document.getElementsByName("organ")[0].value;
		if(obj.value.substring(0,13)!="B"+organArea){
			return false;
		}
	}
	return true;
}
/**********************************************************
			自定义String的方法
**********************************************************/

/*
 * function: 获得字符串的字节数
 * return:   字节数
 * example:  "test测试".getByte()值为8
**/
function getByte() {
	var intCount = 0;

	for(var i=0; i<this.length; i++) {
		// Ascii码大于255是双字节的字符
		if(this.charCodeAt(i) > 255) {
			intCount += 2;
		} else {
			intCount += 1;
		}
	}
	return intCount;
}
String.prototype.getByte = getByte;

/*
 * function: 检查字符串的每个字符是否为‘0’－‘9’
 * return:   true or false
 * example:  "123x".is0To9()值为false
**/
function is0To9(){
	//'0':48   '9':57
	var isNumber = true;
	var codeValue = 0;

	for(var i=0; i<this.length; i++) {
		codeValue = this.charCodeAt(i);
		if((codeValue < 48) || (codeValue > 57)){
			isNumber = false;
			return isNumber;
		}
	}
	return isNumber;
}
String.prototype.is0To9 = is0To9;



/**********************************************************
			公用的函数
**********************************************************/

/*
 * function: 检查输入域的值是否符合要求
 * param:    elementName----输入域的名字
 * param:    chinaName---输入域的中文名字
 * return:   是否
 * example:  checkIDCard('123123123123123','身份证')
**/
function checkIDCard2(elementName, chinaName){
	var eleObj = document.getElementsByName(elementName)[0];
	if (eleObj.value == "") {
		return false;
	}
	if (eleObj.value == "000000000000000000") {
		return true;
	}
	var eleValue = eleObj.value.toUpperCase();
	eleObj.value = eleValue;
	if (eleValue.length == 15) {
		if (!check15IDCode(eleValue)) {
			//window.alert("输入的身份证号码无效");
			//eleObj.focus();
			//eleObj.value="";
			return false;
		} else {
			eleObj.value = get18By15(eleValue);
		}
	} else {
		if (eleValue.length == 18) {
			if (!check18IDCode(eleValue)) {
				//window.alert("输入的身份证号码无效");
				//eleObj.focus();
				//eleObj.value="";
				return false;
			}
		} else {
			//window.alert("输入的身份证号码无效");
			//eleObj.focus();
			//eleObj.value="";
			return false;
		}
	}
	return true;	
}
/*
 * function: 检查身份证号码，不做15位到18位转换
 * param:    elementName----输入域的名字
 * param:    chinaName---输入域的中文名字
 * return:   是否
 * example:  checkIDCard('123123123123123','身份证')
**/
function checkIDCardNoChange(elementName, chinaName){
	//var eleObj = document.all.item(elementName);
   	var eleObj=document.getElementsByName(elementName)[0];
	if(eleObj.value==""){
		return false;
	}
	if(eleObj.value=="000000000000000000"){
		return true;
	}
	var eleValue=eleObj.value.toUpperCase();
	eleObj.value=eleValue;
	if(eleValue.length==15){
		if(!check15IDCode(eleValue)){
			window.alert("输入的身份证号码无效");
			eleObj.focus();
			eleObj.value="";
			return false;
		}
	}else if(eleValue.length==18){
		if(!check18IDCode(eleValue)){
			window.alert("输入的身份证号码无效");
			eleObj.focus();
			eleObj.value="";
			return false;
		}
	}else{
		window.alert("输入的身份证号码无效");
		eleObj.focus();
		eleObj.value="";
		return false;
	}
	return true;
	
}


/**********************************************************
			    私有函数
**********************************************************/

//IDCode
function checkIDCode(eleObj, eleValue, chinaName) {
	var msg = "输入域" + chinaName + "的值无效，请输入正确的值！"

	if (eleValue.length == 15) {
		if (!check15IDCode(eleValue)){
			window.alert(msg);
			eleObj.focus();
			return false;
		} else {
			eleObj.value = get18By15(eleValue);
		}
	} else if (eleValue.length == 18) {
		if (!check18IDCode(eleValue)){
			window.alert(msg);
			eleObj.focus();
			return false;
		}
	} else {
		window.alert(msg);
		eleObj.focus();
		return false;
	}

	return true;
}


/**********************************************************
			  可以重用的私有函数
**********************************************************/

//判断一个日期是否合法，输入格式为：YYYYMMDD
function isDate(str) {
	var year = str.substring(0, 4);
	var month = str.substring(4, 6);
	var day = str.substring(6, 8);

	if ((!year.is0To9()) || (!month.is0To9()) || (!day.is0To9())) {
		return false;
	}
	
	//year
	var yearInt = parseInt(year);
	if ((yearInt<1) || (yearInt>9999)) {
		return false;
	}
	//month
	var monthInt = parseInt(month,10);
	if ((monthInt<1) || (monthInt>12)) {
		return false;
	}
	//day
	var dayInt = parseInt(day,10);
	var monthMax;
	if ((((yearInt%4)==0) && ((yearInt%100)!=0)) || (yearInt%400==0)) {
		monthMax = new Array(31,29,31,30,31,30,31,31,30,31,30,31);
	} else {
		monthMax = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	}
	if ((dayInt<1) || (dayInt>monthMax[monthInt-1])){
		return false;
	}
	return true;
}

//计算出合法身份证（17位或者18位）最后一位的校验位
function getCheckBit(idCode){
	var code = idCode.substring(0, 17);
	var szVerCode="10X98765432";
	var iw = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2);
	var bitValue = 0;
	var temp = 0;

	for (var i=0; i<code.length; i++) {
		temp = code.charAt(i).valueOf();
		bitValue += temp * iw[i];
	}
	bitValue = bitValue % 11;

	return szVerCode.charAt(bitValue);
}

//判断是否为15位有效身份证
function check15IDCode(idCode) {
	if (idCode.length != 15) {
		return false;
	}

	if (!idCode.is0To9()) {
		return false;
	}

	var date = "19" + idCode.substring(6, 12);
	if (!isDate(date)) {
		return false;
	}

	return true;
}

//判断是否为18位有效身份证
function check18IDCode(idCode) {
	if (idCode.length != 18) {
		return false;
	}
	
	var new17Code = idCode.substring(0, 17);

	if (!new17Code.is0To9()) {
		return false;
	}

	var date = idCode.substring(6, 14);
	if (!isDate(date)) {
		return false;
	}
	
	idCode = idCode.toUpperCase();
	if (idCode.charAt(17) != getCheckBit(idCode)) {
		return false;
	}

	return true;
}

//由15位的合法身份证变成18位
function get18By15(idCode) {
	var new17Code = idCode.substring(0, 6) + "19" + idCode.substring(6, 15);

	return new17Code + getCheckBit(new17Code);
}

//由18位的合法身份证得到性别
function getSexByCode(idCode){
	var sex = idCode.charAt(16);

	if(sex.valueOf()%2 == 1){
		return "1";//男
	}else if(sex.valueOf()%2 == 0){
		return "2";//女
	}
	return "";
}

//由18位的合法身份证得到出生日期(YYYY-MM-DD)
function getBirthByCode(idCode){
	return idCode.substring(6,14); 
	//+ "-" +
	//	idCode.substring(10,12) + "-" +
	//	idCode.substring(12,14);
}
 //根据身份证回填出生日期、性别和出生地 licunbing @2010.6.1
function nonPeopleIdCard(){
	var idCardObj = document.getElementsByName("idCard")[0];
	// 校验身份证号码正确性
    if(!checkIDCard('idCard','')){
         return false;
    }
     if(idCardObj.length=18){
    	sex_.setSelect(getSexByCode(idCardObj.value));
    	document.getElementsByName("birthday")[0].value=getBirthByCode(idCardObj.value);
    	var birthPlace_TEXT = document.getElementsByName("birthPlace_TEXT")[0];
    	birthPlace_TEXT.value=(idCardObj.value).substring(0,2);
    	birthPlace_TEXT.fireEvent("onblur");
    }
    return true;
}
//青海需求，回填项的出生日期和身份校验
function checkBirthdayById(){
	var idCard = document.getElementsByName("idCard")[0].value;
    var birthday = document.getElementsByName("birthday")[0].value;
    var idBir=idCard.substring(6,14);
    if(idBir!=birthday){
       alert("出生日期与身份证上出生日期不符,请核对!");
    }
   return  false;
}
