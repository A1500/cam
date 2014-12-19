var webObj;
var activeDocument;
var marksNames;

/**
 * 本方法 以实例的方式，约定说明模板、标签和数据的格式
 */
function init() {
	// 取得文件名 和标签
	var nowFileName = "cemeNoprofitCheckPrint.doc";
	// marksNames = "name1__1&code1__1"; 标签定义格式 字段代码 + __ + 序号
	// 打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap = new L5.Map("java.util.HashMap");

	var command1 = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCmd");
	command1.setParameter("CEME_ID", cemeId);
	command1.execute("queryForGYPrint");
	var str = command1.getReturn("str");
	var findArray = str.split("%%");
	fundSources = findArray[0];
	serviceScope = findArray[1];
	str = findArray[2];
	showMap.put("fundSources", getFund(fundSources));
	showMap.put("serviceScope", serviceScope);
	showMap.put("app", str);

	var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCheckCmd");
	command.setParameter("APPLY_ID", applyId);
	command.execute("queryForPrint");
	var str = command.getReturn("str");
	var findArr = str.split("$$");

	cemeName = findArr[0];
	manaLevel = findArr[1];
	organizer = findArr[2];
	cemeId = findArr[3];
	legalPerson = findArr[4];
	prop = findArr[5];
	directorMobile = findArr[6];
	gestionTime = findArr[7];
	totalArea = findArr[8];
	areaLevel = findArr[9];
	address = findArr[10];

	yearPeopleNum = findArr[11];
	sincePeopleNum = findArr[12];
	yearSingleHole = findArr[13];
	yearDoubleHole = findArr[14];
	yearMoreHole = findArr[15];
	yearHoleNum = findArr[16];
	outSingleHole = findArr[17];
	outDoubleHole = findArr[18];
	outMoreHole = findArr[19];
	yearOutNum = findArr[20];
	singleHole = findArr[21];
	doubleHole = findArr[22];
	moreHole = findArr[23];
	sinceHoleNum = findArr[24];

	businesscertificateScore = findArr[25];
	businesscertificateReason = findArr[26];
	businesslicenseScore = findArr[27];
	businesslicenseReason = findArr[38];
	purchasegravesScore = findArr[29];
	purchasegravesReason = findArr[30];
	feeScore = findArr[31];
	feeReason = findArr[32];
	pledgeScore = findArr[33];
	pledgeReason = findArr[34];
	staffresponsibilitiesScore = findArr[35];
	staffresponsibilitiesReason = findArr[36];
	officeTimeScore = findArr[37];
	officeTimeReason = findArr[38];
	boxesandbagsScore = findArr[39];
	boxesandbagsReason = findArr[40];
	deathcertificateScore = findArr[41];
	deathcertificateReason = findArr[42];
	propergraveScore = findArr[43];
	propergraveReason = findArr[44];
	ashescontractScore = findArr[45];
	ashescontractReason = findArr[46];
	contractoridScore = findArr[47];
	contractoridReason = findArr[48];
	othermaterialsScore = findArr[49];
	othermaterialsReason = findArr[50];
	tombstoneTwentyNum = findArr[51];
	tombstoneTwentyScore = findArr[52];
	tombstoneTwentyReason = findArr[53];
	tombstoneFiftyNum = findArr[54];
	tombstoneFiftyScore = findArr[55];
	tombstoneFiftyReason = findArr[56];
	tombstoneoverfiftyNum = findArr[57];
	tombstoneoverfiftyScore = findArr[58];
	tombstoneoverfiftyReason = findArr[59];
	roadsafetyScore = findArr[60];
	roadsafetyReason = findArr[61];
	civilizationMemorialScore = findArr[62];
	civilizationMemorialReason = findArr[63];
	fireMemorialScore = findArr[64];
	fireMemorialReason = findArr[65];
	ecologyScore = findArr[66];
	ecologyReason = findArr[67];
	greenCoverageNum = findArr[68];
	greenCoverageScore = findArr[69];
	greenCoverageReason = findArr[70];
	greenareaRatioNum = findArr[71];
	greenareaRatioScore = findArr[72];
	greenareaRatioReason = findArr[73];
	burialTombScore = findArr[74];
	burialTombReason = findArr[75];
	burialConformScore = findArr[76];
	burialConformReason = findArr[77];
	nooffenseScore = findArr[78];
	nooffenseReason = findArr[79];
	acceptanceComplianceScore = findArr[80];
	acceptanceComplianceReason = findArr[81];
	changeComplianceScore = findArr[82];
	changeComplianceReason = findArr[83];
	agenciesScore = findArr[84];
	agenciesReason = findArr[85];
	businessTrainingScore = findArr[86];
	businessTrainingReason = findArr[87];
	systemSoundScore = findArr[88];
	systemSoundReason = findArr[89];
	contingencyPlansScore = findArr[90];
	contingencyPlansReason = findArr[91];
	ecologyNum = findArr[92];

	totalScore = findArr[93];
	annuareport = findArr[94];

	showMap.put("cemeName", cemeName);
	showMap.put("manaLevel", manaLevel);
	showMap.put("organizer", organizer);
	showMap.put("cemeId", cemeId);
	showMap.put("legalPerson", legalPerson);
	showMap.put("prop", getProp(prop));
	showMap.put("directorMobile", directorMobile);
	showMap.put("gestionTime", gestionTime);
	showMap.put("totalArea", totalArea);
	showMap.put("areaLevel", areaLevel);
	showMap.put("address", (address == 'null') ? "" : address);
	showMap.put("yearPeopleNum", yearPeopleNum);
	showMap.put("sincePeopleNum", sincePeopleNum);
	showMap.put("yearSingleHole", yearSingleHole);
	showMap.put("yearDoubleHole", yearDoubleHole);
	showMap.put("yearMoreHole", yearMoreHole);
	showMap.put("yearHoleNum", yearHoleNum);
	showMap.put("outSingleHole", outSingleHole);
	showMap.put("outDoubleHole", outDoubleHole);
	showMap.put("outMoreHole", outMoreHole);
	showMap.put("yearOutNum", yearOutNum);
	showMap.put("singleHole", singleHole);
	showMap.put("doubleHole", doubleHole);
	showMap.put("moreHole", moreHole);
	showMap.put("sinceHoleNum", sinceHoleNum);

	showMap.put("businesscertificateScore", businesscertificateScore);
	showMap.put("businesscertificateReason", businesscertificateReason);
	showMap.put("businesslicenseScore", businesslicenseScore);
	showMap.put("businesslicenseReason", businesslicenseReason);
	showMap.put("purchasegravesScore", purchasegravesScore);
	showMap.put("purchasegravesReason", purchasegravesReason);
	showMap.put("feeScore", feeScore);
	showMap.put("feeReason", feeReason);
	showMap.put("pledgeScore", pledgeScore);
	showMap.put("pledgeReason", pledgeReason);
	showMap.put("staffresponsibilitiesScore", staffresponsibilitiesScore);
	showMap.put("staffresponsibilitiesReason", staffresponsibilitiesReason);
	showMap.put("officeTimeScore", officeTimeScore);
	showMap.put("officeTimeReason", officeTimeReason);
	showMap.put("boxesandbagsScore", boxesandbagsScore);
	showMap.put("boxesandbagsReason", boxesandbagsReason);
	showMap.put("deathcertificateScore", deathcertificateScore);
	showMap.put("deathcertificateReason", deathcertificateReason);
	showMap.put("propergraveScore", propergraveScore);
	showMap.put("propergraveReason", propergraveReason);
	showMap.put("ashescontractScore", ashescontractScore);
	showMap.put("ashescontractReason", ashescontractReason);
	showMap.put("contractoridScore", contractoridScore);
	showMap.put("contractoridReason", contractoridReason);
	showMap.put("othermaterialsScore", othermaterialsScore);
	showMap.put("othermaterialsReason", othermaterialsReason);
	showMap.put("tombstoneTwentyNum", tombstoneTwentyNum);
	showMap.put("tombstoneTwentyScore", tombstoneTwentyScore);
	showMap.put("tombstoneTwentyReason", tombstoneTwentyReason);
	showMap.put("tombstoneFiftyNum", tombstoneFiftyNum);
	showMap.put("tombstoneFiftyScore", tombstoneFiftyScore);
	showMap.put("tombstoneFiftyReason", tombstoneFiftyReason);
	showMap.put("tombstoneoverfiftyNum", tombstoneoverfiftyNum);
	showMap.put("tombstoneoverfiftyScore", tombstoneoverfiftyScore);
	showMap.put("tombstoneoverfiftyReason", tombstoneoverfiftyReason);
	showMap.put("roadsafetyScore", roadsafetyScore);
	showMap.put("roadsafetyReason", roadsafetyReason);
	showMap.put("civilizationMemorialScore", civilizationMemorialScore);
	showMap.put("civilizationMemorialReason", civilizationMemorialReason);
	showMap.put("fireMemorialScore", fireMemorialScore);
	showMap.put("fireMemorialReason", fireMemorialReason);
	showMap.put("ecologyScore", ecologyScore);
	showMap.put("ecologyReason", ecologyReason);
	showMap.put("greenCoverageNum", greenCoverageNum);
	showMap.put("greenCoverageScore", greenCoverageScore);
	showMap.put("greenCoverageReason", greenCoverageReason);
	showMap.put("greenareaRatioNum", greenareaRatioNum);
	showMap.put("greenareaRatioScore", greenareaRatioScore);
	showMap.put("greenareaRatioReason", greenareaRatioReason);
	showMap.put("burialTombScore", burialTombScore);
	showMap.put("burialTombReason", burialTombReason);
	showMap.put("burialConformScore", burialConformScore);
	showMap.put("burialConformReason", burialConformReason);
	showMap.put("nooffenseScore", nooffenseScore);
	showMap.put("nooffenseReason", nooffenseReason);
	showMap.put("acceptanceComplianceScore", acceptanceComplianceScore);
	showMap.put("acceptanceComplianceReason", acceptanceComplianceReason);
	showMap.put("changeComplianceScore", changeComplianceScore);
	showMap.put("changeComplianceReason", changeComplianceReason);
	showMap.put("agenciesScore", agenciesScore);
	showMap.put("agenciesReason", agenciesReason);
	showMap.put("businessTrainingScore", businessTrainingScore);
	showMap.put("businessTrainingReason", businessTrainingReason);
	showMap.put("systemSoundScore", systemSoundScore);
	showMap.put("systemSoundReason", systemSoundReason);
	showMap.put("contingencyPlansScore", contingencyPlansScore);
	showMap.put("contingencyPlansReason", contingencyPlansReason);
	showMap.put("ecologyNum", ecologyNum);

	showMap.put("totalScore", totalScore);
	showMap.put("annuareport", annuareport);

	getMarks();
	writeDoc(showMap);

}

function getFund(value) {
	if (value == undefined || value == "")
		return "";
	var fundArr = value.split(",");
	var reStr = "";

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
	return reStr;
}

function getProp(value) {
	if (value == undefined || value == "")
		return "";
	var reStr = "";
	if (value == '1') {
		reStr = "公益性"
	} else if (value == '2') {
		reStr = "经营性"
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