var addBatch = "";
var delBatch = "";
var yBatch = "";
function init() {
	var batchds = L5.DatasetMgr.lookup("batchds");

	var batchDetailds = L5.DatasetMgr.lookup("batchDetailds");
	batchDetailds.on("load", function() {
				if(batchDetailds.getCount()>0) {
					var isFill = false;
					for(var i=0;i<batchDetailds.getCount();i++){
						if(batchDetailds.getAt(i).get("FILL_STATE")!="0") {
							isFill = true;
							break;
						}
					}
					if(isFill) {
						document.getElementById("year").disabled="disabled";
						document.getElementById("reliefType").disabled="disabled";
						document.getElementById("grantType").disabled="disabled";
						document.getElementById("allocationType").disabled="disabled";
					}
				}
			});

	batchds.setParameter("BATCH_ID", batchId);
	batchds.on("load", function() {
				yBatch = batchds.get("areaCode");
				var batchDetailds = L5.DatasetMgr.lookup("batchDetailds");
				batchDetailds.setParameter("BATCH_ID", batchId);
				batchDetailds.load();
			});
	batchds.load();
	L5.QuickTips.init();
};
function update() {
	var valid = batchds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',""+valid);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchCmd");
	command.setParameter("record", batchds.getCurrent());
	command.setParameter("batchDetailds", batchDetailds.getAllRecords());
	command.execute("update");
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
	var disabledBatch = "";
	var batchDetailds = L5.DatasetMgr.lookup("batchDetailds");
	if (batchDetailds) {
		for (var i = 0; i < batchDetailds.getCount(); i++) {
			if (batchDetailds.getAt(i).get("fillState") != '0') {
				disabledBatch += batchDetailds.getAt(i).get("requiredOrganCode");
			}
		}
	}
	var revalue = window.showModalDialog("dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=checkbox&level=3&areaCode="
					+ batchds.get("areaCode") + "&disabledBatch="
					+ disabledBatch, "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		addOrDel(list[0], yBatch);
		batchds.getCurrent().set("areaCode", list[0]);
		batchds.getCurrent().set("areaName", list[4]);
	}
}
function addOrDel(newbatch, oldbatch) {
	addBatch = "";
	delBatch = "";
	var n = newbatch.split(",");
	var o = oldbatch.split(",");
	for (var i = 0; i < n.length; i++) {
		if (oldbatch.indexOf(n[i]) == -1) {
			addBatch += n[i] + ",";
		}
	}
	for (var i = 0; i < o.length; i++) {
		if (newbatch.indexOf(o[i]) == -1) {
			delBatch += o[i] + ",";
		}
	}
}
