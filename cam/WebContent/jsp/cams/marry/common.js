//获取id为参数id的元素的值
function $(id)
{
	return document.getElementById(id);
}

//验证日期
function validateDate(item,cue) {
	if(item.value) {
		var strDate = item.value;
		var result1 = strDate.match(/((^((1[8-9]\d{2})|([2-9]\d{3}))(-)(10|12|0?[13578])(-)(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(11|0?[469])(-)(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(0?2)(-)(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)(-)(0?2)(-)(29)$)|(^([3579][26]00)(-)(0?2)(-)(29)$)|(^([1][89][0][48])(-)(0?2)(-)(29)$)|(^([2-9][0-9][0][48])(-)(0?2)(-)(29)$)|(^([1][89][2468][048])(-)(0?2)(-)(29)$)|(^([2-9][0-9][2468][048])(-)(0?2)(-)(29)$)|(^([1][89][13579][26])(-)(0?2)(-)(29)$)|(^([2-9][0-9][13579][26])(-)(0?2)(-)(29)$))/);
		if(result1==null){
			if(cue)
				alert(cue);
			else
				alert("请输入正确的日期格式！");
			item.focus();
			return false;
		}
	}
	return true;
}

//弹出日期选择
function getTimes(item) {
	LoushangDate(document.getElementById(item));
}

//手动输入时间格式 
var temp1 = -1;
function changeDateStyle(obj) {
	var temp = obj.value;
	var arr = temp.split("-");
	if (temp1<obj.value.length) {
		if(temp!=""&&temp.length == 4) {
			obj.value = temp + '-';
		} else if (obj.value.length == 8 && obj.value.split("-").length == 2) {
			obj.value = obj.value.substr(0,7)+'-'+ obj.value.substr(8,1);
		} else if (temp!=""&&temp.length==7) {
			obj.value = temp + '-';
		} else if (obj.value.length == 5 && obj.value.indexOf("-") == -1) {
			obj.value = obj.value.substr(0,4)+'-'+ obj.value.substr(4,1);
		} 
	} 
	temp1 = obj.value.length;
}

//复制到剪贴板
function copyToClipboard(_name, _cue) 
{ 
	//alert(btn.value);
	var _labelTemp = document.getElementById(_name);
	window.clipboardData.setData('text', _labelTemp.innerText); 
	alert("\"" + _cue + "\" 已复制到剪切板！");
} 

//过滤半角分号，替换为全角分号
function replaceFH(str){
   var r = "";
   var re = /;/g;             // 创建正则表达式模式。
   if(str)
   	r = str.replace(re, "；");    // 用 "；" 替换 ";"。
   return r;                   // 返回替换后的字符串。
}

//本函数用于去掉字符串左边的空格 
function leftTrim(str) { 
    if (str.charAt(0) == " ") { 
        str = str.slice(1); 
        str = leftTrim(str); 
    } 
    
    return str; 
} 

 //本函数用于去掉字符串右边的空格 
 function rightTrim(str) { 
    if (str.length - 1 >= 0 && str.charAt(str.length - 1) == " ") { 
        str = str.slice(0, str.length - 1); 
        str = rightTrim(str); 
    } 
    
    return str; 
} 
// 去左右空格; 
function  trim(s){
  return  rightTrim(leftTrim(s));
} 

//检测日期
function checkDate(propertyName,tempProperty,ChineseName){
	var obj = document.getElementsByName(propertyName)[0];
	var tempObj = document.getElementsByName(tempProperty)[0];
	if(obj==null ||  obj.value==""){
		return true;
	}
	var bReturn = __checkStdDate(obj);
	if (false == bReturn){
		alert("属性'" + ChineseName + "'不符合日期格式(YYYYMMDD)")
		obj.value='';
    tempObj.focus();
    obj.focus();
    obj.select();
		return false;
	}
	return true;
}


function __checkStdDate(eSrc)
{
	var value = eSrc.value;
	if (!__isNum(value)) {
		sError = "必须为数字";
		return false;
	}
	if (value.length != 8) {
		sError = "长度出错";
		return false;
	}

	var year = value.substring(0,4);
	var month = value.substring(4,6);
	var day = value.substring(6,8);
	var y = year * 1;
	var m = month * 1;
	var d = day * 1;
	var bReturn = __isLegalDate(y,m,d);
	return bReturn;
}

//详细日期验证
function __isLegalDate(year,month,day)
{
     if(year < 0 || year > 9999)
     {
     	sError = "年份错误";
     	return false;
     }
     if(month < 1 || month > 12)
     {
     	sError = "月份错误";
     	return false;
     }
     if(day < 1)
     {
     	sError = "日期小于1";
     	return false;
     }
     if (day > 31)
     {
     	sError = "日期大于31";
     	return false;
     }
     if(month == 2)
     {
     	if( __isLeapYear(year)  )
     	{
        	if(day > 29)
        	{
         		sError = "闰年2月天数不能大于29";
         		return false;
         	}
		}
		else
		{
			if(day > 28)
			{
				sError = "非闰年天数不能大于28";
				return false;
			}
		}
	} else
	{
		var d1, m1=month;
		if(m1 > 7)
			m1 = m1*1 + 1;
		d1 = 30 + m1 % 2;
		if(day > d1)
		{
			sError = "错误";
			return false;
		}
	}
	return true;
}

//验证是否为闰年
function __isLeapYear(year)
{
	if( ( year % 400 == 0) || (( year % 4 == 0) && (year % 100 != 0)) )
		return true;
	else
		return false;
}

//数字校验函数  是否是数字
function __isNum(s)
{
	var re = /^[0-9]+$/;
	return re.test(s);
}

//15转18位身份证号
function get18By15(idCode) {
	var new17Code = idCode.substring(0, 6) + "19" + idCode.substring(6, 15);
	return new17Code + getCheckBit(new17Code);
}

//18转15位身份证号
function get15By18(idCode) {
	var new18Code = idCode.substring(0, 6) + idCode.substring(8, 17);
	return new18Code;
}

//15转18位补位
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

//打印登记信息
function print(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_0_1.fr3";
	
		receiptValue = getDjPrintInfo();
	try{
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取登记打印信息
function getDjPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?>";
	result += "<MakeReport>";
	result += "<APPLY_INFO>";
	
	var ds = L5.DatasetMgr.lookup("ds");	
	var tmpRec = ds.getAt(0);
	result += "<certNo>" + tmpRec.get("certNo") + " </certNo>";	
	result += "<nameMan>" + tmpRec.get("nameMan") + " </nameMan>";	
	var c = -1;
	c = sflbDs.find("value", tmpRec.get("idTypeMan"), 0);
	if(c > -1)
		result += "<idTypeMan>" + sflbDs.getAt(c).get("text") + "</idTypeMan>";
	else
		result += "<idTypeMan> </idTypeMan>";
	
	c = -1;
	c = gjDs.find("value", tmpRec.get("nationMan"), 0);
	if(c > -1)
		result += "<nationMan>" + gjDs.getAt(c).get("text") + "</nationMan>";
	else
		result += "<nationMan> </nationMan>";
		
	c = -1;
	c = zjlxDs.find("value", tmpRec.get("certTypeMan"), 0);
	if(c > -1)
		result += "<certTypeMan>" + zjlxDs.getAt(c).get("text") + "</certTypeMan>";
	else
		result += "<certTypeMan> </certTypeMan>";
			
	result += "<certNumMan>" + tmpRec.get("certNumMan") + " </certNumMan>";	
	result += "<birthMan>" + tmpRec.get("birthMan") + " </birthMan>";		
	
	c = -1;
	c = mzDs.find("value", tmpRec.get("folkMan"), 0);
	if(c > -1)
		result += "<folkMan>" + mzDs.getAt(c).get("text") + "</folkMan>";
	else
		result += "<folkMan> </folkMan>";
	
	c = -1;
	c = hyzkDs.find("value", tmpRec.get("marryStatusMan"), 0);
	if(c > -1)
		result += "<marryStatusMan>" + hyzkDs.getAt(c).get("text") + "</marryStatusMan>";
	else
		result += "<marryStatusMan> </marryStatusMan>";
	
	c = -1;
	c = zyDs.find("value", tmpRec.get("jobMan"), 0);
	if(c > -1)
		result += "<jobMan>" + zyDs.getAt(c).get("text") + "</jobMan>";
	else
		result += "<jobMan> </jobMan>";
	
	c = -1;
	c = whcdDs.find("value", tmpRec.get("degreeMan"), 0);
	if(c > -1)
		result += "<degreeMan>" + whcdDs.getAt(c).get("text") + "</degreeMan>";
	else
		result += "<degreeMan> </degreeMan>";

	result += "<regDetailMan>" + tmpRec.get("regDetailMan") + " </regDetailMan>";		
	result += "<certProofMan>" + tmpRec.get("certProofMan") + " </certProofMan>";		
	result += "<nameWoman>" + tmpRec.get("nameWoman") + " </nameWoman>";	
	
	c = -1;
	c = sflbDs.find("value", tmpRec.get("idTypeWoman"), 0);
	if(c > -1)
		result += "<idTypeWoman>" + sflbDs.getAt(c).get("text") + "</idTypeWoman>";
	else
		result += "<idTypeWoman> </idTypeWoman>";

	c = -1;
	c = gjDs.find("value", tmpRec.get("nationWoman"), 0);
	if(c > -1)
		result += "<nationWoman>" + gjDs.getAt(c).get("text") + "</nationWoman>";
	else
		result += "<nationWoman> </nationWoman>";
	
	c = -1;
	c = zjlxDs.find("value", tmpRec.get("certTypeWoman"), 0);
	if(c > -1)
		result += "<certTypeWoman>" + zjlxDs.getAt(c).get("text") + "</certTypeWoman>";
	else
		result += "<certTypeWoman> </certTypeWoman>";
		
	result += "<certNumWoman>" + tmpRec.get("certNumWoman") + " </certNumWoman>";		
	result += "<birthWoman>" + tmpRec.get("birthWoman") + " </birthWoman>";	
	
	c = -1;
	c = mzDs.find("value", tmpRec.get("folkWoman"), 0);
	if(c > -1)
		result += "<folkWoman>" + mzDs.getAt(c).get("text") + "</folkWoman>";
	else
		result += "<folkWoman> </folkWoman>";
	
	c = -1;
	c = hyzkDs.find("value", tmpRec.get("marryStatusWoman"), 0);
	if(c > -1)
		result += "<marryStatusWoman>" + hyzkDs.getAt(c).get("text") + "</marryStatusWoman>";
	else
		result += "<marryStatusWoman> </marryStatusWoman>";
	
	c = -1;
	c = zyDs.find("value", tmpRec.get("jobWoman"), 0);
	if(c > -1)
		result += "<jobWoman>" + zyDs.getAt(c).get("text") + "</jobWoman>";
	else
		result += "<jobWoman> </jobWoman>";
	
	c = -1;
	c = whcdDs.find("value", tmpRec.get("degreeWoman"), 0);
	if(c > -1)
		result += "<degreeWoman>" + whcdDs.getAt(c).get("text") + "</degreeWoman>";
	else
		result += "<degreeWoman> </degreeWoman>";

	result += "<regDetailWoman>" + tmpRec.get("regDetailWoman") + " </regDetailWoman>";		
	result += "<certProofWoman>" + tmpRec.get("certProofWoman") + " </certProofWoman>";			
	result += "<checkData>" + tmpRec.get("checkData") + " </checkData>";			
	result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";			
	result += "<printNumMan>" + tmpRec.get("printNumMan") + " </printNumMan>";			
	result += "<printNumWoman>" + tmpRec.get("printNumWoman") + " </printNumWoman>";			
	result += "<operator>" + tmpRec.get("operator") + " </operator>";			
	result += "<docPageNum>" + tmpRec.get("docPageNum") + " </docPageNum>";			
	result += "<remark>" + tmpRec.get("remark") + " </remark>";			
	result += "<printRemark>" + tmpRec.get("printRemark") + " </printRemark>";			
	
	result += "</APPLY_INFO>";
	result += "</MakeReport>";
	
	//alert(result)
	return result;		
}





