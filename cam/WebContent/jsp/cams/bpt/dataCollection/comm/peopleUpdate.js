var oldIdCard="";
var cardflag=true;
function init() {
	var BaseinfoPeopleDataSet= L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("PEOPLE_ID@=",peopleId);
	BaseinfoPeopleDataSet.load();	
	L5.QuickTips.init();
	BaseinfoPeopleDataSet.on("load",function(){
	  fun_show();
	  if(cardflag){
		  oldIdCard=BaseinfoPeopleDataSet.get("idCard");
		  cardflag=false;
	  }
	});
}

function fun_show(){
    if(document.getElementById("domicileType").value=='1'){
	   document.getElementById("work").style.display='none';
       document.getElementById("workAddress").style.display='none';
       document.getElementById("employmentCode").disabled=true;
	}
}
function save(){
	var img=document.getElementById("photoTemp").value;
	
	//验证身份证号
	idCard =document.forms[0].idCard;	
    idCardValue=idCard.value;   
    if(idCardValue==null||idCardValue=="")
    {
    	L5.Msg.alert("提示", "身份证格式不能为空!");
    	return false;
    }
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	BaseinfoPeopleRecord.set('photoTemp',img);
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	getCrjCnStrSpell('namebase','phoneticCode','m');
	var phoneticCode=document.getElementById("phoneticCode").value;
	BaseinfoPeopleRecord.set('phoneticCode',phoneticCode);
	
	// 校验户口薄(行政区划)
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if (domicileCode == '') {
		L5.Msg.alert('提示', '户口薄(行政区划)不能为空！');
		return false;
	}
	
	
	// 校验实际居住(行政区划)
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if (apanageCode == '') {
		L5.Msg.alert('提示', '实际居住(行政区划)不能为空！');
		return false;
	}
	
	//医疗保障方式规划
	var safeguardType = BaseinfoPeopleRecord.get("safeguardType");
	if(safeguardType==''){
		 L5.Msg.alert('提示','医疗保障方式不能为空！');
		 return false;
	}
	
	//校验户籍类别
	var domicileType = BaseinfoPeopleRecord.get("domicileType");
	if(domicileType==''){
		 L5.Msg.alert('提示','户籍类别不能为空！');
		 return false;
	}
	//校验年收入是否是数字类型
	var incomeYear = BaseinfoPeopleRecord.get("incomeYear");
	if(!incomeYear==''){
	//校验年收入格式
	var incomeYear = document.getElementById("incomeYear").value;
		if(!isFloat(incomeYear)){
		
			 L5.Msg.alert('提示','年收入格式不正确！');
			 return false;
		}
	}
	//func_HaveCheck();
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
	
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.execute("updatePeople");
	
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//关闭
function func_Close(){
	window.close();
}

function fun_Type(){
  if(document.getElementById("domicileType").value=='1'){
     document.getElementById("work").style.display='none';
     document.getElementById("workAddress").style.display='none';
     document.getElementById("employmentCode").disabled=true;
  }else{
     document.getElementById("work").style.display='';
     document.getElementById("workAddress").style.display='';
     document.getElementById("employmentCode").disabled=false;
  }
}

function func_CheckIdCard(){
	idCard =document.forms[0].idCard;	
    idCardValue=idCard.value;   
    if(idCardValue==null||idCardValue=="")
    {
    	L5.Msg.alert("提示", "身份证格式不能为空!");
    	return false;
    }
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	if(oldIdCard==idCardValue){
		return false; 
	}
	
	func_HaveCheck();
}
function func_HaveCheck(){
	idCardValue1 = document.getElementById("idCard").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
	
	command.setParameter("id_Card", idCardValue1);
	command.execute("queryHavePeople");
	var havePeople = command.getReturn("havePeople");
	
	if(havePeople=="havedel"){
		L5.Msg.alert("提示", "该人员已经被删除,请重新录入!");
		document.forms[0].reset();
		init();
		BaseinfoPeopleDataSet.getCurrent().set("haveNewCard","");
		var imgObj=document.getElementsByName("RELATIONER_PHOTOC_IMG")[0];
		var imgDiv=document.getElementById("RELATIONER_PHOTOC_IMG_DIV0");
		imgDiv.style.display="none";
		imgObj.style.display="";
	}else if(havePeople=="hava"){
		L5.Msg.alert("提示", "系统中有此人信息,请在新增中录入!");
		document.forms[0].reset();
		init();
		BaseinfoPeopleDataSet.getCurrent().set("haveNewCard","");
		var imgObj=document.getElementsByName("RELATIONER_PHOTOC_IMG")[0];
		var imgDiv=document.getElementById("RELATIONER_PHOTOC_IMG_DIV0");
		imgDiv.style.display="none";
		imgObj.style.display="";
	}
	
	
	func_ShowBirthday();
}

//是否是Float
function isFloat(s){
		if(_isNum(s)) return true;
	return /^[+|-]{0,1}\d*\.?\d+$/.test(s);
}
		//校验是否数字
function _isNum(s){
	return /^[0-9]+$/.test(s);
}
