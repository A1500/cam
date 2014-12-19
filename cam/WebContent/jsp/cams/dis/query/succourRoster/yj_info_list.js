function exportExcel(){
}

function init() {
	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == undefined || value == "") {
		value = "";
	}
	return value;
}
function query() {
	var acceptareacode = getParam("acceptareacode");
	ds.setParameter("acceptareacode", acceptareacode);
	ds.load();
}

function insert() {
	var url = L5.webPath
			+ '/jsp/cams/dis/assistance/yj_info/yj_info_edit.jsp?method=INSERT&batchDetailId='
			+ batchDetailId;
	var width = screen.width - 60;
	var height = 580;
	var val = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	if (val == true) {
		ds.reload();
	} else {
		return;
	}
}

function update() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	var pid = selected[0].get('infoId');
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCommand");
	command.setParameter("infoId", pid);
	command.afterExecute = function() {
		if (!command.error) {
			var result = command.getReturn("result");
			if (result == false) {
				L5.Msg.alert("提示", "该信息已经提交不能修改！");
			} else {
				var url = L5.webPath
						+ '/jsp/cams/dis/assistance/yj_info/yj_info_edit.jsp?method=UPDATE&infoId='
						+ pid;
				var width = screen.width - 60;
				var height = screen.height - 30;
				var val = window.showModalDialog(url, window,
						"scroll:yes;status:no;dialogWidth:" + width
								+ "px;dialogHeight:" + height
								+ "px;resizable:0");
				if (val == true) {
					ds.reload();
				} else {
					return;
				}
			}
		} else {
			L5.Msg.alert("提示", "获取信息出错，错误信息为：" + command.error);
		}
	};
	command.execute("checkUpdate");

}
function detail() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}
	// var data = new L5.Map();
	// data.put("method","DETAIL");
	// data.put("infoId",selected[0].get('infoId'));
	// var url='jsp/cams/dis/assistance/gd_info/gd_info_detail.jsp';
	// var text = '过渡性生活救助明细';
	// L5.forward(url,text,data);
	var pid = selected[0].get('infoId');
	var url =  '../../assistance/yj_info/yj_info_detail.jsp?method=DETAIL&infoId='
			+ pid;
	var width = screen.width - 60;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
function del() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var delIds = [];
			for (var i = 0; i < selected.length; i++) {
				delIds[i] = selected[i].get("infoId");
			}
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCommand");
			command.setParameter("delIds", delIds);
			command.setParameter("batchDetailId", batchDetailId);
			command.afterExecute = function() {
				var result = command.getReturn("result");
				if (!command.error) {
					if (result != undefined && result != "") {
						L5.Msg.alert('提示', result);
					} else {
						for (var i = 0; i < selected.length; i++) {
							ds.remove(selected[i]);
						}
						ds.commitChanges();
					}
				} else {
					L5.Msg.alert('提示', "删除时出现错误！" + command.error);
				}

			}
			command.execute("delete");
		} else {
			return false;
		}
	});
}
/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath+"/jsp/cams/dis/assistance/dic_city/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("acceptareacode").value = list[0];
		document.getElementById("acceptareaname").value = list[4];
	}
}

function printPeople() {
	history.go(-1);
}
