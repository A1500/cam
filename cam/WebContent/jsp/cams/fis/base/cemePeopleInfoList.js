var userInfo;
function init() {
	userInfo = initArea();
	var ds = L5.DatasetMgr.lookup("ds");
	ds.on("load", function(ds) {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (ds.getTotalCount() == 0) {
					// L5.Msg.alert("提示", "无符合条件的结果！");
					qrToolbar.setText("查询结果");
				} else {
					qrToolbar.setText("查询结果(" + ds.getTotalCount() + "条)");
				}
			});
	query();
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

function query() {
	var ds = L5.DatasetMgr.lookup("ds");
	var manaId = userInfo.cantCode;
	var manaPrexx = "GZ";
	if (manaId.substring(2) == "0000000000") {
		ds.setParameter("CREATE_ORGAN@rlike@String", manaPrexx
						+ manaId.substring(0, 2));
	} else if (manaId.substring(4) == "00000000") {
		ds.setParameter("CREATE_ORGAN@rlike@String", manaPrexx
						+ manaId.substring(0, 4));
	} else {
		ds.setParameter("CREATE_ORGAN@rlike@String", manaPrexx
						+ manaId.substring(0, 6));
	}

	var name = document.getElementById("qName").value;
	var ifCancel = document.getElementById("qIfCancel").value;
	ds.setParameter("NAME@rlike@String", name);
	ds.setParameter("IF_CANCEL@=@String", ifCancel);
	ds.load();
}

// 导出excel
function print() {
	
}

// 明细
function detailHref(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:detail(\'' + record.get("peopleId") + '\')">'
			+ value + '</a>';
}

function detail(peopleId) {
	// var data = new L5.Map();
	// data.put("peopleId", peopleId);
	// var url = 'jsp/cams/fis/base/peopleManageDetai.jsp';
	// var text = '工作人员信息';
	// L5.forward(url, text, data);

	var url = "funeralPeopleInfoDetail.jsp?peopleId=" + peopleId;
	window
			.showModalDialog(url, window,
					"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}