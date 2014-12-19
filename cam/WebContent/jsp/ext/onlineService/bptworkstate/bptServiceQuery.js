function init() {
	createCode();
	
	querydataset.on("load",function(){
		if(querydataset.getCount()<1){
			document.getElementById("msg").innerHTML="<strong><font size=\"6\" color=\"#01669A\">没有查询到相关信息!</font></strong>";
		}else {
			document.getElementById("msg").innerHTML="";
		}
	});
	L5.QuickTips.init();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	var idCard = getParam("idCard");
	var serviceType = getParam("serviceType");
	
	if(idCard==''||idCard=='请输入身份证号'){
		alert("请输入身份证号！");
		return false;
	}
	var inputCode = document.getElementById("input1").value.toUpperCase();
	
	if(inputCode.length <=0) {
	   alert("请输入验证码！");
	   return false;
	}else if(inputCode != code ){
	   alert("验证码输入错误！");
	   createCode();
	   return false;
	}
	createCode();
	querydataset.setParameter("idCard",idCard);
	querydataset.setParameter("serviceType",serviceType);
	querydataset.load();
}
//获取项目根路径
function getProjectName(){
	var curWwwPath=window.document.location.href;
	var pathName=window.document.location.pathname;
	var pos=curWwwPath.indexOf(pathName);
	var localhostPaht=curWwwPath.substring(0,pos);
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	return projectName;
}

var code ; //在全局 定义验证码
function createCode(){ 
	code = "";
	var codeLength = 4;//验证码的长度
	var checkCode = document.getElementById("checkCode");
	checkCode.innerHTML = "";
	
	var selectChar = new Array(1,2,3,4,5,6,7,8,9,0,'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');
	
	for(var i=0;i<codeLength;i++) {
	   var charIndex = Math.floor(Math.random()*32);
	   code +=selectChar[charIndex];
	}
	if(code.length != codeLength){
	   createCode();
	}
	checkCode.innerHTML = code;
}