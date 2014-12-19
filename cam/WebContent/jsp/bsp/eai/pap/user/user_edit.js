var oldEmployeeId = "";
var methodFlag="";
var o_accountStatus="";

function getParam(ElementId){
	var val=document.getElementById(ElementId).value;
	if(val=="") val=undefined;
	return val;
}
/*
 * 初始化
 */
function init(){
	if(delwith=="null")delwith="";
	if(delwith!=""){
		L5.getCmp("allPanel").hide();
	}else{
		var userDataset = L5.DatasetMgr.lookup("userDataset");
		var appUserDataset=L5.DatasetMgr.lookup("appUserDataset");
		if(method=='INSERT'){
			userDataset.newRecord({"userTypeId":"00","corporationId":corpId,"departmentId":deptId});
		}else if (method=="UPDATE"){
//			userDs.setParameter("USER_ID@=",idField);
//			userDs.load(true);
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
		tabpanel.on("tabchange", loadAppUser);
	}
}

function loadUser(userid){
	var command=new L5.Command("org.loushang.bsp.eai.pap.user.cmd.UserCmd");
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
	//移除用户映射
	appUserDataset.removeAll();
	isInit = false;
}
var isInit = false;
function loadAppUser(tabpanels, tab){
	//只有在初始化后切换到用户映射页面才加载
	if(isInit == false){
		if(tab.id == "appUserPanel"){
			var currentRcd = userDataset.getCurrent();
			if( currentRcd === undefined){
				return;
			}
			var userId= currentRcd.get("userId");
			if(userId!=""){
				appUserDataset.setParameter("USER_ID@=", userDataset.getCurrent().get("userId"));
				appUserDataset.load();
				isInit = true;
			}
		}
	}
}

//初始化双边栏
function initGrantRole(){
      var ableRolesDs=L5.DatasetMgr.lookup("ableRolesDs");
      ableRolesDs.setParameter("TARGET",idField);
      ableRolesDs.load(true);
      var assignedRoleDs=L5.DatasetMgr.lookup("assignedRoleDs");
     assignedRoleDs.setParameter("TARGET",idField);
      assignedRoleDs.load();
	 new L5.ux.ItemSelector({
		field:"grantedRoles",
		applyTo:"grantRoleDiv",
		id:"grantRolecmp",
		name:"grantedRoles",
		fromDataset:ableRolesDs,
		toDataset:assignedRoleDs,
		valueField:"roleId",
		displayField:"roleInfo",
	    msWidth:350,
	    msHeight:350,
	    toLegend:"已授予角色",
	    fromLegend:"未授予角色",
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	});
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
	var userId = document.getElementById("userIdTxt").value;
	if(userId==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_USERID+alert_not_null);
		return false;
	}
	var userName = document.getElementById("userName").value;
	if(userName==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_USERNAME+alert_not_null);
		return false;
	}
	var passWord = document.getElementById("passWord").value;
	if(passWord==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_PASSWORD+alert_not_null);
		return false;
	}
	var passwordConfirm = document.getElementById("passwordConfirm").value;
	if(passwordConfirm==''){
		L5.MessageBox.alert(RES_PROMOT,PUB_USER_PASSWORDCONFIRM+alert_not_null);
		return false;
	}
	var maxSessionNumber = document.getElementById("maxSessionNumber").value;
	if(maxSessionNumber!=''&&maxSessionNumber.length>10){
		L5.MessageBox.alert(RES_PROMOT,"最大会话数过长!");
		return false;
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
	var msg = appUserDataset.isValidate();
	if(msg !== true){
	  //if(msg.indexOf("certificate")==-1){
        L5.Msg.alert('提示',msg);
		return false;
	  //}
	}
	var parentWin = window.parent.window;
	var tree = parentWin.L5.getCmp("usertree");
	var command = new L5.Command("org.loushang.bsp.eai.pap.user.cmd.UserCmd");
	var userRecord = userDataset.getCurrent();
	var appUserRecords = appUserDataset.getAllChangedRecords();
	setState(userRecord);
	command.setParameter("record",userRecord);
	command.setParameter("appUserRecords", appUserRecords);
	
	var ds = L5.DatasetMgr.lookup("assignedRoleDs");
	//处理角色分配
	if(ds!=null&&ds!=undefined){
		var recs = ds.getAllChangedRecords();
	    var addRcds=new Array();
	    var delRcds=new Array();
	    var count=recs.length;
	    if(count>0){
	      for(var i=0;i<count;i++){
	    	  var rec=recs[i];
	    	  if(rec.state=="1"){//新增的
	            	addRcds.push(rec);
	            }
	            if(rec.state=="2"){//新增的
	              	delRcds.push(rec);
	          }	
	      }
	    }
	    command.setParameter("addRcds",addRcds);
	    command.setParameter("delRcds",delRcds);
	}
	if(methodFlag!=""){
		method="UPDATE";
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
		appUserDataset.commitChanges();
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
		document.getElementById("password").disabled="disabled";
		document.getElementById("passwordConfirm").disabled="disabled";
	}else{
		L5.MessageBox.alert(RES_PROMOT,command.error);
	}
}

/*
 * 密码验证
 */
function ValidatePwd(src){
//	alert(src.value);
	var command = new L5.Command("org.loushang.bsp.eai.pap.user.cmd.UserCmd");
	command.setParameter("password",src.value);
		command.setParameter("method","insert");
	command.execute("validatePwd");
	if (!command.error) {
	}else{
		L5.MessageBox.alert(RES_PROMOT,command.error);
		src.value="";
	}
}

//新增一条用户映射
function addAppUser(){
	appUserDataset.newRecord({"userId":userDataset.getCurrent().get("userId")});
}

//删除一条用户映射
function removeAppUser(){
	//获取grid对象
	var grid = L5.getCmp('appUserEditPanel');
	//获取grid的选择模型并从选择模型里获取选中单元格
	var sm = grid.getSelectionModel();
	var cell = sm.getSelections();
	var len=cell.length;
	if (len>0) {
		//获取对应的record对象并删除
	  for(var i=0;i<len;i++ ){
		appUserDataset.remove(cell[i]);
		}

	}else{
		L5.MessageBox.alert(RES_PROMOT,'没有选择记录');
	}
}

/*
 * 点击取消按钮
 */
function undo_click(){
	var userDataset = L5.DatasetMgr.lookup("userDataset");
	userDataset.rejectChanges();
	appUserDataset.rejectChanges();
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

//选择应用，调用应用选择通用帮助
function onSelectApp(){
	var record = appUserDataset.getCurrent();
	//var userId = record.get("userId");
	//var appCode = record.get("appCode");
	//if(appCode == null || appCode == ""){
	//	return;
	//}
	//var dataTypeRecord = dataTypeDataset.getById(dataType);
	L5.getCmp('appUserEditPanel').stopEditing();
		var revalue=window.showModalDialog("../application/app_query_list.jsp");
		if(revalue){
			var values = revalue.split(";");
			record.set("appCode", values[0]);
			record.set("appName", values[1]);
		}
}

//设置单元格的可编辑状态
function setEditable(){
	var appUserDataSet =L5.DatasetMgr.lookup("appUserDataset");
	var state = appUserDataSet.getCurrent().state;
	if(state==L5.model.Record.STATE_NEW)
	{
			return true;
	}
	else
		    return false;
}

function query(){
	var ableRolesDs=L5.DatasetMgr.lookup("ableRolesDs");
	var queryRoleName=getParam("roleName");
	if(queryRoleName!=null&&queryRoleName!=undefined){
		ableRolesDs.filter("roleInfo",getParam("roleName"),true,false);
	}else{
		ableRolesDs.clearFilter();
	}
}

function undo(){
	document.getElementById("roleName").value="";
}
