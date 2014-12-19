function init() {
	sipTime('');
	ifquery();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	BaseinfoPeopleDataSet.setParameter("domicileCode",getParam("domicileCode"));		
	BaseinfoPeopleDataSet.setParameter("name",getParam("name"));		
	BaseinfoPeopleDataSet.setParameter("idCard",getParam("idCard"));		
	BaseinfoPeopleDataSet.setParameter("domicileType",getParam("domicileType"));		
	BaseinfoPeopleDataSet.setParameter("warStateCode","2");		
	BaseinfoPeopleDataSet.setParameter("testedType",getParam("testedType"));		
	BaseinfoPeopleDataSet.setParameter("disabilityLevelCode",disabilityLevelCode=='all'? disabilityLevelCode: getParam("disabilityLevelCode"));
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);
	BaseinfoPeopleDataSet.setParameter("isdemobilizedill",getParam("isdemobilizedill"));
	BaseinfoPeopleDataSet.setParameter("lifehardorill",getParam("lifehardorill"));
	var returnValue = sipQueryTime(BaseinfoPeopleDataSet,'');
	if(returnValue) {
		BaseinfoPeopleDataSet = returnValue;
		BaseinfoPeopleDataSet.load();
	}
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("disabilityStateCode").value = "";
} 



/**
 * 属地行政区划窗口
 */
function forHelp(){
		//var revalue=window.showModalDialog("../../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		var revalue=window.showModalDialog("../../../../bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13,14&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
function detail() {
 	var width = screen.width-100;
 	var height = screen.height-140;
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var url = '../../flow/tested/bpttestedDetailMain.jsp?familyId=' + familyId + '&peopleId='+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}

function showTime(id) {
	var type = document.getElementById(id+"timeType").value;
	if (type == '1') {
		document.getElementById(id+"times").style.display = "";
		document.getElementById(id+"time").style.display = "none";
	} else {
		document.getElementById(id+"times").style.display = "none";
		document.getElementById(id+"time").style.display = "";
	}
}
/**
 * 
 * @param {} ds
 */
function sipQueryTime(ds,id) {
	var type = document.getElementById(id+"timeType").value;
	var cxsj_q;
	var cxsj_z;
	if(type=='1'){
		cxsj_q = document.getElementById(id+"cxsj_qs").value;
		cxsj_z = document.getElementById(id+"cxsj_zs").value;
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '查询起始时间不能为空！');
			return false;
		}
		if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
			L5.Msg.alert("提示","查询起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '查询结束时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","查询结束时间格式不正确！");
			return false;
		}
	}else if(type=='2'){
		cxsj_q ="";
		cxsj_z = document.getElementById(id+"cxsj_z").value;
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	
	ds.setParameter("startTime", cxsj_q);
	ds.setParameter("endTime",cxsj_z);
	return ds;
}
/**
 * 是否自动查询
 */
function ifquery() {
	if (autoQuery != null && autoQuery == "true") {
		document.getElementById("domicileType").value=domicileType;
		document.getElementById("testedType").value=testedType;
		document.getElementById("domicileCode").value = query_organCode;
		document.getElementById("domicileName").value = querymartyrOrganName();
		document.getElementById("lifehardorill").value = lifehardorill;
		document.getElementById("isdemobilizedill").value = isdemobilizedill;
		document.getElementById("disabilityLevelCode").value = disabilityLevelCode;
		sipTime('');
		query();
	}
}
/**
 * 查询organName
 */
function querymartyrOrganName() {
	if (query_organCode != null && query_organCode != "") {
		var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
		command.setParameter("ID", query_organCode);
		command.execute("findOrganName");
		var fullName = command.getReturn("organName");
		if (fullName != null && fullName != "") {
			return fullName;
		}
	}
}
/**
 * 时间查询条件赋值以及初始化
 * @param {} id
 */
function sipTime(id) {
	var selects = document.getElementById(id+"timeType");
	for(var i=0;i<selects.length;i++) {
		if(selects[i].value == query_timeType) {
			selects[i].selected = true;
			break;
		}
	}
	document.getElementById(id+"cxsj_qs").value=query_startTime;
	document.getElementById(id+"cxsj_zs").value=query_endTime;
	document.getElementById(id+"cxsj_z").value=query_endTime;
	
	showTime(id);
}