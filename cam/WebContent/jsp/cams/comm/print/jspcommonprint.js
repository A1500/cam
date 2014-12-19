var webObj;
var activeDocument;
var marksNames;
var docPath;
var applyId; // 打印后修改打印标示applyId
var applyFlag = false; // 打印后修改打印标示
var defaultPath = true; // 打印模板是否为默认路径
function init() {
	docPath = basePath
			+ window.dialogArguments.document.getElementById("docpath").value; // word模板路径
	var scaconfPath = window.dialogArguments.document
			.getElementById("scaconfPath").value; // ScaComponentFactory.getService()获得具体IPrintDao实现类
	var methodObj = window.dialogArguments.document.getElementById("method");

	ifEditPrintFlag();

	var FormPrintDataSet = L5.DatasetMgr.lookup("FormPrintDataSet");

	if (methodObj != null) {
		FormPrintDataSet.setParameter("method", methodObj.value);
	}
	FormPrintDataSet.setParameter("scaconfPath", scaconfPath);
	sipQueryData(FormPrintDataSet);
	FormPrintDataSet.load();
	FormPrintDataSet.on("load", init_print);
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

function editPrint() {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("applyId", applyId);
	command.setParameter("printFlag", "1");
	command.execute("editPrintFlag");
}

function sipQueryData(ds) { // 查询条件赋值
	// var els =
	// L5.DomQuery.select("*[@queryData]",window.dialogArguments.document.body);
	var els = window.dialogArguments.document.getElementsByName("printQuery");
	for (var i = 0; i < els.length; i++) {
		var nodeName = els[i].nodeName.toLowerCase();
		var nodeType = els[i].getAttribute("type");
		var queryType = els[i].getAttribute("queryData");
		if (nodeName == "input" && nodeType == "hidden"
				&& queryType == "queryData") {
			var tagId = els[i].getAttribute("id");
			var value = els[i].getAttribute("value");
			ds.setParameter(tagId, value);
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
			.getElementById("bptQueryPathServiceType"); //获取是否统一采用默认模板
	if (queryServiceType != null) { //存在不同模板
		var query_type = queryServiceType.value;
		if (query_type != null && query_type != "") { //查询数据库判断是否为默认路径
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCertTemplatesCommand");
			command.setParameter("serviceType", query_type);
			command.execute("queryPath");
			var ifdefault = command.getReturn("ifDefault");
			if (!ifdefault) { //非默认路径
				var doc_path = command.getReturn("docPath");//保存服务器硬盘的模板绝对路径
				if (doc_path != null && doc_path != "") {
					result = doc_path;
					defaultPath = false; //设置默认路径标示为false
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
	var photoId = "";
	if (FormPrintDataSet.getCount() > 0) {
		photoId = FormPrintDataSet.get("PHOTO_ID");
	}
	var photoTable = "COM_PHOTO";
	if (photoId != null && photoId.length > 0) {
		photoTable = photoTable + "_" + photoId.substring(0, 6);
		photoPath += "table=" + photoTable + "&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='" + photoId + "'";
	} else {
		photoPath = "";
	}

	try {
		// 获得模板路径
		var nowFileName = bptQueryPath();
		webObj = document.getElementById("webOfficeNt");
		webObj.Titlebar = false;
		if (defaultPath) { //为默认模板（即工程下模板）
			webObj.OpenFromURL(nowFileName); // 打开url地址文件模板
		} else { //非默认模板（单位单独上传保存在服务器的模板）
			webObj.OpenFromURL(L5.webPath+"/bptCertDownload"+"?filePath="+nowFileName);
			//webObj.OpenLocalFile(nowFileName); // 打开本地文件模板
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
				if (FormPrintDataSet.getCount() > 0) {
					var inputValue = FormPrintDataSet.get(marksStr[0]
							.toUpperCase());
					var saverange = bkmkObj.Range;
					if (inputValue != 'undefined') {
						saverange.Text = inputValue;
					}
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
		objOptions.PrintBackground = false;
		objOptions.PrintBackgrounds = false;
		objOptions.PrintDrawingObjects = true; // 设置不打印证照底板
	} catch (err) {
	};
	try {
		webObj.ActiveDocument.TrackRevisions = false;
		webObj.printout(true);
		if (applyFlag) {
			editPrint();
		}
	} catch (e) {
	};
	try {
		objOptions = activeDocument.Application.Options;
		objOptions.PrintBackground = oldPrintBackground;
		objOptions.PrintDrawingObjects = oldPrintDrawingObjects;
	} catch (err) {
	};
}

// 打印预览
function printdocView(){
	webObj = document.getElementById("webOfficeNt");
	webObj.object.PrintPreview();
}
