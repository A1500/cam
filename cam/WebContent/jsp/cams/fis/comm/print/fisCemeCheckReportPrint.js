var webObj;
var activeDocument;
var marksNames;

/**
 * 本方法 以实例的方式，约定说明模板、标签和数据的格式
 */
function init() {
	// 取得文件名 和标签
	var nowFileName = "fisCemeCheckReport.doc";
	// marksNames = "name1__1&code1__1"; 标签定义格式 字段代码 + __ + 序号
	// 打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap = new L5.Map("java.util.HashMap");

	var printInfoDS = L5.DatasetMgr.lookup("printInfoDS");
	printInfoDS.setParameter("CEME_APPLY_ID", cemeId);
	printInfoDS.load();
	printInfoDS.on("load", function() {
		showMap.put("yearSinceHoleNum", printInfoDS.get("yearSinceHoleNum"));// 当年安葬墓穴数
		showMap.put("totalSinceHoleNum", printInfoDS.get("totalSinceHoleNum"));// 累计安葬墓穴数
		showMap.put("yearBoneAshNum", printInfoDS.get("yearBoneAshNum"));// 当年存放骨灰
		showMap.put("totalBoneAshNum", printInfoDS.get("totalBoneAshNum"));// 累计存放骨灰
		showMap.put("yearMaintenanceFee", printInfoDS.get("yearMaintenanceFee"));// 当年维护费缴纳
		showMap.put("yearOverproofHoleNum", printInfoDS.get("yearOverproofHoleNum"));// 当年安葬超标墓穴数
		if( printInfoDS.get("isSpeculation")=="0"){
			showMap.put("isSpeculation","有");// 有无炒卖行为
		}else{
			showMap.put("isSpeculation","无");// 有无炒卖行为
		}
		
	});
	var printDS = L5.DatasetMgr.lookup("printDS");
	printDS.setParameter("CEME_APPLY_ID", cemeId);
	printDS.load();
	printDS.on("load", function() {
		showMap.put("checkYear", printDS.get("checkYear"));// 当年安葬墓穴数
		showMap.put("secondAnnuareport", printDS.get("secondAnnuareport"));// 累计安葬墓穴数
		getMarks();
		writeDoc(showMap);
	});

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
			var marksStr = marks[i].split("_");
			//alert(marksStr[0]);
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
	//alert(marksNames);
}

function returnButton() {
	webObj = document.getElementById("webOfficeNt");
	webObj.close();
	window.close(); //如果本界面为独立窗口显示，可放开这个注释
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