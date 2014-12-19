function init() {
	var tDate = L5.server.getSysDate();
	batchds.newRecord({
				"year" : tDate.getYear() + "",
				"createOrgan" : organName,
				"dcReliefBatch" : "01",
				"createPerson" : userName
			});
	L5.QuickTips.init();
};
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function onChange(o) {
	if(o.value=="DC") {
//		document.getElementById("dcLabel").style.display = "";
//		document.getElementById("dcSelect").style.display = "";
	} else {
		document.getElementById("dcLabel").style.display = "none";
		document.getElementById("dcSelect").style.display = "none";
	}
}
function save() {
	var valid = batchds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',""+valid);
		return false;
	}	
//	if(batchds.getCurrent().get("reliefType")=="DC" && batchds.getCurrent().get("dcReliefBatch")=="") {
//		L5.Msg.alert('提示',"冬春生活救助需要录入本年度批次！");
//		return false;
//	}
	var record = batchds.getCurrent();
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchCmd");
	command.setParameter("record", record);
	command.execute("insert");
	if (!command.error) {
		L5.Msg.alert('提示', "保存成功!", function() {
					window.returnValue = "-1";
					window.close();
				});
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog("dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=checkbox&level=3&radioMaxlevel=2", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		batchds.getCurrent().set("areaCode", list[0]);
		batchds.getCurrent().set("areaName", list[4]);
	}
}