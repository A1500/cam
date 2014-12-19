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