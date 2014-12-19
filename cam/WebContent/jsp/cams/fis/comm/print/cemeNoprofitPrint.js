var webObj;
var activeDocument;
var marksNames;

/**
 * 本方法 以实例的方式，约定说明模板、标签和数据的格式
 */
function init() {
	// 取得文件名 和标签
	var nowFileName = "cemeNoprofitPrint.doc";
	// marksNames = "name1__1&code1__1"; 标签定义格式 字段代码 + __ + 序号
	// 打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap = new L5.Map("java.util.HashMap");

	var printInfoDS = L5.DatasetMgr.lookup("printInfoDS");
	printInfoDS.setParameter("CEME_ID", cemeId);
	printInfoDS.load();
	printInfoDS.on("load", function() {
		showMap.put("cemeName", printInfoDS.get("CEME_NAME"));// 公墓名称
		showMap.put("organizer", printInfoDS.get("ORGANIZER"));// 主办单位
		showMap.put("cemeId", printInfoDS.get("CEME_ID"));// 公墓编号
		showMap.put("manaLevel", printInfoDS.get("MANA_LEVEL"));// 主管单位
		showMap.put("legalPerson", printInfoDS.get("LEGAL_PERSON"));// 公墓负责人
		showMap.put("prop", printInfoDS.get("PROP"));// 公墓性质
		showMap.put("areaLevel", printInfoDS.get("AREA_LEVEL"));// 所属区划
		showMap.put("directorMobile", printInfoDS.get("DIRECTOR_MOBILE"));// 公墓负责人手机
		showMap.put("gestionTime", printInfoDS.get("GESTION_TIME"));// 正式使用时间
		showMap.put("address", printInfoDS.get("ADDRESS"));// 公墓所在位置
		showMap.put("totalArea", printInfoDS.get("TOTAL_AREA"));// 公墓占地面积(亩)
		showMap.put("serviceScope", printInfoDS.get("SERVICE_SCOPE"));// 服务范围
		showMap.put("fundSources", getFund(printInfoDS.get("FUND_SOURCES")));// 资金来源

		var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCmd");
		command.setParameter("CEME_ID", cemeId);
		command.execute("queryForGYPrint");
		var str = command.getReturn("str");
		var findArray = str.split("%%");
		fundSources = findArray[0];
		serviceScope = findArray[1];
		app = findArray[2];
		showMap.put("app", app);

		getMarks();
		writeDoc(showMap);
	});

}
function getFund(value) {
	if (value == undefined || value == "")
		return "";
	var fundArr = value.split(",");
	var reStr = "";
	for (var i = 0; i < fundArr.length; i++) {
		// var index = jzlxDs.find("value",fundArr[i],0);
		for (var i = 0; i < fundArr.length; i++) {
			if (fundArr[i] == '1') {
				reStr += "财政拨款,"
			} else if (fundArr[i] == '2') {
				reStr += "上级部门拨款,"
			} else if (fundArr[i] == '3') {
				reStr += "自筹,"
			} else if (fundArr[i] == '4') {
				reStr += "福彩资助,"
			} else if (fundArr[i] == '5') {
				reStr += "其他,"
			}
		}
	}
	return reStr;
}
function writeDoc(mp) {
	// 遍历map的值
	for (var key in mp.map) {
		// var getMapMark = mp.get(key);
		// 分割标签
		var marks = marksNames.split("&");
		// 遍历所有标签
		for (var i = 0; i < marks.length; i++) {
			// 分离标签和标记
			var marksStr = marks[i].split("__");
			// 标签和预含义标签相等的场合
			if (marksStr[0] == key) {
				// 获取标签值
				var bkmkObj = activeDocument.Bookmarks(marks[i]);
				// 向模板中写数据
				if (bkmkObj) {
					var inputValue = mp.get(key);
					var saverange = bkmkObj.Range;
					saverange.Text = inputValue;
					// saverange.InsertBefore(""); //之前写内容
					// saverange.InsertAfter(""); //之后写内容
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
	webObj = document.getElementById("webOfficeNt");
	webObj.close();
	// window.close(); //如果本界面为独立窗口显示，可放开这个注释
}
/**
 * 打印（参数可以控制是前台打印还是后台打印）
 */
function printdoc(isBackground) {
	var oldOption;
	try {
		var objOptions = activeDocument.Application.Options;
		oldOption = objOptions.PrintBackground;
		objOptions.PrintBackground = isBackground;
	} catch (err) {
	};
	webObj.printout(true);
	try {
		var objOptions = activeDocument.Application.Options;
		objOptions.PrintBackground = oldOption;
	} catch (err) {
	};
}