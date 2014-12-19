var autoInput; // 行政区划输入框
var autoCode; // 行政区划代码（隐藏域）
var autoDiv; // 提示框
var autoUl; // 提示框下的ul元素
var Divleft; // 提示框左边距
var Divtop; // 提示框上边距
var split = "  ";// 代码与全称（行政区划）的分隔符
var index = 0; // li元素索引
var tempInput = "";// 上次输入框值
var code;// 是否带出实际行政区划
var top="35";//高出的单元格高度

/**
 * 初始化变量
 * 
 * @param {}
 *            nameId（行政区划名称输入框）
 * @param {}
 *            codeId（行政区划代码隐藏域）
 * @param {}
 *            divId（提示框id）
 */
function initVars(obj, codeId, divId, codeStr) {
	// 初始化变量
	autoInput = obj;
	autoDiv = document.getElementById(divId);
	autoUl = autoDiv.childNodes[0];
	autoCode = codeId;
	Divleft = getLeft(autoInput);
	Divtop = getTop(autoInput) - top;
	code = codeStr;
}
function findDiv(obj, codeId, divId, codeIdStr) {
	var event = window.event;
	var key = event.keyCode;
	if (key == 38) { // 向上
		var li_elements = autoUl.childNodes;
		if (li_elements.length > 0 && index > 0) {
			changeStyle(li_elements[--index]);
		}
		return;
	} else if (key == 40) { // 向下
		var li_elements = autoUl.childNodes;
		if (li_elements.length > 0 && index < li_elements.length - 1) {
			changeStyle(li_elements[++index]);
		}
		return;
	} else if (key == 8 || key == 46 || (key <= 90 && key >= 48) || key == 32) {
		initVars(obj, codeId, divId, codeIdStr);
		var aResult = new Array(); // 用于存放匹配结果
		var input = autoInput.value;
		if (input.length > 0) {
			if (input != tempInput) {
				tempInput = input;
				autoLoad(autoInput.value);
			} else {
				var autoCompleteCity = L5.DatasetMgr.lookup("autoCompleteCity");
				setColors(autoCompleteCity);
			}
		} else {
			clearDiv(); // 无输入时清除提示框
		}
	} else if (key == 13) {
		clearDiv();
	}
}

function clearDiv() {
	if (autoDiv != null && autoDiv != "") {
		autoDiv.style.display = "none";
	}
}

function dataChangesFunction(autoCompleteCity) {
	// 显示提示框、传入的参数即为匹配出来的结果组成的数组
	var records = autoCompleteCity.getAllRecords();
	if (records.length == 0) {
		return;
	} else {
		// 清除提示内容
		for (var i = autoUl.childNodes.length - 1; i >= 0; i--)
			autoUl.removeChild(autoUl.childNodes[i]);
		setColors(autoCompleteCity);
	}
}

function setColors(autoCompleteCity) {
	var records = autoCompleteCity.getAllRecords();
	index = -1;
	autoDiv.style.left = Divleft;
	autoDiv.style.top = Divtop;
	var oLi;
	if (records.length != autoUl.childNodes.length) {
		for (var i = 0; i < records.length; i++) {
			// 将匹配的提示结果逐一显示给用户
			oLi = document.createElement("li");
			autoUl.appendChild(oLi);
			oLi.appendChild(document.createTextNode(records[i].get("ID")
					+ split + records[i].get("FULL_NAME")));

			oLi.onmouseover = function() {
				changeStyle(this); // 鼠标指针经过时高亮
			}
			/*
			 * oLi.onmouseout = function() { this.className = "mouseOut"; //
			 * 鼠标指针离开时恢复员样 }
			 */
			oLi.onclick = function() {
				// 用户单击某个匹配项时、设置输入框为该项的值
				sipValue(this);
				clearDiv(); // 同时清除提示框
			}
		}
	}
	autoDiv.className = "show";
	autoDiv.style.display = "block";
}

function autoLoad(input) {
	var autoCompleteCity = L5.DatasetMgr.lookup("autoCompleteCity");
	autoCompleteCity.setParameter("queryCode", input);
	autoCompleteCity.load();
	autoCompleteCity.on("load", dataChangesFunction);
}

// 获取元素的纵坐标
function getTop(e) {
	var offset = e.offsetTop;
	if (e.offsetParent != null)
		offset += getTop(e.offsetParent);
	return offset;
}
// 获取元素的横坐标
function getLeft(e) {
	var offset = e.offsetLeft;
	if (e.offsetParent != null)
		offset += getLeft(e.offsetParent);
	return offset;
}

function changeStyle(obj) {
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var li_elements = autoUl.childNodes;
	for (var i = 0; i < li_elements.length; i++) {
		if (li_elements[i] == obj) {
			li_elements[i].className = "mouseOver";
			sipValue(li_elements[i]);
			index = i;
		} else {
			li_elements[i].className = "mouseOut";
		}
	}
}

function sipValue(obj) {
	var values = obj.firstChild.nodeValue.split(split);
	autoInput.value = values[1];
	BaseinfoPeopleDataSet.set(autoCode, values[0]);
	if (code != "" && code != null && code.indexOf(":") != -1) {
		var codes = code.split(":");
		document.getElementById(codes[0]).value = values[1];
		BaseinfoPeopleDataSet.set(codes[1], values[0]);
	}
}
 

