function init() {
	// 组织机构初始默认登陆者
	L5.informSession = {};
	L5.informSession.getUserInfo = function() {
		if (sameDomain && top.userInfo != null)
			return top.userInfo;
		var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
		command.execute("getUserInfo");
		if (!command.error) {
			var info = command.getReturn("userInfo");
			if (sameDomain) {
				top.userInfo = info;
			}
			return info;
		} else {
			alert("用户没有登录！");
		}
	}
	var userInfo = L5.informSession.getUserInfo();
	document.getElementById("manaLevelId").value = userInfo.cantCode;
	document.getElementById("manaLevel").value = userInfo.cantName;
	if ((userInfo.cantCode.substr(4, 2) == '00')
			&& (userInfo.cantCode.substr(3, 1) != '0')) {
		document.getElementById("result").value = "3";
		document.getElementById("result").disabled = "disabled";

	}
	// L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function resetQuery() {
	var userInfo = L5.informSession.getUserInfo();
	document.getElementById("manaLevelId").value = userInfo.cantCode;
	document.getElementById("manaLevel").value = userInfo.cantName;
	document.getElementById("cemeID").value = "";
	document.getElementById("year").value = "2011";
	// document.getElementById("result").value = "";
	document.getElementById("cemeProp").value = "";
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

var regex = /^20\d{2}$/;
// 年检查询
function query() {
	var year = getParam("year");
	if (!regex.test(year)) {
		L5.Msg.alert('提示', "请输入正确年份!");
		return;
	}
	ds.setParameter("CEME_ID", getParam("cemeID"));
	ds.setParameter("CHECK_YEAR", year);
	ds.setParameter("CHECK_RESULT", getParam("result"));
	ds.setParameter("MANA_LEVEL_ID", getParam("manaLevelId"));
	ds.setParameter("PROP", getParam("cemeProp"));
	ds.load();
}

// 业务办理
function accepted() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条要年检的记录!");
		return false;
	}
	if ((selected[0].get('CHECK_RESULT') == "1")) {
		L5.Msg.alert('提示', "该公墓已年检结束，不能进行该操作!");
		return false;
	}

	var data = new L5.Map();
	data.put("dataBean", selected[0].get('CEME_ID'));
	data.put("resultId", selected[0].get('RESULT_ID'));
	data.put("applayId", selected[0].get('FIRST_APPLY_ID'));
	data.put("checkYear", selected[0].get('CHECK_YEAR'));
	data.put("checkNum", selected[0].get('CHECK_NUM'));
	// 若年检不合格业务，insert
	if ((selected[0].get('CHECK_RESULT') == "4")) {
		data.put("method", "INSERT");

	}
	if (selected[0].get('CHECK_RESULT') == "0") {
		data.put("method", "INSERT");
	}
	if (selected[0].get('CHECK_RESULT') == "3") {
		data.put("method", "UPDATE");
	}
	if (selected[0].get('PROP') == "2") {
		var url = 'jsp/cams/fis/ep/check/cemeProfitInspectionEdit.jsp';
		var text = '经营性公墓年检业务办理';
		L5.forward(url, text, data);
	} else {
		var url = 'jsp/cams/fis/ep/check/cemeNoprofitInspectionEdit.jsp';
		var text = '公益性公墓年检业务办理';
		L5.forward(url, text, data);
	}
}

function selectUser(flag) {
	L5.informSession = {};
	L5.informSession.getUserInfo = function() {
		if (sameDomain && top.userInfo != null)
			return top.userInfo;
		var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
		command.execute("getUserInfo");
		if (!command.error) {
			var info = command.getReturn("userInfo");
			if (sameDomain) {
				top.userInfo = info;
			}
			return info;
		} else {
			alert("用户没有登录！");
		}
	}
	// var userInfo = L5.informSession.getUserInfo();
	// var cantCode = userInfo.cantCode;
	// var cantName = userInfo.cantName;

	var url = "../comm/approvalOrganTreeCheckBox.jsp?cantCode=" + orgCode
			+ "&cantName=" + escape(encodeURIComponent(orgName));
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}

	var id = "";
	var name = "";
	var id_name = "";

	// 如果是点击的是【确定】
	if (win[0].length > 0) {

		// 第一个值前面没有逗号
		id = win[0][0];// id1,id2,id3......
		name = win[1][0];// name1,name2,name3......
		id_name = id + "[" + name + "]";// id1[name1],id2[name2],id3[name3].......

		// 其余值之间用逗号分隔
		if (win[0].length > 1) {
			for (var i = 1; i < win[0].length; i++) {
				id = id + "," + win[0][i];
				name = name + "," + win[1][i];
				id_name = id_name + "," + win[0][i] + "[" + win[1][i] + "]";
			}
		}
	}
	document.getElementById("manaLevel").value = name;
	document.getElementById("manaLevelId").value = id;

	// var record=ds.getCurrent();
	// record.set("manaLevel", name);
	// record.set("manaLevelId", id);
	// document.getElementById("organCode").value=id;
}

// 渲染年检结果
// function renderer_result_text(_id){
// var record=ds.getAt(_id);
// if(record.get("CHECK_RESULT") == "0"){
// return "<font color='blue'>未年检</font>";
// }else if(record.get("CHECK_RESULT") == "1"){
// return "合格";
// }else if(record.get("CHECK_RESULT") == "2"){
// return "<font color='red'>不合格</font>";
// }else if(record.get("CHECK_RESULT") == "3"){
// return "初检不合格";
// }
// }

