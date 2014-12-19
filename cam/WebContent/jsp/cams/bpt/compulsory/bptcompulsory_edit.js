function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
//		ds.baseParams["ID@="]=idField;
		ds.setParameter("id",idField);
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var records = ds.getAllChangedRecords();
	var domicileCode=document.getElementById("domicileCode").value;
	var conscriptDate = document.getElementById("conscriptDate").value;
	var birthday = document.getElementById("birthday").value;
	if(birthday!=''&&!validateDateFormat(birthday)){
		L5.Msg.alert('提示','出生日期格式不正确!');
		return false;
	}
	
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert('提示','入伍时间格式不正确!');
		return false;
	}
//	alert(domicileCode);
//	records.set("domicileCode",domicileCode);
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	records[0].set("domicileCode",domicileCode);
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		return false;
	}	
	
	
//    var records = ds.getAllChangedRecords();
	
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryCommand"); 
	command.setParameter("records",records);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/bpt/compulsory/bptcompulsory_list.jsp';
		var text = 'BPT_COMPULSORY';
		L5.forward(url,text);	 
 }

/*
 * 通用帮助--行政区划
 */
function forHelp(){
	var revalue=window.showModalDialog("../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+organName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		ds.getCurrent().set("domicileCode",document.getElementById("domicileCode").value);
		}
}

//由身份证自动生成出生日期
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
           ds.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           ds.getCurrent().set("birthday",birthdayValue);
   } 
}

//验证身份证合法性
function queryIdCard(){ 
	var idCard =document.forms[0].idCard;
	
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
}

