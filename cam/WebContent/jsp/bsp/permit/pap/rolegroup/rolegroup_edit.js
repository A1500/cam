function init() {
	var dataset = L5.DatasetMgr.lookup("roleGroupDataSet");
	if(method=='INSERT'){
	    var record =dataset.newRecord();
	    if(corpName!=="undefined"){
	      record.set("corporation",corpId);
	      document.getElementById("corporationName").value=corpName;
	      document.getElementById("corporation").value=corpId;
	    }
	}
	if(method=='UPDATE'){
		dataset.baseParams["ROLE_GROUP_ID"]=roleGroupId;
		dataset.baseParams["method"]='detail';
		dataset.load();
		roleGroupName = unescape(roleGroupName);
		document.getElementById("corporationName").value = roleGroupName;
	}
	//L5.QuickTips.init();
}

//保存
function save(){
	var roleGroupDataSet = L5.DatasetMgr.lookup("roleGroupDataSet");
	var record = roleGroupDataSet.getCurrent();
	var retRecord;
	var command = new L5.Command("org.loushang.bsp.permit.pap.rolegroup.cmd.RoleGroupCmd");
	command.setParameter("records", record);
	if(method=='INSERT'){
		command.execute("insert");
	}
	if(method=='UPDATE'){
		command.execute("update");
	}
	retRecord = command.getReturn("retRecord");
	if (!command.error) {
		roleGroupDataSet.commitChanges();
		return retRecord;
	}else{
		L5.Msg.alert(RES_PROMOT,command.error);
	}
	return retRecord;
}

//字段检测
function roleGroup_valid(){
	var roleGroupName = document.getElementById("roleGroupName").value;
	if(roleGroupName==''){
		L5.MessageBox.alert("提示","角色组名称不能为空");
		return false;
	}
	if(roleGroupName.length>30){
		L5.MessageBox.alert("提示","角色组名称长度过长");
		return false;
	}
	var corporationName = document.getElementById("corporationName").value;
	if(corporationName==''){
		L5.MessageBox.alert("提示","所属单位不能为空");
		return false;
	}
	return true;
}

//取消
function cancel_click(){
	L5.forward("jsp/bsp/permit/pap/rolegroup/rolegroup_query.jsp",query_title);
}

//下一步
function next_click(){
	if(!roleGroup_valid()){
		return false;
	}
	var retRecord = save();

	var map = new L5.Map();
	map.put("method","INSERT");
	map.put("roleGroupId",encodeURI(encodeURI(retRecord.roleGroupId)));

	map.put("roleGroupName",encodeURI(encodeURI(retRecord.roleGroupName)));
	L5.forward("jsp/bsp/permit/pap/rolegroup/role_query.jsp",query_title,map);
}

//完成
function end_click(){
	if(!roleGroup_valid()){
		return false;
	}
	save();
	L5.forward("jsp/bsp/permit/pap/rolegroup/rolegroup_query.jsp",query_title);
}

/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//list[0] == organId,list[1]==organName,list[2]==struId
//		var userDataset = L5.DatasetMgr.lookup("userDataset");
//		var userRecord = userDataset.getCurrent();
		document.getElementById("corporation").value = list[2];
		document.getElementById("corporationName").value = list[1];
		var roleGroupDataSet = L5.DatasetMgr.lookup("roleGroupDataSet");
		var record = roleGroupDataSet.getCurrent();
		record.set("corporation",list[2]);
	}
}

/*
 * 通用帮助,角色组使用范围
 */
function forHelpUse(){
	var revalue=window.showModalDialog("../../../organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=1,2&isExact=0&isCheckBox=1&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes");
	if(revalue!=undefined&&revalue!=""){
		var list = revalue.split(";");
		var rcd = roleGroupDataSet.getCurrent();
		rcd.set('useCorporation',list[2]);
		rcd.set('useCorporationName',list[1]);


	}
}

/*
 * 清除
 */
function clear_click(src){
	src.value = '';
	document.getElementById("useCorporation").value = '';
}