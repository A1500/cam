var webObj;
var activeDocument;
var marksNames;
var docPath;
var photoId = "";
var applyId; // 打印后修改打印标示applyId
var applyFlag = false; // 打印后修改打印标示
var defaultPath = true; // 打印模板是否为默认路径
var obj = window.dialogArguments.document.getElementsByName("printMark"); // 获得name="printMark"的标签

function init() {
	var photoObj = window.dialogArguments.document
			.getElementById("printPhotoId"); // 照片id
	if (photoObj != null && photoObj.getAttribute("printMark") == "printMark") {
		photoId = obj.value;
	}
	ifEditPrintFlag();
	var pathObj = window.dialogArguments.document.getElementById("docPath"); // 获得模板路径
	if (pathObj != null && pathObj.getAttribute("printMark") == "printMark") {
		docPath = basePath + pathObj.value;
	}

	init_print();
}

// 是否修改打印标示
function ifEditPrintFlag() {
	var obj = window.dialogArguments.document
			.getElementById("ntkoPrintapplyId");
	if (obj != null) {
		if (obj.getAttribute("queryData") == "queryData") {
			applyId = obj.value;
			if (applyId != null && applyId != "") {
				applyFlag = true;
			}
		}
	}
}

function findMarkInPrint(markName) {
	for (var i = 0; i < obj.length; i++) {
		var elem = obj[i];
		if (elem.getAttribute("printMark") == "printMark") {
			if (elem.getAttribute("id") == markName) {
				return elem.value;
			}
		}
	}
}

/**
 * 获取模板路径（优抚打证路径可从数据库获得，如数据库中存在某单位的模板，则从服务器硬盘获取模板，则采用默认模板）
 * 
 * @return {}
 */
function bptQueryPath() {
	var result = docPath;
	var queryServiceType = window.dialogArguments.document
			.getElementById("bptQueryPathServiceType"); // 获取是否统一采用默认模板
	if (queryServiceType != null) { // 存在不同模板
		var query_type = queryServiceType.value;
		if (query_type != null && query_type != "") { // 查询数据库判断是否为默认路径
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCertTemplatesCommand");
			command.setParameter("serviceType", query_type);
			command.execute("queryPath");
			var ifdefault = command.getReturn("ifDefault");
			if (!ifdefault) { // 非默认路径
				var doc_path = command.getReturn("docPath");// 保存服务器硬盘的模板绝对路径
				if (doc_path != null && doc_path != "") {
					result = doc_path;
					defaultPath = false; // 设置默认路径标示为false
				}
			}
		}
	}
	return result;
}

/**
 * 本方法 以实例的方式，约定说明模板、标签和数据的格式
 */
function init_print() {
	var photoTable = "COM_PHOTO";
	if (photoId != null && photoId.length > 0) {
		photoTable = photoTable + "_" + photoId.substring(0, 6);
		photoPath += "table=" + photoTable
				+ "&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='" + photoId
				+ "'";
	} else {
		photoPath = "";
	}

	try {
		// 获得模板路径
		var nowFileName = bptQueryPath();

		webObj = document.getElementById("webOfficeNt");
		webObj.Titlebar = false;

		if (defaultPath) { // 为默认模板（即工程下模板）
			webObj.OpenFromURL(nowFileName); // 打开url地址文件模板
		} else { // 非默认模板（单位单独上传保存在服务器的模板）
			webObj.OpenFromURL(L5.webPath+"/bptCertDownload"+"?filePath="+nowFileName); // 打开本地文件模板
		}
		activeDocument = webObj.activeDocument;

		activeDocument.Application.ActiveWindow.View.ShowBookmarks = false;

		getMarks();
		writeDoc();
	} catch (e) {
	}
}

function writeDoc() {
	// 分割标签
	var marks = marksNames.split("&");

	// 遍历所有标签
	for (var i = 0; i < marks.length; i++) {
		// 分离标签和标记
		var marksStr = marks[i].split("__");

		// 获取标签值
		var bkmkObj = activeDocument.Bookmarks(marks[i]);

		// 向模板中写数据
		if (bkmkObj) {
			if (marksStr[0] == "photo") {
				try {
					if (photoPath != "" && photoPath != null) {
						webObj.ActiveDocument.Application.Selection.GoTo(-1, 0,
								0, bkmkObj);// 将光标移动到图片书签
						webObj.AddPicFromURL(photoPath, false, 0, 0, 1, 100, 0);
					}
				} catch (e) {
				}
			} else {
				var inputValue = findMarkInPrint(marksStr[0]);
				var saverange = bkmkObj.Range;
				if (inputValue != 'undefined') {
					saverange.Text = inputValue;
				}
			}
		}
	}
}

/**
 * 获得 模板中的标签并组成串 "name1__1&code1__1"; 标签定义格式 字段代码 + __ + 序号
 */
function getMarks() {
	marksNames = "";
	var count = activeDocument.Bookmarks.Count;
	for (var i = 1; i <= count; i++) {
		if (i < count) {
			marksNames = marksNames + activeDocument.Bookmarks(i).Name + "&";
		} else {
			marksNames = marksNames + activeDocument.Bookmarks(i).Name;
		}
	}
	// alert(marksNames);
}

function returnButton() {
	try {
		webObj.close();
		window.close(); // 如果本界面为独立窗口显示，可放开这个注释
	} catch (e) {
		window.close();
	}
}

/**
 * 打印（参数控制是前台打印还是后台打印）
 */
function printdoc(isBackground) {
	var oldPrintBackground;
	var oldPrintDrawingObjects;
	var objOptions;
	try {
		objOptions = activeDocument.Application.Options;
		oldPrintBackground = objOptions.PrintBackground;
		oldPrintDrawingObjects = objOptions.PrintDrawingObjects;
		objOptions.PrintBackground = isBackground;
		objOptions.PrintBackground = false;
		objOptions.PrintBackgrounds = false;
		objOptions.PrintDrawingObjects = true; // 设置不打印证照底板
	} catch (err) {
	};
	try {
		webObj.ActiveDocument.TrackRevisions = false;
		webObj.printout(true);
		alert(applyFlag);
		if (applyFlag) {
			editPrint();
		}
	} catch (e){
	};
	try {
		objOptions = activeDocument.Application.Options;
		objOptions.PrintBackground = oldPrintBackground;
		objOptions.PrintDrawingObjects = oldPrintDrawingObjects;
	} catch (err){
	};
}

//修改打印标志
function editPrint(){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("applyId", applyId);
	command.setParameter("printFlag", "1");
	alert("21345");
	command.execute("editPrintFlag");
}
