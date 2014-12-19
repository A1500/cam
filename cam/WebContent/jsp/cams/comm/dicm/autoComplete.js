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
var searchCode;//查询字段code
var searchContent;//查询字段content

/**
 * 初始化变量
 * 
 * @param {}
 *            nameId（行政区划名称输入框）
 * @param {}
 *            codeId（行政区划代码隐藏域）
 * @param {}
 *            divId（提示框id）
 * @param {}
 *            searchCodeParm（查询出dataset需提取的code）
 * @param {}
 *            searchContentParm（查询出dataset需提取的content）
 *            
 */
function initVars(obj, codeId, divId, codeStr,searchCodeParm,searchContentParm,adjustTop) {
	// 初始化变量
	autoInput = obj;
	autoDiv = document.getElementById(divId);
	autoUl = autoDiv.childNodes[0];
	autoCode = codeId;
	Divleft = getLeft(autoInput);
	Divtop = getTop(autoInput)- adjustTop;
	code = codeStr;
	searchCode=searchCodeParm;
	searchContent=searchContentParm;
}

function findDiv(obj, codeId, divId, codeIdStr,dataSetName,queryFiled,searchCode,searchContent,adjustTop) {
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
		initVars(obj, codeId, divId, codeIdStr,searchCode,searchContent,adjustTop);
		var aResult = new Array(); // 用于存放匹配结果
		var input = autoInput.value;
		if (input.length > 0) {
			if (input != tempInput) {
				tempInput = input;
				autoLoad(autoInput.value,dataSetName,queryFiled);
			} else {
				var autoCompleteDataSet = L5.DatasetMgr.lookup(dataSetName);
				setColors(autoCompleteDataSet);
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
	
	if(document.getElementById(autoCode).value == '' ){
		autoInput.value = '' ;
	}
}

function dataChangesFunction(autoCompleteDataSet) {
	// 显示提示框、传入的参数即为匹配出来的结果组成的数组
	var records = autoCompleteDataSet.getAllRecords();
	if (records.length == 0) {
		return;
	} else {
		// 清除提示内容
		for (var i = autoUl.childNodes.length - 1; i >= 0; i--)
			autoUl.removeChild(autoUl.childNodes[i]);
		setColors(autoCompleteDataSet);
	}
}

function setColors(autoCompleteDataSet) {
	var records = autoCompleteDataSet.getAllRecords();
	index = -1;
	autoDiv.style.left = Divleft;
	autoDiv.style.top = Divtop;
	var oLi;
	if (records.length != autoUl.childNodes.length) {
		for (var i = 0; i < records.length; i++) {
			// 将匹配的提示结果逐一显示给用户
			oLi = document.createElement("li");
			autoUl.appendChild(oLi);
			oLi.appendChild(document.createTextNode(records[i].get(searchCode)
					+ split + records[i].get(searchContent)));
			
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
/**
*input 	输入的值
*dataSetName  dataset名称
*queryFiled 查询条件字段
**/
function autoLoad(input,dataSetName,queryFiled) {
	var autoCompleteDataSet = L5.DatasetMgr.lookup(dataSetName);
	autoCompleteDataSet.removeAll();
	if (autoDiv != null && autoDiv != "") {
		autoDiv.style.display = "none";
	}
	autoCompleteDataSet.setParameter(queryFiled, input);
	autoCompleteDataSet.load();
	autoCompleteDataSet.on("load", dataChangesFunction);
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
	//给页面code字段赋值
	document.getElementById(autoCode).value = values[0];
	if (code != "" && code != null && code.indexOf(":") != -1) {
		var codes = code.split(":");
		document.getElementById(codes[0]).value = values[1];
	}
}
 function findDiv2(obj, codeId, divId, codeIdStr,dataSetName,queryFiled1,queryFiled2,searchCode,searchContent,adjustTop) {
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
		initVars(obj, codeId, divId, codeIdStr,searchCode,searchContent,adjustTop);
		document.getElementById(autoCode).value = '';//去掉domicileCode的值
		var aResult = new Array(); // 用于存放匹配结果
		var input = autoInput.value;
		if (input.length > 0) {
			if (input != tempInput) {
				tempInput = input;
				//clearDiv(); // 无输入时清除提示框
				if(/^[a-zA-Z]*$/.test(autoInput.value))//字母
				{
				  autoLoad(autoInput.value,dataSetName,queryFiled1);
				}
				else if(/^[\u4e00-\u9fa5]*$/.test(autoInput.value))//汉字
				{
				 autoLoad(autoInput.value,dataSetName,queryFiled2);
				}
				
			} else {
				var autoCompleteDataSet = L5.DatasetMgr.lookup(dataSetName);
				setColors(autoCompleteDataSet);
			}
		} else {
			clearDiv(); // 无输入时清除提示框
		}
	} else if (key == 13) {
		clearDiv();
	}
}

