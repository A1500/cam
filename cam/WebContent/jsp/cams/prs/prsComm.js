function showBirthday() 
{ 
   var val=document.forms[0].idCard.value;
   var birthdayValue; 
   if(15==val.length){ //15位身份证号码 
       birthdayValue = val.charAt(6)+val.charAt(7); 
       if(parseInt(birthdayValue)<10){ 
           birthdayValue = '20'+birthdayValue; 
       }else { 
           birthdayValue = '19'+birthdayValue; 
       } 
           birthdayValue=birthdayValue+'-'+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11);
           document.forms[0].birthday.value=birthdayValue; 
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13); 
           document.forms[0].birthday.value=birthdayValue;
   } 
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
//手动输入时间格式(适用于月份) 
function changeDateStyle_Mon(obj) {
	var temp = obj.value;
	if(temp!=""&&temp.length == 4) {
		obj.value = temp + '-';
	} 
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}