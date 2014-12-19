function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
//浮点数加法运算   
function FloatAdd(arg1,arg2){   
  var r1,r2,m;   
  try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}   
  try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}   
  m=Math.pow(10,Math.max(r1,r2));   
  return (arg1*m+arg2*m)/m;   
 }   
  
//浮点数减法运算   
function FloatSub(arg1,arg2){   
var r1,r2,m,n;   
try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}   
try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}   
m=Math.pow(10,Math.max(r1,r2));   
//动态控制精度长度   
n=(r1>=r2)?r1:r2;   
return ((arg1*m-arg2*m)/m).toFixed(n);   
}   
   
//浮点数乘法运算   
function FloatMul(arg1,arg2)    
{    
 var m=0,s1=arg1.toString(),s2=arg2.toString();    
 try{m+=s1.split(".")[1].length;}catch(e){}    
 try{m+=s2.split(".")[1].length;}catch(e){}    
 return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);    
 }    
  
  
//浮点数除法运算   
function FloatDiv(arg1,arg2){    
var t1=0,t2=0,r1,r2;    
try{t1=arg1.toString().split(".")[1].length;}catch(e){}    
try{t2=arg2.toString().split(".")[1].length;}catch(e){}    
with(Math){    
r1=Number(arg1.toString().replace(".",""));    
r2=Number(arg2.toString().replace(".",""));    
return (r1/r2)*pow(10,t2-t1);    
}    
} 

//时间
function getTimes(item) {
	LoushangDate(item.previousSibling);
}
//时间19位
function getTimes19(item){
	LoushangDatetime(item.previousSibling);
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
			obj.value = obj.value.substr(0,7)+'-'+ obj.value.substr(7,1);
		} else if (temp!=""&&temp.length==7) {
			obj.value = temp + '-';
		} else if (obj.value.length == 5 && obj.value.indexOf("-") == -1) {
			obj.value = obj.value.substr(0,4)+'-'+ obj.value.substr(4,1);
		} 
	} 
	temp1 = obj.value.length;
}
//小数点位数处理
function checkAssMon(domId){
	if(document.getElementById(domId).value){
		if(!isFloat(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
		document.getElementById(domId).value=changeTwoDecimal(document.getElementById(domId).value);
	}
}
//判断是否为小数
function checkFloat(domId){
	if(document.getElementById(domId).value){
		if(!isFloat(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
	}
}
//身份证校验
function CheckIdCardMessage(){
	var idCard = document.getElementById("idCard");
	if(idCard.value==""||idCard.value==null||idCard.value=="000000000000000000"){
		return
	}
	if(!checkIDCard(idCard)){
		L5.Msg.alert("提示","身份证号码不正确，请重新填写！");
		return false;
	}
	/*var idCardFamilyDs = L5.DatasetMgr.lookup("idCardFamilyDs");
	idCardFamilyDs.setParameter("ID_CARD",idCard.value);
	idCardFamilyDs.load();
	idCardFamilyDs.on("load",function(){
		if(idCardFamilyDs.getCount()<1)return false;//无历史身份证
		familyDs.set("name",idCardFamilyDs.get("NAME"));
		document.getElementById("name").value = idCardFamilyDs.get("NAME");
		familyDs.set("idCard",idCardFamilyDs.get("ID_CARD"));
		document.getElementById("idCard").value = idCardFamilyDs.get("ID_CARD");
		familyDs.set("familyNum",idCardFamilyDs.get("FAMILY_NUM"));
		document.getElementById("familyNum").value = idCardFamilyDs.get("FAMILY_NUM");
		familyDs.set("familyType",idCardFamilyDs.get("FAMILY_TYPE"));
		document.getElementById("familyType").value = idCardFamilyDs.get("FAMILY_TYPE");
		familyDs.set("familyRegister",idCardFamilyDs.get("FAMILY_REGISTER"));
		document.getElementById("familyRegister").value = idCardFamilyDs.get("FAMILY_REGISTER");
		if(idCardFamilyDs.get("HOUSE_COUNT")!=""&&document.getElementById("houseCount")!=null){//最新的身份证信息是重建的。即使重建的input中没有数据，只要有id="houseCount"存在，document.getElementById就不会为null
			familyDs.set("houseCount",idCardFamilyDs.get("HOUSE_COUNT"));
			document.getElementById("houseCount").value = idCardFamilyDs.get("HOUSE_COUNT");
		}//民房重建用
		if(idCardFamilyDs.get("HOUSE_STRUCTURE")!=""&&document.getElementById("houseStructure")!=null){
			familyDs.set("houseStructure",idCardFamilyDs.get("HOUSE_STRUCTURE"));
			document.getElementById("houseStructure").value = idCardFamilyDs.get("HOUSE_STRUCTURE");
		}//民房重建用
	});*/
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

function formatDateToString(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}

//是否是Float
function isFloat(s){
	if(_isNum(s)) return true;
	return /^[+|-]{0,1}\d*\.?\d+$/.test(s);
}
//处理输入金额的小数点位数
function changeDecimal(num){
    var f_Num=parseFloat(num);
    f_Num=Math.round(f_Num*10000)/10000;
    var s_Num=f_Num.toString();
    var pos_Num=s_Num.indexOf('.');
    if(pos_Num<0){
     	pos_Num=s_Num.length;
		s_Num+='.';
    }
    while(s_Num.length <= pos_Num + 4){
		s_Num += '0';
     }
    return s_Num;
} 
//处理输入金额的小数点位数
function formatMoneyForDis(value){
	if(isFloat(value)){
		return changeDecimal(value);
	}
	return value;
}
// 检查数值是否为整数
function checkInteger(_value) {
	if (!_isNum(_value)) {
		return false;
	}
	return true;
}
// 检查数值是否为小数点后1位
function checkCusFloat(_value) {
	_value=_value+"";
	if (_isNum(_value)) {
		return true;
	}
	if (isFloat(_value)) {
		if (!checkMoneyFix(_value, 1)) {
			return false;
		}
	} else {
		return false;
	}
	return true;
}

//姓名输入中文校验
function checkCN(propertyName, ChineseName) {
	var obj = document.getElementsByName(propertyName)[0];
	if (obj == null) {
		return true;
	}
	var str = obj.value;
	if (str.length == 0 || __isCN(str)) {
		return true;
	} else {
		alert("属性‘" + ChineseName + "’包含非中文，请重新输入！");

		obj.value = "";
		obj.select();
		return false;
	}
	return true;
}

function CheckTxt(ObjNum, ChnName) {
	var regExp = /^\d+(\.\d+)?$/;
	var elementTxt = document.getElementById(ObjNum);
	if (regExp.test(elementTxt.value)) {
		return true;
	} else {
		alert(ChnName + '请输入阿拉伯数字');
		elementTxt.focus();
		elementTxt.value = "";
		return false;
	}
}
