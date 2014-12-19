var deptName ;
var deptId;
function init() {
	//alert(organId);
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginId ="";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
		  userLoginId =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
	}
	var commDeptId = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	commDeptId.setParameter("loginId",userLoginId);
	commDeptId.execute("getDeptId");
	 deptId = commDeptId.getReturn("deptId");
	 deptName = commDeptId.getReturn("deptName");
	 //alert(deptId);
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}else if (method=="INSERT"){
		//新增时，隐藏职务信息
		var personTab=L5.getCmp('personTabPanel');
		personTab.remove(personTab.getComponent(1));
		ds.newRecord();
		document.getElementById("deptId").value = deptId;
		document.getElementById("deptName").value = deptName;
	}else if (method=="UPDATE"){
		ds.baseParams["PERSON_ID@="]=idField;
		ds.load();
		ds.on("load",function(personDs){
			loadPhoto(personDs.get("photo"));
			loadQm(personDs.get("qmName"));
		});
		dsPosition.baseParams["PERSON_ID@="]=idField;
		dsPosition.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	updateAll();
	L5.QuickTips.init(); 
}

// 根据登录帐号进行判断，省厅角色还是登记处角色，如果是登记处角色则不可以修改
function updateAll() {
	if (organCode.substring(2, 12) == "0000000000") {
		if (deptId == "" || deptId == null) {
			// ds.newRecord();
			return false;
		}
	}else{
		document.getElementById("certificateId").disabled = true;
		document.getElementById("computerType").disabled = true;
		document.getElementById("firstcard").disabled = true;
		document.getElementById("bzyzgzh").disabled = true;
		document.getElementById("djfwtype").disabled = true;
	}

}
//加载照片
function loadPhoto(photoId){
	var src = rootPath+"download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
	$("photoDiv").innerHTML="";
	$("photoDiv").innerHTML="<img id=\"img\" name=\"RELATIONER_PHOTOC_IMG\" width=82.5 height=110 src="+src+" align=\"top\" ondblclick=\"editPhoto(1,\'photo\',\'RELATIONER_PHOTOC_IMG\');\"	onerror=\"javascript:this.src=\'"+rootPath+"/jsp/cams/marry/image/default.jpg\'\" alt=\"暂无图片\" /><input type=\"hidden\" id=\"photo\" name=\"photo\"/>";
}
//加载签名
function loadQm(photoId){
	var src = rootPath+"download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
	$("qmDiv").innerHTML="";
	$("qmDiv").innerHTML="<img id=\"img1\" name=\"RELATIONER_PHOTOC_IMG1\" width=144 height=44 src="+src+" align=\"top\" ondblclick=\"editPhoto(4,\'qmName\',\'RELATIONER_PHOTOC_IMG1\');\"	onerror=\"javascript:this.src=\'"+rootPath+"/jsp/cams/marry/image/qianming.jpg\'\" alt=\"暂无图片\" /><input type=\"hidden\" id=\"qmName\" name=\"qmName\"/>";
}
function savePerson(){
	var records = ds.getAllChangedRecords();
	
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验

	if(document.getElementById("name").value == ''){
		L5.Msg.alert('提示',"姓名不能为空!");
		return false;
	}
	if(document.getElementById("cardNo").value == ''){
		L5.Msg.alert('提示',"身份证件号码不能为空!");
		return false;
	}
	if(document.getElementById("sex").value == ''){
		L5.Msg.alert('提示',"性别不能为空!");
		return false;
	}
	if(document.getElementById("birthDate").value == ''){
		L5.Msg.alert('提示',"出生日期不能为空!");
		return false;
	}
	if(document.getElementById("nation").value == ''){
		L5.Msg.alert('提示',"民族不能为空!");
		return false;
	}
	if(document.getElementById("kind").value == ''){
		L5.Msg.alert('提示',"人员性质不能为空!");
		return false;
	}
	if(document.getElementById("workstate").value == ''){
		L5.Msg.alert('提示',"岗位状态不能为空!");
		return false;
	}
    var record = ds.getCurrent();
    record.set("deptName",deptName);
    //照片
	record.set("photoTemp",document.getElementById("photo").value);//封装照片
	record.set("qmTemp",document.getElementById("qmName").value);//封装签名
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand"); 
	command.setParameter("records",record);
	var personId = document.getElementById("personId").value;
	//var deptId = document.getElementById("deptId").value;
	//var deptName = document.getElementById("deptName").value;
	command.setParameter("personId",personId);
//	alert(deptName);
//	command.setParameter("organId",organId);
	command.setParameter("deptId",deptId);
	command.setParameter("deptName",deptName);
	
	if(personId == ""){
		command.execute("insertPerson");
	}else{
		command.execute("update");
	}	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	//	back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//增加职务信息
function insertPosition() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	dsPosition.newRecord();
}

//删除职务信息
function delPosition() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("zwId");
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmPositionCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	dsPosition.remove(selected[i]);
				}
				dsPosition.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}

//保存职务信息
function savePosition() {
	
	var records = dsPosition.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = dsPosition.isValidate();
/*	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}*/
	var personId = document.getElementById("personId").value;
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmPositionCommand");
	command.setParameter("records", records);
	command.setParameter("personId",personId);
	command.execute("save");
	if (!command.error) {
		dsPosition.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//校验身份证
function func_CheckIdCard(){
	idCard =document.forms[0].cardNo;	
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
}

/*
*由身份证自动生成出生日期
*/
function func_ShowBirthDate() 
{ 
   var val=document.forms[0].cardNo.value;
   var birthdayValue; 
   if(15==val.length){ //15位身份证号码 
       birthdayValue = val.charAt(6)+val.charAt(7); 
       if(parseInt(birthdayValue)<10){ 
           birthdayValue = '20'+birthdayValue; 
       }else { 
           birthdayValue = '19'+birthdayValue; 
       } 
           birthdayValue=birthdayValue+'-'+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11);
           ds.getCurrent().set("birthDate",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           ds.getCurrent().set("birthDate",birthdayValue);
   } 
}

//取消职务信息
function resetPosition() {
	ds.rejectChanges();
}

 function back()
 {	window.close();
 /* 	
 	if(flag=='1'){	
 		var url='jsp/cams/marry/person/mrmbasepersonbzy_list.jsp';
		var text = '人员基本信息表';
		L5.forward(url,text);	 
	}else if(flag=='2'){
		var url='jsp/cams/marry/person/mrmPerson_query.jsp';
		var text = '婚姻登记员名册';
		L5.forward(url,text);
	}	 */
 }



