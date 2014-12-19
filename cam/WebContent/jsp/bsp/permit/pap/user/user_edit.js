var oldEmployeeId = "";
var methodFlag="";
var o_accountStatus="";

/*
 * 初始化
 */
function init(){
	if(delwith=="null")delwith="";
	if(delwith!=""){
		L5.getCmp("allPanel").hide();
	}else{
		var userDataset = L5.DatasetMgr.lookup("userDataset");
		L5.DatasetMgr.lookup("userTypeDataSet").load();
		if(method=='INSERT'){
			userDataset.newRecord({"userTypeId":"00","corporationId":corpId,"departmentId":deptId});
		}else if (method=="UPDATE"){
			document.getElementById("userIdTxt").disabled="disabled";
			loadUser(idField);
		} else{
			L5.Msg.alert(RES_PROMOT,RES_UNKOWN_CMD);
			return;
		}

		L5.QuickTips.init();

		var rolePanel=L5.getCmp("roleEditPanel");
		rolePanel.on("beforebinding", initGrantRole);

		var tabpanel = L5.getCmp("tabPanels");
		tabpanel.on("tabchange", loadUserDataRef);

        loadUserExt();

        var datatypecodecombox=L5.getCmp("datatypecodecombobox");
        datatypecodecombox.on("select",onSelectDataTypeCode);

        var scopetypecombox=L5.getCmp("scopetypecombox");
        scopetypecombox.on("select",onSelectScopeType);
	}
}

function loadUser(userid){
	var command=new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
	command.setParameter("USER_ID", userid);
	command.execute("getUser");
	if(!command.error){
		L5.getCmp("tabPanels").setActiveTab(0);
		oldEmployeeId = userDataset.getCurrent().get("employeeId");
		document.getElementById("o_passWord").value = userDataset.getCurrent().get("passWord");
		o_accountStatus = userDataset.getCurrent().get("accountStatus");
	}
	if(o_accountStatus=="11"){
	  document.getElementById("isOpened").checked=true;
	}else{
	  document.getElementById("isLocked").checked=true;
	}
	//移除用户数据权限
	dataPermitDataset.removeAll();
	isInit = false;
}

var isInit = false;
function loadUserDataRef(tabpanels, tab){
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isInit == false){
		if(tab.id == "dataPermitPanel"){
			var currentRcd = userDataset.getCurrent();
			if( currentRcd === undefined){
				return;
			}
			var userid= currentRcd.get("userId");
			if(userid!=""){//新增用户时，不加载数据权限
				dataPermitDataset.setParameter("USER_ID@=", userDataset.getCurrent().get("userId"));
				dataPermitDataset.load();
				isInit = true;
			}
		}
	}
}

/**
*当数据类型下拉框选项被选中的时候触发事件，根据数据类型相应地设置是否默认下拉框的选项
（两个下拉框的联动）
*/
function onSelectDataTypeCode(combo,record,index){
   var selected=record.get("dataTypeCode");
   var dataPermitDataset=L5.DatasetMgr.lookup("dataPermitDataset");
   var recordIndex=dataPermitDataset.find("dataTypeCode",selected,0);
   var isdefaultcombobox=L5.getCmp("isdefaultcombobox");
   if(recordIndex==-1){//如果新增加的数据类型在列表中还不存在，则设置默认值为：是：1
        dataPermitDataset.getCurrent().set("isDefault","1");
   }else{ //否则，设置默认值：否：0
      dataPermitDataset.getCurrent().set("isDefault","0");
   }
}

/*
 * 设置状态
 */
function setState(userRecord){
	var isSys = document.getElementById("isSys");
	var isUseIP = document.getElementById("isUseIP");
	if(isSys.checked){
		userRecord.set("isSys","1");
	}else{
		userRecord.set("isSys","0");
	}

	if(isUseIP.checked){
		userRecord.set("isUseIP","1");
	}else{
		userRecord.set("isUseIP","0");
	}

}

/*
 * 检验必填项
 */
function validate(){
	//
	var userId = document.getElementById("userIdTxt").value;
	if(userId==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_USERID+alert_not_null);
		return false;
	}
	//
	var userName = document.getElementById("userName").value;
	if(userName==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_USERNAME+alert_not_null);
		return false;
	}
	//
	var passWord = document.getElementById("passWord").value;
	if(passWord==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_PASSWORD+alert_not_null);
		return false;
	}
	//
	var passwordConfirm = document.getElementById("passwordConfirm").value;
	if(passwordConfirm==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_PASSWORDCONFIRM+alert_not_null);
		return false;
	}

    if(passWord!==""&&passwordConfirm!==""&&passWord!==passwordConfirm){
      L5.MessageBox.alert(RES_PROMOT,"请保证确认密码与密码一致");
		return false;
    }

	var maxSessionNumber = document.getElementById("maxSessionNumber").value;
	if(maxSessionNumber!=''&&maxSessionNumber.length>10){
		L5.MessageBox.alert(RES_PROMOT,"最大会话数过长");
		return false;
	}

	var userDataPermitRecords = dataPermitDataset.getAllChangedRecords();
	for(var i=0;i<userDataPermitRecords.length;i++){
		var record=userDataPermitRecords[i];
		if(record.get("dataTypeCode")==''){
			L5.MessageBox.alert(RES_PROMOT,"要增加的组织权限中组织类型不能为空");
			return false;
		}
		if(record.get('objectValue')==''){
			L5.MessageBox.alert(RES_PROMOT,"要增加的组织权限中组织机构不能为空");
			return false;
		}
		var startTime=record.get("startTime");
		var endTime=record.get("endTime");
		if(startTime>endTime){
			L5.MessageBox.alert(RES_PROMOT,"生效时间不能晚于过期时间");
			return false;
		}
	}



	return true;
}

/*
 * 点击保存按钮
 */
function save_click(){
	if(!validate()){
		return false;
	}
	//对是否默认数据权限进行校验，有且仅有一个某种类型的数据权限为默认
	var validMsg=validate_default();
	if(validMsg!=null){
		L5.Msg.alert('提示',validMsg);
		return false;
	}
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("usertree");
	var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
	var userDataset = L5.DatasetMgr.lookup("userDataset");
	var userRecord = userDataset.getCurrent();
	var userDataPermitRecords = dataPermitDataset.getAllChangedRecords();

	setState(userRecord);
	command.setParameter("record",userRecord);
	var maxSessionNumber=userRecord.get("maxSessionNumber");
	var valid_seq_reg=/^[0-9]+$/;
    if(maxSessionNumber!=undefined&&maxSessionNumber!==""&&!maxSessionNumber.match( valid_seq_reg)&&maxSessionNumber!=-1){
    	L5.MessageBox.alert("提示",'最大会话数只能输入数字');
		return;
    }
    var ipPolicyValue=userRecord.get("ipPolicyValue");
	if(ipPolicyValue!=undefined&&ipPolicyValue!=null&&ipPolicyValue!=""&&ipPolicyValue.length>60){
		L5.MessageBox.alert("提示",'IP策略值不能超过60个字母或汉字');
		return;
	}
	//新增管理员用户，默认添加所属部门和所属公司的数据权限
	if(userRecord.get("isSys") == "1" && method == "INSERT" && tree){
		var node = tree.getNodeByRecordId(struId, "struRecord");
		var struIds = new Array();
		var organIds = new Array();
		var organTypes = new Array();
		struIds.push(node.record.get("struId"));
		organIds.push(node.record.get("organId"));
		organTypes.push(node.record.get("organType"));
		//查找所属单位
		while(node.record.get("organType").substr(0,1) != "1" && node.parentNode){
			node = node.parentNode;
		}
		struIds.push(node.record.get("struId"));
		organIds.push(node.record.get("organId"));
		organTypes.push(node.record.get("organType"));
		command.setParameter("struIds", struIds);
		command.setParameter("organIds", organIds);
		command.setParameter("organTypes", organTypes);
	}

	var tempUserDataPermitRecord;
	for(var i=0; i<userDataPermitRecords.length; i++){
		tempUserDataPermitRecord = userDataPermitRecords[i];
		for(var j=i+1; j<userDataPermitRecords.length; j++){
			if(tempUserDataPermitRecord.get("objectName") == userDataPermitRecords[j].get("objectName") &&
					tempUserDataPermitRecord.state == 1 && userDataPermitRecords[j].state == 1){
				L5.Msg.alert("提示","新增记录中有重复记录");
				return;
			}
		}
	}

	command.setParameter("userDataPermitRecords", userDataPermitRecords);

	// 处理角色分配
	var assignedRoleDs=L5.DatasetMgr.lookup("assignedRoleDs");
	if(assignedRoleDs!=null&&assignedRoleDs!=undefined){
	var changedRecs = assignedRoleDs.getAllChangedRecords();
	var changedRoleIds=new Array();
	var addRcds=new Array();
    var delRcds=new Array();
    for(var i=0;i<changedRecs.length;i++){
       var rec=changedRecs[i];
       var roleId=rec.get("roleId");
       changedRoleIds.push(roleId);
 	    if(rec.state=="1"){//新增的
         	addRcds.push(rec);
         }
         if(rec.state=="2"){//新增的
           	delRcds.push(rec);
       }
      }
    command.setParameter("changedRoleIds",changedRoleIds);
    command.setParameter("addRcds",addRcds);
    command.setParameter("delRcds",delRcds);
 }
	if(methodFlag!=""){
		method="UPDATE";
	}
	var msg=setUserExtParameter(command);
	if(msg!==true){
	    return false;
	}
	//新增
	if(method=='INSERT'){
		command.execute("addEmployeeUser");
	}
	//修改
	if(method=='UPDATE'){
		var o_passWord = document.getElementById("o_passWord").value;
		command.setParameter("o_passWord",o_passWord);
		command.setParameter("o_employeeId",oldEmployeeId);
		command.setParameter("o_accountStatus",o_accountStatus);
		command.execute("updateUser");
	}
	if (!command.error) {
		dataPermitDataset.commitChanges();
		assignedRoleDs.commitChanges();
		L5.MessageBox.alert(RES_PROMOT,RES_SAVE);
		if(tree){
			if(method=="INSERT"){
				//新增节点需要在上级节点下同步添加一条记录
				var node = tree.getNodeByRecordId(struId, "struRecord");
				if(caseSensitive == "false"){
					var userId = userDataset.getCurrent().get("userId");
					userDataset.getCurrent().set("userId", userId.toUpperCase());
				}
				var rec = new parentWin.L5.tree.TreeRecord.recordTypes["userRecord"](userDataset.getCurrent().data, userDataset.getCurrent().get("userId"));
				node.record.insert(rec);
			}else if (method=="UPDATE"){
				//修改节点只需要更改树中显示名称，其余不需要同步,从用户查询页面进入的编辑页面，不刷新树，因为此时树节点未展开，没有对应的record
				if(queryEdit!="queryEdit"){
					var node = tree.getNodeByRecordId(userDataset.getCurrent().get("userId"), "userRecord");
					node.record.set("userName", userDataset.getCurrent().get("userName"));
					node.record.commit();
				}
			}

		}
		methodFlag="UPDATE";
		document.getElementById("userIdTxt").disabled="disabled";
		//document.getElementById("password").disabled="disabled";
		//document.getElementById("passwordConfirm").disabled="disabled";
	}else{
		L5.MessageBox.alert(RES_PROMOT,command.error);
	}
}

/*
 * 点击取消按钮
 */
function undo_click(){
	var userDataset = L5.DatasetMgr.lookup("userDataset");
	userDataset.rejectChanges();
	dataPermitDataset.rejectChanges();
	if (method=="INSERT"||userDataset.getCurrent()==undefined){
		userDataset.newRecord({"userTypeId":"00","corporationId":corpId,"departmentId":deptId});
	}
}

/*
 * 密码验证
 */
function ValidatePwd(src){
	/**
	 * 山东民政要求添加密码长度校验，密码长度不能小于6位
	 */
	if(src.value.length<6){
		L5.MessageBox.alert("提示","密码长度不能小于6位！");
		src.value="";
		return;
	}
//	alert(src.value);
	var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
	command.setParameter("password",src.value);
	//	if(method=='INSERT'){
		command.setParameter("method","insert");
	//}
	command.execute("validatePwd");
	//alert(src.value);
	if (!command.error) {

	}else{
		L5.MessageBox.alert(RES_PROMOT,command.error);
		src.value="";
	}
}

function initGrantRole(){
	var ds=L5.DatasetMgr.lookup("ableRolesDataset");
	ds.setParameter("TARGET",idField);
    ds.load();
    var assignedRoleDs=L5.DatasetMgr.lookup("assignedRoleDs");
     assignedRoleDs.setParameter("TARGET",idField);
    assignedRoleDs.load();
	new L5.ux.ItemSelector({
		field:"grantedRoles",
		applyTo:"grantRoleDiv",
		id:"grantRolecmp",
		name:"grantedRoles",
		fromDataset:ds,
		toDataset:assignedRoleDs,
		valueField:"roleId",
		displayField:"roleName",
	    msWidth:245,
	    msHeight:460,
	    toLegend:"已授予角色",
	    fromLegend:"未授予角色",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
}

//新增一条数据权限
function addDataRef(){
	dataPermitDataset.newRecord({"userId":userDataset.getCurrent().get("userId"),
		"scopeType":"0","startTime":"20000101 00:00:00","endTime":"99991231 23:59:59"});
}

//删除一条数据权限
function removeDataRef(){
	//获取grid对象
	var datPermitEditPanel = L5.getCmp('datPermitEditPanel');
	//停止grid的编辑状态
	datPermitEditPanel.stopEditing();
	//获取grid的选择模型并从选择模型里获取选中单元格
	var selected = datPermitEditPanel.getSelectionModel().getSelections();
	if (selected.length>0) {
		//获取对应的record对象并删除
		for(var i=0;i<selected.length;i++){
			var record=selected[i];
			dataPermitDataset.remove(record);
		}
	}else{
		L5.MessageBox.alert(RES_PROMOT,'没有选择记录');
	}
}
function query(){
	var datatype=document.getElementById("datatype").value;
	var objectvalue=document.getElementById("objectvalue").value;
	dataPermitDataset.setParameter("USER_ID@=", userDataset.getCurrent().get("userId"));
	//如果没有值就设为undifined对应java的null
	if(datatype == ""){
		datatype=undefined;
	}
	//设置参数值,用@分开的两段：前面是参数名,后面是比较符号
	dataPermitDataset.setParameter("DATA_TYPE_CODE@=", datatype);

	if(objectvalue == ""){
		objectvalue = undefined;
	}
	dataPermitDataset.setParameter("OBJECT_VALUE@=", objectvalue);
	// 加载数据
	dataPermitDataset.load();
}

/*
 * 选择员工
 */
function selectEmployee(){
	var revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId="+struId+
	"&showOrganType=0&organType=8&isExact=0&isCheckBox=0&isTree=1&userId="+idField,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue){
		var list = revalue.split(";");
		var userDataset = L5.DatasetMgr.lookup("userDataset");
		var userRecord = userDataset.getCurrent();
		userRecord.set("userName",list[1]);
		userRecord.set("employeeName",list[1]);
		userRecord.set("employeeId",list[2]);
		userRecord.set("corporationId",list[5]);
		userRecord.set("departmentId",list[3]);
		userRecord.set("departmentName",list[4]);
		userRecord.set("corporationName",list[6]);
	}
}

/*
 * 验证确认密码
 */
function ValidatePwdConfirm(src){
	var value = document.getElementById("passWord").value;
	var c_password=document.getElementById("passwordConfirm");
	var re_password = document.forms[0].passwordConfirm;
	if(value!=src.value){
		src.value="";
		L5.MessageBox.alert(RES_PROMOT,alert_pwd);
	}

}

//选择数据权限数据。如果数据类型为组织机构，弹出组织机构通用帮助；否则根据数据类型弹出选择数据通用帮助
function onSelectObjectValue(){
	var command=new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
	var record = dataPermitDataset.getCurrent();
	var userId=userDataset.getCurrent().get("userId")
	var dataType = record.get("dataTypeCode");
	if(dataType == null || dataType == ""){
		L5.Msg.alert("提示","请先选择组织类型");
		return;
	}
	var dataTypeRecord = dataTypeDataset.getById(dataType);
	L5.getCmp('datPermitEditPanel').stopEditing();
	if(dataTypeRecord.get("isOrgan") === "1"){
		//设置组织机构通用帮助显示的组织类型
		var showOrganType = "0";
		if(dataType.substr(0,1)=="1"){
			showOrganType = "1";
		}else if(dataType.substr(0,1)=="2"){
			showOrganType = "1,2";
		}else if(dataType.substr(0,1)=="6"){
			showOrganType = "1,2,6";
		}else if(dataType.substr(0,1)=="8"){
			showOrganType = "1,2,6,8";
		}
        var url="../../../organization/getselect.jsp?rootId=rootId&showOrganType="+showOrganType+"&organType="
		+ dataType+"&isExact=0&isCheckBox=1&isTree=1";
        command.setParameter("userId",loginUserId);
        command.execute("isSuperadmin");
        var isSuperadmin=command.getReturn("isSuperadmin");
        if(isSuperadmin!=null&&isSuperadmin!="true"){//如果不是超级管理员，进行权限过滤
        	url+="&userId="+loginUserId;
        }
		var revalue=window.showModalDialog(url,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue){
			var values = revalue.split(";");
			var objectValues=values[0].split(",");
			var objectNames=values[1].split(",");
			var struIds=values[2].split(",");
			if(objectValues.length==1){
				record.set("objectValue", values[0]);
				record.set("objectName", values[1]);
				record.set("struId", values[2]);
			}else{
				record.set("objectValue", objectValues[0]);
				record.set("objectName", objectNames[0]);
				record.set("struId", struIds[0]);
			  	for(var i=1;i<objectValues.length;i++){
			  		var newRecord=dataPermitDataset.newRecord({"userId":userId,
			  			"scopeType":"0","startTime":"20000101 00:00:00","endTime":"99991231 23:59:59"});
//			  		dataPermitDataset.newRecord({"userId":userId,"scopeType":"0","objectValue":objectValues[i],"dataTypeCode":dataType,
//			  			"isDefault":0,"objectName":objectNames[i],"struId":struIds[i],"startTime":"20000101 00:00:00","endTime":"99991231 23:59:59"});
			  		newRecord.set("scopeType", "0");
			  		newRecord.set("dataTypeCode", dataType);
			  		newRecord.set("isDefault", "0");
			  		newRecord.set("objectValue", objectValues[i]);
			  		newRecord.set("objectName", objectNames[i]);
			  		newRecord.set("struId", struIds[i]);
			  	}
			}

		}
	} else if(dataTypeRecord.get("isOrgan") === "0"){ //非组织结构类型的数据权限
		var revalue = window.showModalDialog("selectobjectvalue.jsp?dataType="+dataType,"","dialogHeight:450px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue){
			var values = revalue.split(";");
			record.set("objectValue", values[0]);
			record.set("objectName",values[1]);
		}
	}

}

//选择数据权限适用范围。如果适用范围类型为“全局”，不弹出通用帮助；如果为角色，弹出选择角色通用帮助；否则弹出功能树通用帮助
function onSelectScopeValue(){
    L5.getCmp('datPermitEditPanel').stopEditing();
	var record = dataPermitDataset.getCurrent();
	if(record.get("scopeType") === "0"){
		return "";
	}
	var revalue;
	if(record.get("scopeType") === "5"){
		revalue = window.showModalDialog("../role/select_role.jsp","","dialogHeight:490px;dialogWidth:350px;resizable:no;scroll:yes;");
	} else {
		revalue = window.showModalDialog("../function/select_function.jsp?showType="+record.get("scopeType"),"","dialogHeight:490px;dialogWidth:350px;resizable:no;scroll:yes;");
	}
	if(revalue){
		var values = revalue.split(";");
		record.set("scopeValue", values[0]);
		record.set("scopeName", values[1]);
	}
}

//判断是否可以选择数据权限适用范围。如果适用范围类型为“全局”，不弹出通用帮助
function ableSelectScopeValue(){
	var record = dataPermitDataset.getCurrent();
	if(record.get("scopeType") === "0"){
	L5.MessageBox.alert(RES_PROMOT,'适用范围类型为全局的，不提供范围值的选择！');
		return false;
	}
	return true;
}

//选择数据权限数据(查询条件)
function forHelpObjectValue(){
	var datatypeCode=document.getElementById("datatype").value;
	if(datatypeCode === ""){
		document.getElementById("objectvalue").value = "";
		L5.MessageBox.alert(RES_PROMOT,'请选择数据类型');
		return;
	}
	var dataTypeRecord = dataTypeDataset.getById(datatypeCode);
	var revalue;

	if(dataTypeRecord.get("isOrgan") === "1"){
		//设置组织机构通用帮助显示的组织类型
		var showOrganType = "0";
		if(datatypeCode.substr(0,1)=="1"){
			showOrganType = "1";
		}else if(datatypeCode.substr(0,1)=="2"){
			showOrganType = "1,2";
		}else if(datatypeCode.substr(0,1)=="6"){
			showOrganType = "1,2,6";
		}else if(datatypeCode.substr(0,1)=="8"){
			showOrganType = "1,2,6,8";
		}

		revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType="+showOrganType+"&organType="
				+ datatypeCode +"&isExact=0&isCheckBox=0&isTree=1&userId="+loginUserId,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	} else if(dataTypeRecord.get("isOrgan") === "0"){ //非组织结构类型
		revalue = window.showModalDialog("selectobjectvalue.jsp?dataTypeRecord="+L5.encode(dataTypeRecord),"","dialogHeight:360px;dialogWidth:450px;resizable:no;scroll:yes;");
	}
	if(revalue){
		var values = revalue.split(";");
		document.getElementById("objectvalue").value = values[0];
		document.getElementById("objectname").value = values[1];
	}
//	else {
//		document.getElementById("objectvalue").value = "";
//		document.getElementById("objectname").value = "";
//	}
}

//选择数据权限适用范围(查询条件)
function forHelpScopeValue(){
	var scopeType=document.getElementById("scopetype").value;
	if(scopeType =="0"){//全局不需要选择
		L5.MessageBox.alert(RES_PROMOT,'适用范围类型为全局的，不提供范围值的选择！');
		return;
	}
	if(scopeType == "" ){
		document.getElementById("scopevalue").value = "";
		L5.MessageBox.alert(RES_PROMOT,'请选择适用范围类型');
		return;
	}
	var revalue;
	if(scopeType == "5"){
		revalue = window.showModalDialog("../role/select_role.jsp?","","dialogHeight:490px;dialogWidth:350px;resizable:no;scroll:yes;");
	} else {
		revalue = window.showModalDialog("../function/select_function.jsp?showType="+scopeType,"","dialogHeight:490px;dialogWidth:350px;resizable:no;scroll:yes;");
	}
	if(revalue){
		var values = revalue.split(";");
		document.getElementById("scopevalue").value = values[0];
		document.getElementById("scopename").value = values[1];
	}else {
		document.getElementById("scopevalue").value = "";
		document.getElementById("scopename").value = "";
	}
}

/*
 * 某种类型的数据权限是否为默认值只能有一个为是
 */
function validate_default(){
	var datPermitEditPanel=L5.getCmp('datPermitEditPanel');
	var count=dataPermitDataset.getCount();
	for(var i=0;i<count;i++){
		var k=0;
		for(var j=0;j<count;j++){
			var tempType=L5.isIE?datPermitEditPanel.getView().getCell(i,1).innerText:datPermitEditPanel.getView().getCell(i,1).textContent;
			var type=L5.isIE?datPermitEditPanel.getView().getCell(j,1).innerText:datPermitEditPanel.getView().getCell(j,1).textContent;
			if(tempType==type){
				var sys_default=L5.isIE?datPermitEditPanel.getView().getCell(j,3).innerText:datPermitEditPanel.getView().getCell(j,3).textContent;
				if(sys_default=="是"){
					k++;
				}
			}
		}
		if(k>1 || k==0){
			return "某种类型的数据权限，有且仅有一个为默认";
		}

	}

}

function onSelectScopeType(combo,index) {
	var scopeType=combo.value;
	var record = dataPermitDataset.getCurrent();
	if(scopeType==0){
		record.set("scopeValue", "");
		record.set("scopeName", "");
	}
}

function getValue(value){
  //document.getElementById("isLocked").value=
  value="10";
}

function onchecked(ele){
	var userDataset = L5.DatasetMgr.lookup("userDataset");
	var rcd = userDataset.getCurrent();
	var checkbox = document.getElementById('isUseIP');
	if(ele.checked){
		rcd.set('isUseIP',"1");
		document.getElementById('ipPolicyValue').style.display = "";
		document.getElementById('iplable').style.display = "";
		document.getElementById('ipvalueinput').style.display = "";
	}else if(!ele.checked){
		rcd.set('isUseIP',"0");
		document.getElementById('ipPolicyValue').style.display = "none";
		document.getElementById('iplable').style.display = "none";
		document.getElementById('ipvalueinput').style.display = "none";
	}
}