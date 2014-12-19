// 验证公墓编号的正则表达式-经营
var regex = /^GZ37\d{4}-\d{2}$/;
// 验证公墓编号的正则表达式-公益
var regexG = /^GZ37\d{7}-\d{2,3}$/;

// 获取指定ID组件的值
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

// 返回
function back() {
	history.go(-1);
}

var _tatal = 2; // 需要加载的数据个数
var _i = 0; // 已经加载数据个数
var inte; // 进度条

// 加载数据条
function progressFunc() {
	L5.Msg.updateProgress(_i / _tatal);
	if (_i % _tatal == 0) {
		clearInterval(inte);
		L5.Msg.hide();
	}
}

// 显示补录指南
function detail() {
	var width = 800;
	var height = 600;
	var url = 'collection.html';
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
}

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

// 选择行政区划-无Ds赋值,查询使用
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

	var url = L5.webPath
			+ "/jsp/cams/fis/ep/comm/approvalAreaTree.jsp?cantCode=" + cantCode
			+ "&cantName=" + escape(encodeURIComponent(cantName))
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
	document.getElementById("areaLevel").value = name;
	document.getElementById("areaLevelId").value = id;
}

// 选择管辖单位-无Ds赋值,查询使用
function selectOrganNoDs(flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	//command.execute("getRootUserInfo");
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

	var url = L5.webPath
			+ "/jsp/cams/fis/ep/comm/approvalOrganTree.jsp?cantCode="
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
function selectArea(flag) {
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

	var url = L5.webPath
			+ "/jsp/cams/fis/ep/comm/approvalAreaTree.jsp?cantCode=" + cantCode
			+ "&cantName=" + escape(encodeURIComponent(cantName))
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
	document.getElementById("areaLevel").value = name;
	document.getElementById("areaLevelId").value = id;

	var record = ds.getCurrent();
	record.set("areaLevel", name);
	record.set("areaLevelId", id);
}

// 选择管辖单位
function selectOrgan(flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	//command.execute("getRootUserInfo");
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

	var url = L5.webPath
			+ "/jsp/cams/fis/ep/comm/approvalOrganTree.jsp?cantCode="
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

	var record = ds.getCurrent();
	record.set("manaLevel", name);
	record.set("manaLevelId", id);

	createCode4Prop();
}

function selectDicCity() {
	var revalue = window.showModalDialog(
			"../../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)) + "&level=3", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		// alert(list[0]+"-"+list[4])
		var record = ds.getCurrent();
		record.set("manaLevel", list[4]);
		record.set("manaLevelId", list[0]);

		createCode4Prop();
	}
}

// 根据页面里公墓性质(JS全局变量)生成对应的公墓编号
function createCode4Prop() {
	// alert(prop)
	if (prop == '1') {
		// 公益性
		createNoproCode();
	} else if (prop == '2') {
		// 经营性
		createProCode();
	}
}

// 生成公益性公墓编号
function createNoproCode() {
	var manaLevelId = document.getElementById("manaLevelId").value;
	if (!manaLevelId)
		return;
	var num = "01";
	var command = new L5.Command("com.inspur.cams.fis.ep.util.CemeNumberCmd");
	command.setParameter("manaLevelId", manaLevelId);
	command.execute();
	if (!command.error) {
		num = command.getReturn("cemeNumber");

		var ds = L5.DatasetMgr.lookup("ds");
		var ceme = ds.getCurrent();
		manaLevelId = manaLevelId.substr(0, 9);
		// 本级999转为000
		if (manaLevelId.substr(6, 9) == "999")
			manaLevelId = manaLevelId.substr(0, 6) + "000";
		var no = "GZ" + manaLevelId + "-" + num;
		ceme.set("cemeId", no);
	}
}

// 生成经营性公墓编号
function createProCode() {
	var manaLevelId = document.getElementById("manaLevelId").value;
	if (!manaLevelId)
		return;
	var num = "01";
	var command = new L5.Command("com.inspur.cams.fis.ep.util.CemeNumberCmd");
	command.setParameter("manaLevelId", manaLevelId);
	command.execute();
	if (!command.error) {
		num = command.getReturn("cemeNumber");

		var ds = L5.DatasetMgr.lookup("ds");
		var ceme = ds.getCurrent();
		var no = "GZ" + manaLevelId.substr(0, 6) + "-" + num;
		ceme.set("cemeId", no);
	}
}
// 手机号码校验
function checkMobTel(domId) {
	if (document.getElementById(domId).value) {
		if (!isMTel(document.getElementById(domId).value)) {
			document.getElementById(domId).value = "";
			L5.Msg.alert("提示", "请输入正确的手机号码！");
			return;
		}
	}
}
// 邮政编码校验
function checkPostCode(domId) {
	if (document.getElementById(domId).value) {
		if (!_isPostCode(document.getElementById(domId).value)) {
			document.getElementById(domId).value = "";
			L5.Msg.alert("提示", "请输入正确的邮政编码");
			return;
		}
	}
}
// 小数点位数处理
function checkAssMon(domId) {
	if (document.getElementById(domId).value) {
		if (!isFloat(document.getElementById(domId).value)) {
			document.getElementById(domId).value = "";
			L5.Msg.alert("提示", "请输入数字");
			return;
		}
		document.getElementById(domId).value = changeTwoDecimal(document
				.getElementById(domId).value);
	}
}
// 联系电话校验
function checkTel(domId) {
	if (document.getElementById(domId).value) {
		if (!isTel(document.getElementById(domId).value)) {
			document.getElementById(domId).value = "";
			L5.Msg.alert("提示", "请输入正确的联系电话");
			return;
		}
	}
}
// 校验数字
function checkNum(domId) {
	if (document.getElementById(domId).value) {
		if (!_isNum(document.getElementById(domId).value)) {
			document.getElementById(domId).value = "";
			L5.Msg.alert("提示", "请输入数字");
			return;
		}
	}
}
// 手机号码校验
function isMTel(s) {
	return /^1(3\d|(58|59|56|52|53|50|51|80|85|86|87|88|89))\d{8}$/g.test(s);
}

function renRender(val) {
	return val + "  人";
}

function wanRender(val) {
	return val + "  万元";
}

function muRender(val) {
	return val + "  亩";
}

function aRender(val) {
	return val + "  ㎡";
}