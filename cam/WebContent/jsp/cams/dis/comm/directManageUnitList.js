function init() {
	ds.setParameter("UPS", organCode);
	ds.setParameter("IN_USE", 1);
	ds.setParameter("sort", "ID");// 按ID排序
	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

function insert() {
	forOrganSelect();
}

function del() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			selected[0].set("inUse", "0");
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisDirectManageUnitCmd");
			command.setParameter("record", selected[0]);
			command.execute("deleteInUse");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					ds.remove(selected[i]);
				}
				ds.commitChanges();
				ds.reload();
				L5.Msg.alert('提示', "删除成功！");
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}

function save() {
	var valid = ds.isValidate();
	if (valid != true) {
		L5.Msg.alert('提示', "校验未通过,不能保存!" + valid);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisDirectManageUnitCmd");
	command.setParameter("records", ds.getAllChangedRecords());
	command.execute("save");
	if (!command.error) {
		L5.Msg.alert("提示", "保存成功！", function() {
					ds.commitChanges();
					ds.reload();
				});
	} else {
		L5.Msg.alert("提示", "保存出错！");
		return false;
	}
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var organString = organCode.substring(2, 12);
	if (organString == "0000000000") {
		var revalue = window
				.showModalDialog(
						"dicCity.jsp?hasBenJi=0&organCode=" + organCode
								+ "&organName="
								+ escape(encodeURIComponent(organName))
								+ "&radioType=checkbox&level=3&radioMaxlevel=1",
						"",
						"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	} else if (organCode.substring(4, 12) == "00000000") {
		var revalue = window
				.showModalDialog(
						"dicCity.jsp?hasBenJi=0&organCode=" + organCode
								+ "&organName="
								+ escape(encodeURIComponent(organName))
								+ "&radioType=checkbox&level=3&radioMaxlevel=2",
						"",
						"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	} else if (organCode.substring(6, 12) == "000000") {
		var revalue = window
				.showModalDialog(
						"dicCity.jsp?hasBenJi=0&organCode=" + organCode
								+ "&organName="
								+ escape(encodeURIComponent(organName))
								+ "&radioType=checkbox&level=3&radioMaxlevel=3",
						"",
						"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	}
	var idList = "";
	var nameList = "";
	var leveList = "";
	var upsList = "";
	var fullNameList = "";
	var list = "";
	if (revalue == "qingchu") {
		insert();
	}// 树的清除按钮
	if (revalue != "" && revalue != undefined) {
		list = revalue.split(";");
		idList = list[0].split(",");
		nameList = list[1].split(",");
		leveList = list[2].split(",");
		upsList = list[3].split(",");
		fullNameList = list[4].split(",");
	} else {
		return false;
	}
	for (var i = 0; i < idList.length; i++) {
		if (idList[i] == "") {
			return false;
		}
		var record = ds.newRecord();
		record.set("recordId", idList[i] + organCode);// 将主键value值设为区划加上级区划
		record.set("id", idList[i]);
		record.set("name", nameList[i]);
		record.set("leve", leveList[i]);
		record.set("ups", organCode);
		record.set("fullName", fullNameList[i]);
		record.set("isSelf", "0");
		record.set("inUse", "1");// 新增时inUse改为1
	}
	save();
}
