function init() {
	var DisabilityIdentiDataset = L5.DatasetMgr
			.lookup("DisabilityIdentiDataset");
	DisabilityIdentiDataset.setParameter("PEOPLE_ID", peopleId);
	DisabilityIdentiDataset.setParameter("APPLY_ID", applyId);
	DisabilityIdentiDataset.load();
	L5.QuickTips.init();
	DisabilityIdentiDataset.on("load", setId);
	DisabilityIdentiDataset.on("load", haveSave);
}

function haveSave() {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.DisabilityIdentificationCommand");
	command.setParameter("APPLY_ID", applyId);
	command.execute("haveSave");
	var flag = command.getReturn("flag");
	if(flag=="true"){//可写
		document.getElementById("disabilityReason").disabled = false;
		document.getElementById("disabilityBody").disabled = false;
	}
	
}
function setId() {
	var date = new Date();
	var year = "" + date.getFullYear();
	var idPre = organCodeSub + year;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.DisabilityIdentificationCommand");
	command.setParameter("idPre", idPre);
	command.setParameter("PEOPLE_ID", peopleId);
	command.execute("getId");
	var id = command.getReturn("id");

	if (command.getReturn("numbering") == undefined) {
		var numbering = command.getReturn("numbering");
		DisabilityIdentiDataset.set("numbering", id);
	}
}

function saveClick() {
	var DisabilityIdentiDataset = L5.DatasetMgr
			.lookup("DisabilityIdentiDataset");
	var DisabilityIdentiRecord = DisabilityIdentiDataset.getCurrent();

	var isValidate = DisabilityIdentiDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert('提示', isValidate);
		return false;
	}

	var introductionDate = DisabilityIdentiRecord.get("introductionDate");
	if (introductionDate != '' && !validateDateFormat(introductionDate)) {
		L5.Msg.alert('提示', "介绍时间格式不正确！");
		return false;
	}
	var disabilityReason = DisabilityIdentiRecord.get("disabilityReason");
	if (disabilityReason == ''||disabilityReason==null) {
		L5.Msg.alert('提示', "致残原因不能为空!");
		return false;
	}
	var disabilityBody = DisabilityIdentiRecord.get("disabilityBody");
	if (disabilityBody == ''||disabilityBody==null) {
		L5.Msg.alert('提示', "致残情况不能为空!");
		return false;
	}
	/*var identificationDate = DisabilityIdentiRecord.get("identificationDate");
	if (identificationDate != '' && !validateDateFormat(identificationDate)) {
		L5.Msg.alert('提示', "鉴定时间格式不正确！");
		return false;
	}*/

	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.DisabilityIdentificationCommand");
	command.setParameter("record", DisabilityIdentiRecord);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示', "数据保存成功!");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_Close() {
	window.close();
}

function print() {
	var url = "../../../../comm/print/jspcommonprint.jsp?";
	var text = '鉴定介绍信打印';
	var width = 1024;
	var height = 768;
	window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
					+ width + "px;dialogHeight:" + height + "px;resizable:1");
}