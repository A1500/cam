var idCard;
var idCardValue;
var stype;
function init() {
	var BaseinfoPeopleDataSet= L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.newRecord({peopleId: document.forms[0].peopleId.value,familyId: document.forms[0].familyId.value});
	L5.QuickTips.init();
}

function save(){
	 var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();	
	if(BaseinfoPeopleRecord.get("peopleId")==""||BaseinfoPeopleRecord.get("peopleId")==null)
	{
		BaseinfoPeopleRecord.set("peopleId",peopleId);		
	}else{
		peopleId=BaseinfoPeopleRecord.get("peopleId");
	}
	BaseinfoPeopleRecord.set("familyId",familyId);
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
		//校验属地行政规划
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if(domicileCode==''){
		 L5.Msg.alert('提示','属地行政规划不能为空！');
		 return false;
	}
	
	//医疗保障方式规划
	var safeguardType = BaseinfoPeopleRecord.get("safeguardType");
	if(safeguardType==''){
		 L5.Msg.alert('提示','医疗保障方式不能为空！');
		 return false;
	}
	
	//校验住址行政规划
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if(apanageCode==''){
		 L5.Msg.alert('提示','地址行政规划不能为空！');
		 return false;
	}
	
	//校验户籍类别
	var domicileType = BaseinfoPeopleRecord.get("domicileType");
	if(domicileType==''){
		 L5.Msg.alert('提示','户籍类别不能为空！');
		 return false;
	}
	//校验年收入格式
	var incomeYear = document.getElementById("incomeYear").value;
	if(incomeYear!=""&&!isFloat(incomeYear)){
	
		 L5.Msg.alert('提示','年收入格式不正确！');
		 return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.execute("insertFamilyPeople");
	
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		BaseinfoPeopleDataSet.setParameter("PEOPLE_ID",peopleId);
		BaseinfoPeopleDataSet.load();
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function clo(){
	window.close();
}
function func_Type(){
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

/*
*由身份证自动生成出生日期
*/
function func_ShowBirthday() 
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
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
   } 
}

//验证身份证合法性
function func_QueryIdCard(){ 
	idCard =document.forms[0].idCard;	
	//stype =document.forms[0].stype.value;
    idCardValue=idCard.value;   
    if(idCardValue==null||idCardValue=="")
    {
    	return;
    }
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	BaseinfoPeopleDataSet.setParameter("ID_CARD@=",idCardValue);
	BaseinfoPeopleDataSet.load();
	BaseinfoPeopleDataSet.on('load',func_QueryCheck);
	
}
function func_QueryCheck(BaseinfoPeopleDataSet){
	if(BaseinfoPeopleDataSet.getCount()==1){

	       if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1'){
	           L5.Msg.alert("提示", "该人员已经是伤残人员!");
	           document.forms[0].reset();
	           return false;
	       }
        if(BaseinfoPeopleDataSet.get("dependantFlag")=='1'){
	           L5.Msg.alert("提示", "该人员已经是三属人员!");
	           document.forms[0].reset();
	           return false;
	       }
       	    if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'){
	           L5.Msg.alert("提示", "该人员已经是在乡复员军人!");
	           document.forms[0].reset();
	           return false;
	       }
         if(BaseinfoPeopleDataSet.get("warFlag")=='1'){
	           L5.Msg.alert("提示", "该人员已经是参战参试人员!");
	           document.forms[0].reset();
	           return false;
	       }
   
       
    }else{
          BaseinfoPeopleDataSet.newRecord();
          BaseinfoPeopleDataSet.set("idCard",idCardValue);
          func_ShowBirthday();
    }
    
}

/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect(){
		var revalue=window.showModalDialog("../../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+ escape(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("domicileCode",list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("domicileName",list[4]);
		}
}

/**
 * 选择住址行政区划窗口
 */
function func_ForApanageSelect(){
		var revalue=window.showModalDialog("../../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+escape(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode",list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName",list[4]);
	}
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
