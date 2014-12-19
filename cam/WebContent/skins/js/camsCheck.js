String.prototype.trim=function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
String.prototype.ltrim=function(){
	return this.replace(/^\s*/g,"");
}
String.prototype.rtrim=function(){
	return this.replace(/\s*$/g,"");
}
function is0To9(){
	for(var i=0; i<this.length; i++) {
		var codeValue = this.charCodeAt(i);
		if(codeValue < 48 || codeValue > 57) return false;
	}
	return true;
}
String.prototype.is0To9 = is0To9;
//校验是否数字
function _isNum(s){
	return /^[0-9]+$/.test(s);
}
//是否是Float
function isFloat(s){
	if(_isNum(s)) return true;
	return /^[+|-]{0,1}\d*\.?\d+$/.test(s);
}

//函数功能：判断是否含有中文及全角？之外的其他字符
 function __isCN(s){
		var i=s.indexOf(".");
		if(i>-1){
			s=s.replace(".","");
		}
		var re = /^[？\u4E00-\u9FA5]+$/;
		return re.test(s);
 }
//处理输入金额的小数点位数
function changeTwoDecimal(num){
    var f_Num=parseFloat(num);
    f_Num=Math.round(f_Num*100)/100;
    var s_Num=f_Num.toString();
    var pos_Num=s_Num.indexOf('.');
    if(pos_Num<0){
     	pos_Num=s_Num.length;
		s_Num+='.';
    }
    while(s_Num.length <= pos_Num + 2){
		s_Num += '0';
     }
    return s_Num;
} 
//处理输入金额的小数点位数
function formatNum(value){
	if(isFloat(value)){
		return changeTwoDecimal(value);
	}
	return value;
}
//是否有特殊符号
function isQuoteIn(s){
	return /\"|\'|\“|\”|\‘|\’|\%|\$|\￥|\……|\·|\—|\-|\——|\!|\！|\#|\@|\~|\^|\*|\,|\.|\，|\。|\?|\？|\;|\；|\:|\：|\{|\}|\\|\/|\[|\]|\(|\)|\+|\-|\、|\||\<|\>/.test(s);
}
//字符是否？
function isNumChar(c){
	return c>='0'&&c<='9';
}
//是否是空格，转行等
function isBlankChar(c){
	return c==' '||c=='\f'||c=='\n'||c=='\r'||c=='\t';
}
//获得字符串的长度   一个汉字占2个字节
function byteLength(s){
	var r=/[\u4E00-\u9FA5]/g;
	if(r.test(s))
	return s.length+s.match(r).length;
	else return s.length;
}
//校验金额，s为值，n为小数点个数
function checkMoneyFix(s,n){
	if(s.match(/(^[0-9]+$)/) != null){
		return "整数";
	}
	if(s.match(/(^[0-9]+)(.[0-9]+$)/)==null){
		return false;
	}else{
		var i=s.indexOf(".")+1;
		if(s.substring(i).length!=n) return false;
	}
	return true;
}
//获得当前日期 2011-05-16
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}
//获得当前日期 2011年05月16日
function getCurrentDate(){
	var curDate=getCurDate();
	return curDate.substring(0,4)+"年"+curDate.substring(5,7)+"月"+curDate.substring(8,10)+"日";
}
//日期校验：YYYYMMDD
function isDate(s){
	var year=s.substring(0,4);
	var month=s.substring(4,6);
	var day=s.substring(6,8);
	if(!year.is0To9()||!month.is0To9()||!day.is0To9()) return false;
	//year
	var yearInt=parseInt(year);
	if(yearInt<1||yearInt>9999) return false;
	//month
	var monthInt = parseInt(month,10);
	if(monthInt<1||monthInt>12) return false;
	//day
	var dayInt=parseInt(day,10);
	var monthMax;
	if((yearInt%4==0&&yearInt%100!=0)||yearInt%400==0){
		monthMax=new Array(31,29,31,30,31,30,31,31,30,31,30,31);
	}else{
		monthMax=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	}
	if(dayInt<1||dayInt>monthMax[monthInt-1]) return false;
	return true;
}
//日期校验：YYYY-MM-DD
function checkDate(s){
	if(s.length!=10) return false;
	var y=s.substring(0,4);
	var m=s.substring(5,7);
	var d=s.substring(8,10);
	return isDate(y+""+m+""+d);
}
//时间校验：YYYY-MM-DD hh24:mm:ss
function checkTime(s){
	if(s.length!=19) return false;
	if(!checkDate(s.substring(0,10))) return false;
	var h=s.substring(11,13)*1;
	if(h<0||h>24) return false;
	var m=s.substring(14,16)*1;
	if(m<0||m>59) return false;
	var s=s.substring(17,19)*1;
	if(s<0||s>59) return false;
	return true;
}

//日期比较：s>=e返回true，s<e返回false
function compareDate(s,e){
	if(!checkDate(s)) return false;
	if(!checkDate(e)) return false;
	var sc=s.replace('-','').replace('-','');
	var ec=e.replace('-','').replace('-','');
	if(sc>=ec) return true;
	return false;
}
//出生日期校验：YYYY-MM-DD
function checkBirthday(s){
	if(!checkDate(s.substring(0,10))) return false;
	if(compareDate(getCurDate(),s)) return true;
	return false;
}
//检验网址
function IsURL(str_url){ 
	var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
		+ "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@  
		+ "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184  
		+ "|" // 允许IP和DOMAIN（域名） 
		+ "([0-9a-z_!~*'()-]+\.)*" // 域名- www.  
		+ "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名  
		+ "[a-z]{2,6})" // first level domain- .com or .museum  
		+ "(:[0-9]{1,4})?" // 端口- :80  
		+ "((/?)|" // a slash isn't required if there is no file name  
		+ "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";  
    var re=new RegExp(strRegex);  //re.test() 
    if (re.test(str_url)){ 
        return (true);  
    }else{  
        return (false);  
    } 
} 

//检验邮编///////////////////
function _isPostCode(s){
	return /^\d{6}$/.test(s);
}
//校验固话号码
function isFTel(s){
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,8}(-\d+)?$/g.test(s);
}
//校验手机号码
function isMTel(s){
	return /^1(3\d|(58|59|56|52|53|50|51|55|56|57|58|59|86|89))\d{8}$/g.test(s);
}
//校验电话号码///////////////////////
function isTel(s){
	return isFTel(s)||isMTel(s);
}
//校验邮箱
function isEmail(e){
	var s=e.match("^(.+)@(.+)$");
	if(s==null) return false;
	if(s[1]!=null){
		//var r=/^\"?[\w-_\.]*\"?$/;
		if(s[1].match(/^\"?[\w-_\.]*\"?$/)==null) return false;
	}
	if(s[2] != null){
		var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
		if(s[2].match(regexp_domain) == null){
			var regexp_ip=/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
			if(s[2].match(regexp_ip) == null) return false;
		}
		return true;
	}
	return false;
}
//校验身份证号，并将15位身份证号转换为18位
function checkIDCard(o){
	if(o.value=="") return true;
	if(o.value.substr(0,1) == "B") return true;
	if(o.value=="000000000000000000") return true;
	var val=o.value.toUpperCase();
	o.value=val;
	if(val.length==15){
		if(!is15IDCard(val)){
			return false;
		}else{
			var temp=val.substring(0,6)+"19"+val.substring(6,15);
			o.value=temp+getCheckBit(temp);
		}
	}else if(val.length==18){
		if(!is18IDCard(val)){
			return false;
		}
	}else{
		return false;
	}
	return true;
}// 校验身份证号，并将15位身份证号转换为18位
function checkIdCard(idCard) {
	if (idCard == "")
		return true;
	if (idCard == "000000000000000000")
		return true;
	var val = idCard.toUpperCase();
	idCard = val;
	if (val.length == 15) {
		if (!is15IDCard(val)) {
			return false;
		} else {
			var temp = val.substring(0, 6) + "19" + val.substring(6, 15);
			idCard = temp + getCheckBit(temp);
			return idCard;
		}
	} else if (val.length == 18) {
		if (!is18IDCard(val)) {
			return false;
		}
	} else {
		return false;
	}
	return idCard;
}
//计算出合法身份证（17位或者18位）最后一位的校验位
function getCheckBit(idCode){
	var code=idCode.substring(0,17);
	var szVerCode="10X98765432";
	var iw=new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2);
	var bitValue = 0;
	for (var i=0; i<code.length; i++) {
		bitValue += code.charAt(i).valueOf() * iw[i];
	}
	bitValue = bitValue % 11;
	return szVerCode.charAt(bitValue);
}
//判断15位身份证
function is15IDCard(i){
	if(i.length!=15) return false;
	if(!i.is0To9()) return false;
	if(!isDate("19"+i.substring(6,12))) return false;
	return true;
}
//判断18位身份证
function is18IDCard(i){
	i=i.toUpperCase();
	if(i.length!=18) return false;
	if(!i.substring(0,17).is0To9()) return false;
	if(!isDate(i.substring(6,14))) return false;
	if(i.charAt(17)!=getCheckBit(i)) return false;
	return true;
}
//由18位的合法身份证得到出生日期(YYYY-MM-DD)
function getBirthByCode(idCode){
	return idCode.substring(6,10)+ "-" +idCode.substring(10,12) + "-" +idCode.substring(12,14);
}
//由18位的合法身份证得到出生年月(YYYY-MM)
function getBirthdayByCode(idCode){
	return idCode.substring(6,10)+ "-" +idCode.substring(10,12);
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
// 格式化日期
function formatDate2String(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1))
			+ "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate())
			+ ""
			+ " "
			+ (date.getHours() > 9 ? date.getHours() : "0" + date.getHours())
			+ ":"
			+ (date.getMinutes() > 9 ? date.getMinutes() : "0"
					+ date.getMinutes());
}
//将string类型日期转换成Date
function getDateFromString(dt1){
	return new   Date(dt1.substring(0, 4),   dt1.substring(5, 7)-1,   dt1.substring(8, 10))
}
// 日期加法
function dateAdd(date, flag, interval) {
	var res = new Date();
	if (flag=='y'){
		res.setTime(date.getTime() + interval *365* 24 * 60 * 60 * 1000);
	}else if (flag == 'd') {
		res.setTime(date.getTime() + interval * 24 * 60 * 60 * 1000);
	} else if (flag == 'H') {
		res.setTime(date.getTime() + interval * 60 * 60 * 1000);
	} else if (flag == 'm') {
		res.setTime(date.getTime() + interval * 60 * 1000);
	}  
	return res;
}
// 日期减法 计算出两个日期相差的天数
function DateDiff(dt1, dt2) {
	if (!checkDate(dt1))
		return false;
	if (!checkDate(dt2))
		return false;
	var   d1   =   new   Date(dt1.substring(0, 4),   dt1.substring(5, 7),   dt1.substring(8, 10));
	var   d2   =   new   Date(dt2.substring(0, 4),   dt2.substring(5, 7),    dt2.substring(8, 10));
	return (d1   -   d2)/(3600*24*1000);
}
//由18位的合法身份证得到年龄
function getAgeByCode(idCode){
	var birthday = idCode.substring(6,14);
	var curDate = new Date();
	var curYear = ''+curDate.getFullYear();
	var curMonth = ''+(curDate.getMonth()+1);
	var curDate = ''+curDate.getDate();
	if(curMonth.length == 1){
		curMonth = '0'+curMonth;
	}
	if(curDate.length == 1){
		curDate = '0'+curDate;
	}
	var curDateStr = curYear+curMonth+curDate;
	var age = Math.floor((parseInt(curDateStr)-parseInt(birthday))/10000)+'';
	if(age=="NaN"){
		age='';
	}
	return age;
}
//由生日得到年龄 例如1988-08-08或1988-08
function getAgeByBirthday(birthday){
	var arg = birthday.split("-");
	var _birthday = "";
	for(i=0;i<arg.length;i++){
		_birthday = _birthday+arg[i];
	}
	var curDate = new Date();
	var curYear = ''+curDate.getFullYear();
	var curMonth = ''+(curDate.getMonth()+1);
	if(curMonth.length == 1){
		curMonth = '0'+curMonth;
	}
	var curDay = ''+curDate.getDate();
	if(arg.length==3){
		if(curDay.length == 1){
			curDay = '0'+curDay;
		}
	}else if(arg.length==2){
		curDay = '00';
		_birthday=_birthday+'00';
	}
	var curDateStr = curYear+curMonth+curDay;
	var age = Math.floor((parseInt(curDateStr)-parseInt(_birthday))/10000)+'';
	if(age=="NaN"){
		age='';
	}
	return age;
}
/********************************************************************************
*                                 金额小写转大写								    *
********************************************************************************/
function arabiaToChinese(Num){
	for(i=Num.length-1;i>=0;i--){
		 Num = Num.replace(",","")//替换tomoney()中的“,”
		 Num = Num.replace(" ","")//替换tomoney()中的空格
	}
 	//Num = Num.replace("￥","")//替换掉可能出现的￥字符
	if(isNaN(Num)) { //验证输入的字符是否为数字
		 alert("请检查小写金额是否正确");
		 return;
	}
 	//---字符处理完毕，开始转换，转换采用前后两部分分别转换---//
	part = String(Num).split(".");
	newchar = ""; 
	//小数点前进行转化
	for(i=part[0].length-1;i>=0;i--){
		if(part[0].length > 10){ 
			alert("位数过大，无法计算");return "";
		}//若数量超过拾亿单位，提示
		tmpnewchar = ""
		perchar = part[0].charAt(i);
		switch(perchar){
			case "0": tmpnewchar="零" + tmpnewchar ;break;
			case "1": tmpnewchar="壹" + tmpnewchar ;break;
			case "2": tmpnewchar="贰" + tmpnewchar ;break;
			case "3": tmpnewchar="叁" + tmpnewchar ;break;
			case "4": tmpnewchar="肆" + tmpnewchar ;break;
			case "5": tmpnewchar="伍" + tmpnewchar ;break;
			case "6": tmpnewchar="陆" + tmpnewchar ;break;
			case "7": tmpnewchar="柒" + tmpnewchar ;break;
			case "8": tmpnewchar="捌" + tmpnewchar ;break;
			case "9": tmpnewchar="玖" + tmpnewchar ;break;
		}
		switch(part[0].length-i-1){
		    case 0: tmpnewchar = tmpnewchar +"元" ;break;
		    case 1: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
		    case 2: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
		    case 3: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
		    case 4: tmpnewchar= tmpnewchar +"万" ;break;
		    case 5: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
		    case 6: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
		    case 7: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
		    case 8: tmpnewchar= tmpnewchar +"亿" ;break;
		    case 9: tmpnewchar= tmpnewchar +"拾" ;break;
  		}
  		newchar = tmpnewchar + newchar;
	}
	//小数点之后进行转化
	// if(Num.indexOf(".")!=-1){
	if(part[1].length > 2) {
		//alert("小数点之后只能保留两位,系统将自动截段");
		part[1] = part[1].substr(0,2)
	}
	for(i=0;i<part[1].length;i++){
		tmpnewchar = ""
		perchar = part[1].charAt(i)
		switch(perchar){
			case "0": tmpnewchar="零" + tmpnewchar ;break;
			case "1": tmpnewchar="壹" + tmpnewchar ;break;
			case "2": tmpnewchar="贰" + tmpnewchar ;break;
			case "3": tmpnewchar="叁" + tmpnewchar ;break;
			case "4": tmpnewchar="肆" + tmpnewchar ;break;
			case "5": tmpnewchar="伍" + tmpnewchar ;break;
			case "6": tmpnewchar="陆" + tmpnewchar ;break;
			case "7": tmpnewchar="柒" + tmpnewchar ;break;
			case "8": tmpnewchar="捌" + tmpnewchar ;break;
			case "9": tmpnewchar="玖" + tmpnewchar ;break;
		}
		if(i==0)tmpnewchar =tmpnewchar + "角";
		if(i==1)tmpnewchar = tmpnewchar + "分";
  		newchar = newchar + tmpnewchar;
	}
 	//替换所有无用汉字
	while(newchar.search("零零") != -1)
		newchar = newchar.replace("零零", "零");
		newchar = newchar.replace("零亿", "亿");
		newchar = newchar.replace("亿万", "亿");
		newchar = newchar.replace("零万", "万");
		newchar = newchar.replace("零元", "元");
		newchar = newchar.replace("零角", "");
		newchar = newchar.replace("零分", "");
	
	if (newchar.charAt(newchar.length-1) == "元" || newchar.charAt(newchar.length-1) == "角"){
		newchar = newchar+"整";
	}
	return newchar;
}

//组织机构代码校验//////////////////////
function isOrganCode(o){
	o.value=o.value.toUpperCase();
	var organCode=o.value;
	if(organCode=="") return true;
	if(organCode.length!=9) return false;
	// 组织机构码每一位的权重。
	var power=new Array('3','7','9','10','5','8','4','2');
	var m=0;//校验位
	for(var i=0;i<=7;i++){
		if(organCode.charAt(i)==0||0/organCode.charAt(i)==0){
			m+=organCode.charAt(i)*power[i];
		}else{
			m+=organCode.charCodeAt(i)*power[i];
		}
	}
	m=11-m%11;
	if(m==10) m='X';
	if(m==11) m=0;
	if(organCode.charAt(8)!=m){
		return false;
	}
	return true;
}
//社会组织职务基金会理事列表
function initDutyL(){
	sorgDutiesDataSet.filterBy(function(record, id){
		if("00001,00003,00004,00005,00013".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
/**
 * 格式化显示金额方法
 * @param {} s 要格式的金额
 * @param {} n 小数点后保留位数
 * @return {String}
 */
function formatMoney(s, n) {
	if(!isFloat(s)){
		return s;
	}
	if(!_isNum(n)){
		n=2;
	}
	n = n >= 0 && n <= 20 ? n : 2;
	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
	var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];
	t = "";
	for (i = 0; i < l.length; i++) {
		t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
	}
	if(n == 0){
		return t.split("").reverse().join("");
	}else{
		return t.split("").reverse().join("") + "." + r;
	}
}
//社会组织职务基金会监事列表
function initDutyS(){
	sorgDutiesDataSet.filterBy(function(record, id){
		if("00006".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
//防止重复提交shgtch 20120515
var L5_Button_Id;
function noReclick(ds,b){
	L5_Button_Id = b;
	document.getElementById(L5_Button_Id).disabled=true;
	ds.on('load',disabledButton);
}
function disabledButton(ds){
	document.getElementById(L5_Button_Id).disabled=false;
	ds.un('load',disabledButton);
}
//如果值为空 则返回0
function nullToZero(value){
	if(value == ''){
		return 0;
	}
	return value;
}

function isInArray(element,sourceStr){
	var str=new Array();
	str=sourceStr.split(",");
	for(var i=0;i<str.length;i++){
		if(element==str[i])
			return true;
	}
	return false;
}