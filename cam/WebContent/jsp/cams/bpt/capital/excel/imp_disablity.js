function init() {
	var disabiltyTemp = L5.DatasetMgr.lookup("disabiltyTemp");
	disabiltyTemp.setParameter("ORGAN_CODE", organCode);
	disabiltyTemp.setParameter("REGISTER_TYPE", registerType);  
	disabiltyTemp.load();
	L5.QuickTips.init();
}

function change_func(value) {
	if (value == "0") {
		return "是";
	} else if (value == "1") {
		return "否";
	}
}

function query() {
	var name = document.getElementById("name").value;
	var idCard = document.getElementById("idCard").value;
	var isInDB = document.getElementById("isInDB").value;
	var isVailidate = document.getElementById("isVailidate").value;

	disabiltyTemp.setParameter("ORGAN_CODE", organCode);
	disabiltyTemp.setParameter("REGISTER_TYPE", registerType);  

	if (name != null && name != "") {
		disabiltyTemp.setParameter("@NAME like", "%" + name + "%");
	}
	if (idCard != null && idCard != "") {
		disabiltyTemp.setParameter("@ID_CARD like", "%" + idCard + "%");
	}
	if (isInDB != null && isInDB != "") {
		disabiltyTemp.setParameter("COMMIT_FLAG", isInDB);
	}
	if (isVailidate != null && isVailidate != "") {
		if (isVailidate == "0") {
			disabiltyTemp.setParameter("VALIDATE_FLAG", 1);
		} else if (isVailidate == "1") {
			disabiltyTemp.setParameter("VALIDATE_FLAG", 0);
		}
	}
	disabiltyTemp.load();
	L5.QuickTips.init();
}

function update() {
	var editGrid = L5.getCmp('baseGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	var id = selected[0].get("id");
	var url = "";
	if(registerType == "11") {
		url = "imp_disablity_update.jsp";
	} else if(registerType == "00") {
		url = "imp_compulsory_update.jsp";
	} else {
		url = "imp_dependant_update.jsp";
	}
	url += "?id=" + id + "&registerType=" + registerType;
	var width = screen.width - 100;
	var height = screen.height - 140;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	init();
}
/**
 * 弹出excel导入界面
 */
function into() {
	var s = L5.getCmp('addNewDemobilizedGrantObject');
	s.show();
}

function save() {
	var disabiltyTemp = L5.DatasetMgr.lookup("disabiltyTemp");
	if (disabiltyTemp.getCount() == 0) {
		L5.Msg.alert("提示", "没有要入库的信息");
		return false;
	}

	var command = new L5.Command("com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalCommand");
	command.setParameter("ORGAN_CODE", organCode);
	command.setParameter("REGISTER_TYPE", registerType);  
	command.execute("validateCommit");
	if (!command.getReturn("validate")) {
		L5.Msg.alert("提示", "验证未通过的信息不能入库");
		return false;
	}
	var s = L5.getCmp('saveData');
	s.show();

}

/**
 * 写入数据库
 */
function impData() {
	var startDate = document.getElementById("startDate").value;
	var endDate = document.getElementById("endDate").value;
	if (startDate == null || startDate == "") {
		L5.Msg.alert("提示", "发放起月份不能为空");
		return false;
	}
	if (endDate == null || endDate == "") {
		L5.Msg.alert("提示", "发放止月份不能为空");
		return false;
	}

	if (!validateDateFormat(startDate + "-01")) {
		L5.Msg.alert("提示", "发放起月份格式不正确");
		return false;
	}

	if (!validateDateFormat(endDate + "-01")) {
		L5.Msg.alert("提示", "发放止月份格式不正确");
		return false;
	}

	if (endDate < startDate) {
		L5.Msg.alert("提示", "发放止月份不能小于发放起月份");
		return false;
	}

	// 写入数据库
	var command = new L5.Command("com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalCommand");

	command.setParameter("registerType", registerType);
	command.setParameter("startDate", startDate);
	command.setParameter("endDate", endDate);
	command.setParameter("organCode", organCode);
	command.execute("impValidate");
	if (command.getReturn("validate")) {
		L5.Msg.alert("提示", "该时期资金已发放");
		return false;
	} else {
		command.setParameter("ORGAN_CODE", organCode);
		command.setParameter("REGISTER_TYPE", registerType);
		command.setParameter("startDate", startDate);
		command.setParameter("endDate", endDate);
		command.execute("saveCapital");
		if (!command.error) {
			L5.Msg.alert('提示', "写入成功!");
			L5.getCmp('saveData').hide();
			query();
		} else {
			L5.Msg.alert('提示', command.error);
		}
	}
}

/**
 * 从验证信息表中删除某时期已发放的人员信息
 */
function deleteValidate() {
	var editGrid = L5.getCmp('ImpDataGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}

	for (var i = 0; i < selected.length; i++) {
		selected[i].set("id", selected[i].get("ID"));
	}

	if (window.confirm("确定要删除吗？")) {
		var command = new L5.Command("com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalCommand");
		command.setParameter("records", selected);
		command.execute("delete");
		if (!command.error) {
			for (var i = 0; i < selected.length; i++) {
				ImpData.remove(selected[i]);
			}
			query();
		} else {
			L5.Msg.alert('提示', "删除时出现错误！" + command.error);
		}
	}
}

/**
 * 导入excel
 * 
 * @return {Boolean}
 */
function upload() {
	var filename = document.getElementById("filename").value;
	if (filename == null || filename == "") {
		L5.Msg.alert("提示", "请选择上传的文件");
		return false;
	}
	var lastIndex = filename.lastIndexOf(".");
	var suffFileName = filename.substring(lastIndex + 1);// 取得模板后缀名
	if (suffFileName != "xls" && suffFileName != "xlsx") {
		L5.Msg.alert("提示", "上传文件格式不正确");
		return false;
	}

	var command = new L5.Command("com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalCommand");
	command.setParameter("organCode", organCode);
	command.setParameter("registerType", registerType);
	command.setForm("form_content");
	command.execute("importExcel");

	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert('提示', "导入成功!");
			L5.getCmp('addNewDemobilizedGrantObject').hide();
			init();
		} else {
			L5.Msg.alert('提示', command.error);
		}
	}
}

/**
 * 删除记录
 */
function deleteRecord() {
	var editGrid = L5.getCmp('baseGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}

	if (window.confirm("确定要删除吗？")) {
		var command = new L5.Command("com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalCommand");
		command.setParameter("records", selected);
		command.execute("delete");
		if (!command.error) {
			L5.Msg.alert('提示', "删除成功!");
		} else {
			L5.Msg.alert('提示', "删除时出现错误！" + command.error);
		}
	}
	query();
}