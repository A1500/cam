function init() {
	tabHide();
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.load();
	var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	BaseinfoFamilyDataSet.load();
}

//修改人员信息
function peopleUpdate(){
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
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

//修改家庭信息
function familyUpdate(){
	var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	var BaseinfoFamilyRecord=BaseinfoFamilyDataSet.getCurrent();
	
	var isValidate = BaseinfoFamilyDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
	
	command.setParameter("BaseinfoFamilyRecord", BaseinfoFamilyRecord);
	command.execute("updateFamily");
	
	if (!command.error) {
		BaseinfoFamilyDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function returnClick(){	
	var url='jsp/cams/bpt/disability/disabilityList.jsp';
	var text='基础信息_人员信息';
	L5.forward(url,text);	
}
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
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
          
   } 
}
function getDomicileCity(){
  var revalue=window.showModalDialog("../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+organName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
  if(revalue!=""&&revalue!=undefined){
     var list = revalue.split(";");
     document.getElementById("domicileCode").value = list[0];
     BaseinfoPeopleDataSet.getCurrent().set("domicileCode",document.getElementById("domicileCode").value);
     document.getElementById("domicileName").value = list[1];
   }
}
/**
 * 选择住址行政区划窗口
 */
function getApanageSelect(){
	var revalue=window.showModalDialog("../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+organName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("apanageCode").value = list[0];
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode",document.getElementById("apanageCode").value);
		document.getElementById("apanageName").value = list[1];
	}
}

/**
* 判断选项卡是否隐藏
*/
function tabHide(){
	var sortPanel = L5.getCmp("tabPanel");
	if(objectType == 11 || objectType == 12 || objectType == 13 || objectType == 14|| objectType == 15){//显示伤残类别
		for(var i = 0; i < 7; i++){
			sortPanel.remove(sortPanel.getComponent(2));
		}
	}else if(objectType == 21 || objectType == 22 || objectType == 23){//显示三属类别
		for(var i = 0; i < 7; i++){
			if(i < 1){
				sortPanel.remove(sortPanel.getComponent(1));
			}else{
				sortPanel.remove(sortPanel.getComponent(2));
			}
		}
	}else if(objectType == 41){//显示在乡复员类别
		for(var i = 0; i < 7; i++){
			if(i<2){
				sortPanel.remove(sortPanel.getComponent(1));
			}else{
				sortPanel.remove(sortPanel.getComponent(2));
			}
		}
	}else if(objectType == 42){//显示带病回乡类别
		for(var i = 0; i < 7; i++){
			if(i<3){
				sortPanel.remove(sortPanel.getComponent(1));
			}else{
				sortPanel.remove(sortPanel.getComponent(2));
			}
		}
	}else if(objectType == 51){//显示参战类别
		for(var i = 0; i < 7; i++){
			if(i<4){
				sortPanel.remove(sortPanel.getComponent(1));
			}else{
				sortPanel.remove(sortPanel.getComponent(2));
			}
		}
	}else if(objectType == 61){//显示参试类别
		for(var i = 0; i < 7; i++){
			if(i<5){
				sortPanel.remove(sortPanel.getComponent(1));
			}else{
				sortPanel.remove(sortPanel.getComponent(2));
			}
		}
	}else if(objectType == 81){//显示60周岁以上农村籍退役士兵
		for(var i = 0; i < 7; i++){
			if(i<6){
				sortPanel.remove(sortPanel.getComponent(1));
			}else{
				sortPanel.remove(sortPanel.getComponent(2));
			}
		}
	}else if(objectType == 'B1'){//显示老烈士子女
		for(var i = 0; i < 7; i++){
			sortPanel.remove(sortPanel.getComponent(1));
		}
	}
	
	if(objectState=="1"||objectState=="2"){
		sortPanel.remove(L5.getCmp("electronicDetailTabPanel"));
		
	}else {
		sortPanel.remove(L5.getCmp("electronicTabPanel"));
	}
}