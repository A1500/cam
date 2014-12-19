// 初始化当前用户单位信息
function initArea() {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return null;
	}

	var str = userInfo.cantName;
	userInfo.shortName = str.substr(0, str.indexOf("民政"));
	return userInfo;
}

// 选择行政区划-无Ds赋值
function selectAreaNoDs(flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var str = userInfo.cantName;
	var cantName = str.substr(0, str.indexOf("民政"));
	var cantType = userInfo.userDepOrganType;

	var url = L5.webPath + "/jsp/cams/fis/comm/approvalAreaTree.jsp?cantCode="
			+ cantCode + "&cantName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType + "&selectedType=13,";

	if (flag == '1') {
		// 当flag为1时，全部可选
		url += "11,12,";
	}
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
	document.getElementById("areaLevel").value = name;
	document.getElementById("areaLevelId").value = id;
}

// 选择管辖单位-无Ds赋值
function selectOrganNoDs(flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;
	var cantType = userInfo.userDepOrganType;

	var url = L5.webPath + "/jsp/cams/fis/comm/approvalOrganTree.jsp?cantCode="
			+ cantCode + "&cantName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType;
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
}

// 选择行政区划
function selectArea(valueId, textId, flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var str = userInfo.cantName;
	var cantName = str.substr(0, str.indexOf("民政"));
	var cantType = userInfo.userDepOrganType;

	var url = L5.webPath + "/jsp/cams/fis/comm/approvalAreaTree.jsp?cantCode="
			+ cantCode + "&cantName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType + "&selectedType=13,";
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

	var record = ds.getCurrent();
	if (valueId != undefined) {
		document.getElementById(valueId).value = id;
		record.set(valueId, id);
	}
	if (textId != undefined) {
		document.getElementById(textId).value = name;
		record.set(textId, name);
	}
}

// 选择管辖单位
function selectOrgan(valueId, textId, flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	command.execute("getUserInfo"); // getRootUserInfo
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;
	var cantType = userInfo.userDepOrganType;

	var url = L5.webPath + "/jsp/cams/fis/comm/approvalOrganTree.jsp?cantCode="
			+ cantCode + "&cantName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType;
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

	var record = ds.getCurrent();
	if (valueId != undefined) {
		document.getElementById(valueId).value = id;
		record.set(valueId, id);
	}
	if (textId != undefined) {
		document.getElementById(textId).value = name;
		record.set(textId, name);
	}
}