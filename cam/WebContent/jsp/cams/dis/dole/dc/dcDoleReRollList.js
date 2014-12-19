var num1;
var num2;
var charges=[];
function init() {
	if (batchDetailId != "" && batchDetailId != null) {
		infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
		infoDs.load();
		infoDs.on('load', function() {
			if(infoDs.getCount()>0) {
				hideYh(infoDs.getAt(0).get("allocationType"));
				for(var i=0;i<infoDs.getCount();i++){
					infoDs.getAt(i).set("account",charges[i]);
				}
			}
		});
	}
}
window.onbeforeunload=function(){ 
         var parent=window.dialogArguments;
          var reliefDoleds=parent.reliefDoleds;
          reliefDoleds.reload();
}
function query() {
	infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
	infoDs.setParameter("NAME@rlike", getParam("qName"));
	infoDs.setParameter("ID_CARD@rlike", getParam("qIdCard"));
	infoDs.setParameter("FAMILY_REGISTER", getParam("qFamilyRegister"));
	infoDs.setParameter("FAMILY_TYPE", getParam("qFamilyType"));
	
	var qFamilyNumStart = getParam("qFamilyNumStart");
	var qFamilyNumEnd = getParam("qFamilyNumEnd");
	if(_isNum(qFamilyNumStart) && _isNum(qFamilyNumEnd)) {
		infoDs.setParameter("FAMILY_NUM@between", qFamilyNumStart+"~"+qFamilyNumEnd);
	}else if(_isNum(qFamilyNumStart)) {
		infoDs.setParameter("FAMILY_NUM@between", qFamilyNumStart+"~9999");
	}else if(_isNum(qFamilyNumEnd)) {
		infoDs.setParameter("FAMILY_NUM@between", "0~"+qFamilyNumEnd);
	}
	
	var qApprovalTimesStart = getParam("qApprovalTimesStart");
	var qApprovalTimesEnd = getParam("qApprovalTimesEnd");
	if(_isNum(qApprovalTimesStart) && _isNum(qApprovalTimesEnd)) {
		infoDs.setParameter("APPROVAL_TIMES@between", qApprovalTimesStart+"~"+qApprovalTimesEnd);
	}else if(_isNum(qApprovalTimesStart)) {
		infoDs.setParameter("APPROVAL_TIMES@between", qApprovalTimesStart+"~9999");
	}else if(_isNum(qApprovalTimesEnd)) {
		infoDs.setParameter("APPROVAL_TIMES@between", "0~"+qApprovalTimesEnd);
	}
	
	infoDs.setParameter("ACCEPT_AREA_CODE", getParam("qAcceptAreaCode"));
	infoDs.load();
}
// 隐藏银行信息
function hideYh(at) {
	if (at == "0") {
		var gdGrid = L5.getCmp("dcGrid");
		gdGrid.getColumnModel().setHidden(4, true);
		gdGrid.getColumnModel().setHidden(5, true);
	}
}
//保存
function save() {
	var records=infoDs.getAllRecords();
	for(var i=0;i<records.length;i++){
		if(records[i].get('account')==""||records[i].get('account')==null){
			L5.Msg.alert("提示","实际发放金额不能为空！");
			return false;
		}
		charges[i]=records[i].get("account");
	}
	if(num1<num2){
		L5.Msg.alert("提示","实际发放金额不能大于核准发放资金!");
		return;
	}
		L5.MessageBox.confirm('确定', '确定要保存该记录吗?', function(state) {
		if (state == "yes") {
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd"); 
		command.setParameter("records", infoDs.getAllRecords());// 业务信息
		command.setParameter("inConfirm", "0");//是否确认
		command.execute("saveReDole");
		if (!command.error) {
			L5.Msg.alert('提示', "保存成功！", function(){
				query();
			});
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		} else {
				return false;
			}
		});
}

//确认
function confirm() {
	var records=infoDs.getAllRecords();
	for(var i=0;i<records.length;i++){
		if(records[i].get('account')==""||records[i].get('account')==null){
			L5.Msg.alert("提示","实际发放金额不能为空！");
			return false;
		}
		charges[i]=records[i].get("account");
	}
	if(num1<num2){
		L5.Msg.alert("提示","实际发放金额不能大于核准发放资金!");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要确认上报该记录吗?确认后则不得重复确认！', function(state) {
	if (state == "yes") {
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd"); 
	command.setParameter("records", infoDs.getAllRecords());// 业务信息
	command.setParameter("inConfirm", "1");//是否确认
	command.execute("saveReDole");
	if (!command.error) {
		L5.Msg.alert('提示', "确认成功！", function(){
			query();
		});
	}else{
		L5.Msg.alert('提示',"确认时出现错误！"+command.error);
	}
	} else {
			return false;
		}
	});
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qAcceptAreaCode").value = list[0];
		document.getElementById("qAcceptAreaName").value = list[4];
	}
}
function forExcel(){
	
}

function countNum1(value){
	num1=value;
	return value;
}
function countNum2(value){
	num2=value;
	return value;
}