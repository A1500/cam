function init(){
	if(method=="INSERT"){//新增
		var parent=window.dialogArguments;
		var ds=parent.familyDataSet;
		peopleListDataSet.newRecord({'familyId':familyId,'peopleId':peopleId,'nation':'01','sex':'2','disabilityLevelCode':'00'
		,"apanageName":ds.get("apanageName"),"apanageCode":ds.get("apanageCode"),"idCardType":"0"});
	}
	else if(method=="INSERTHUZHU"){//新增户主
		var parent=window.dialogArguments;
		var ds=parent.familyDataSet;
		var cardNo=ds.get("familyCardNo")
		//alert(familyId);
		var birth=cardNo.substr(6,4)+"-"+cardNo.substr(10,2)+"-"+cardNo.substr(12,2);
		peopleListDataSet.newRecord({"familyId":familyId,"peopleId":peopleId,'relationshipType':'01',
		'name':ds.get("familyName"),'idCard':ds.get("familyCardNo"),"birthday":birth,'disabilityLevelCode':'00',
		"nation":ds.get("nation"),"sex":ds.get("sex"),"apanageName":ds.get("apanageName"),"apanageCode":ds.get("apanageCode"),"idCardType":"0"});
		//document.getElementById('relationshipType').value='01';
		document.getElementById('relationshipType').disabled='disabled';
		
	}
	else if(method=="UPDATE"){//修改
		//编辑家庭成员信息的话只需要peopleId,即可
		//peopleListDataSet.setParameter("FAMILY_ID",familyId);
		document.getElementById("name").disabled=true;
		document.getElementById("birthday").disabled=true;
		document.getElementById("relationshipType").disabled=true;
		document.getElementById("idCard").disabled=true;
		
		peopleListDataSet.setParameter("PEOPLE_ID",peopleId);
		peopleListDataSet.on("load",checkRelationShip);
		peopleListDataSet.load();
		
	}
}

function checkRelationShip(ds){
	var relationShip = ds.get("relationshipType");
	if(relationShip=="01"){
		document.getElementById('relationshipType').disabled='disabled';
	}
}
function confirmPeople(){
	//savePeopleInfo();
	var ds = L5.DatasetMgr.lookup("peopleListDataSet");
	var lowSupportRecord= ds.getCurrent();
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmCmd");
	var record = peopleListDataSet.getCurrent();
	
	command.setParameter("peopleRecord",record);
	if(method=="INSERT"||method=="INSERTHUZHU"){//新增
		command.execute("insertPeople");
	}
	else if(method=="UPDATE"){//修改
		command.execute("updatePeople");
	}
	if (!command.error) {
		//L5.Msg.alert("提示","保存成功！");
		saveSuccessAlert();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}	
}
//保存成功的提示信息
function saveSuccessAlert(){
	if(peopleId==''||peopleId=='null'){
		/**L5.MessageBox.confirm('提示','保存成功！是否继续添加家庭人员？',function(state){
			if(state=="yes"){					
				//刷新父窗口
				confirmClosePeople();
				//继续添加成员
				goOnInsert();
			}else{
				//关闭窗口
				window.close();
				//刷新父窗口
				confirmClosePeople();				
			}
		});*/		
		//刷新父窗口
		confirmClosePeople();
		window.close();
		
	}else{
		L5.Msg.alert("提示","保存成功！",function(){				
			confirmClosePeople();
			window.close();
		});	
	}	
}
//继续添加成员,功能不是很好，待完善
function goOnInsert(){
	method="INSERT";
	document.getElementById('relationshipType').disabled='';
	init();
}
//刷新父窗口
function confirmClosePeople(){
	
}


function closePeople(){
	window.close();
}
/***
function isdisablity(obj){
	var value=obj.value;
	if(value=="40"){//重病
		document.getElementById("disabilityLevel").disabled="";
	}else{
		document.getElementById("disabilityLevel").disabled="disabled";
	}
}
*/
//获取重病病种
function getDiseaseType(){
	var healthCode=document.getElementById('healthCode').value;
	var diseaseType=document.getElementById('diseaseType');
	if(healthCode=='40'){//重病
		diseaseType.disabled=false;
	}else{
		diseaseType.value='';
		diseaseType.disabled=true;
	}
}
//获取残疾等级
function getDisabilityLevel(){
	var disabilityType=document.getElementById('disabilityType').value;
	var disabilityLevel=document.getElementById('disabilityLevel');
	if(disabilityType!=''){
		disabilityLevel.disabled=false;
	}else{
		disabilityLevel.value='';
		disabilityLevel.disabled=true;
	}
}
function iswork(obj){
	var value=obj.value;
	if(value=="11"||value=="12"||value=="13"){//
		document.getElementById("workUnitCharacter").disabled="";
	}else{
		document.getElementById("workUnitCharacter").disabled="disabled";
		peopleListDataSet.set("workUnitCharacter","00");
	}
}
function getBirthday(cardNo){
	var birth =cardNo.substr(6,4)+"-"+cardNo.substr(10,2)+"-"+cardNo.substr(12,2);
	peopleListDataSet.set("birthday",birth);
}
function calcPro(){
	var bondProperty=document.getElementById("bondProperty").value;
	if(bondProperty==""){
		bondProperty=0;
	}
	var bankStockProperty=document.getElementById("bankStockProperty").value;
	if(bankStockProperty==""){
		bankStockProperty=0;
	}
	var otherProperty=document.getElementById("otherProperty").value;
	if(otherProperty==""){
		otherProperty=0;
	}
	var total = parseFloat(bondProperty)+parseFloat(bankStockProperty)+parseFloat(otherProperty);
	document.getElementById("totalProperty").innerHTML=total;
}
function calcInc(){
	var salaryIncome=document.getElementById("salaryIncome").value;
	if(salaryIncome==""){
		salaryIncome=0;
	}
	var manageIncome=document.getElementById("manageIncome").value;
	if(manageIncome==""){
		manageIncome=0;
	}
	var propertyIncome=document.getElementById("propertyIncome").value;
	if(propertyIncome==""){
		propertyIncome=0;
	}
	var transferIncome=document.getElementById("transferIncome").value;
	if(transferIncome==""){
		transferIncome=0;
	}
	var otherIncome=document.getElementById("otherIncome").value;
	if(otherIncome==""){
		otherIncome=0;
	}
	var total = parseFloat(salaryIncome)+parseFloat(manageIncome)+parseFloat(propertyIncome)+parseFloat(transferIncome)+parseFloat(otherIncome);
	document.getElementById("toalIncome").innerHTML=total;
}

