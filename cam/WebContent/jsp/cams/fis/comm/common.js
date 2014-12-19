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