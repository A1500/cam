var webObj;
var activeDocument;
var marksNames;

/**
 * 本方法 以实例的方式，约定说明模板、标签和数据的格式
 */
function init() {
	// 取得文件名 和标签
	var nowFileName = "cemeprofitCheckPrint.doc";
	// marksNames = "name1__1&code1__1"; 标签定义格式 字段代码 + __ + 序号
	// 打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap = new L5.Map("java.util.HashMap");

	var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCmd");
	command.setParameter("CEME_ID", cemeId);
	command.execute("queryForJYPrint");
	var str = command.getReturn("str");
	var findArray = str.split("%%");

	serviceScope = findArray[0];
	app = findArray[1];

	showMap.put("serviceScope", serviceScope);
	showMap.put("app", app);

	var command1 = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCheckCmd");
	command1.setParameter("APPLY_ID", applyId);
	command1.execute("queryForJYPrint");
	var addstr = command1.getReturn("addstr");

	var findArr = addstr.split("$$");

	cemeName = findArr[0];
	manaLevel = findArr[1];
	unitProperties = findArr[2];
	cemeId = findArr[3];
	organizer = findArr[4];
	prop = findArr[5];
	legalPerson = findArr[6];
	totalStaff = findArr[7];
	directorMobile = findArr[8];
	officePhone = findArr[9];
	fixeDassets = findArr[10];
	totalInvestment = findArr[11];
	gestionTime = findArr[12];
	postalcode = findArr[13];
	totalArea = findArr[14];
	builtArea = findArr[15];
	builtTotalArea = findArr[16];
	areaLevel = findArr[17];
	address = findArr[18];

	yearPeopleNum = findArr[19];
	sincePeopleNum = findArr[20];
	sellSingleHole = findArr[21];
	sellDoubleHole = findArr[22];
	sellMoreHole = findArr[23];
	yearSellNum = findArr[24];
	yearSingleHole = findArr[25];
	yearDoubleHole = findArr[26];
	yearMoreHole = findArr[27];
	yearHoleNum = findArr[28];
	outSingleHole = findArr[29];
	outDoubleHole = findArr[30];
	outMoreHole = findArr[31];
	yearOutNum = findArr[32];
	singleHole = findArr[33];
	doubleHole = findArr[34];
	moreHole = findArr[35];
	sinceHoleNum = findArr[36];
	notReasons = findArr[37];

	businesscertificateScore = findArr[38];
	businesscertificateReason = findArr[39];
	businesslicenseScore = findArr[40];
	businesslicenseReason = findArr[41];
	taxcertificateScore = findArr[42];
	taxcertificateReason = findArr[43];
	feeScore = findArr[44];
	feeReason = findArr[45];
	purchasegravesScore = findArr[46];
	purchasegravesReason = findArr[47];
	pledgeScore = findArr[48];
	pledgeReason = findArr[49];
	staffresponsibilitiesScore = findArr[50];
	staffresponsibilitiesReason = findArr[51];
	officeTimeScore = findArr[52];
	officeTimeReason = findArr[53];
	provincialdocumentsScore = findArr[54];
	provincialdocumentsReason = findArr[55];
	departmentchargesScore = findArr[56];
	departmentchargesReason = findArr[57];
	nooffenseScore = findArr[58];
	nooffenseReason = findArr[59];
	propergraveScore = findArr[60];
	propergraveReason = findArr[61];
	boxesandbagsScore = findArr[62];
	boxesandbagsReason = findArr[63];
	deathcertificateScore = findArr[64];
	deathcertificateReason = findArr[65];
	ashescontractScore = findArr[66];
	ashescontractReason = findArr[67];
	contractorssignatureScore = findArr[68];
	contractorssignatureReason = findArr[69];
	contractoridScore = findArr[70];
	contractoridReason = findArr[71];
	addcontractScore = findArr[72];
	addcontractReason = findArr[73];
	othermaterialsScore = findArr[74];
	othermaterialsReason = findArr[75];
	tombstoneTwentyNum = findArr[76];
	tombstoneTwentyScore = findArr[77];
	tombstoneTwentyReason = findArr[78];
	tombstoneFiftyNum = findArr[79];
	tombstoneFiftyScore = findArr[80];
	tombstoneFiftyReason = findArr[81];
	tombstoneoverfiftyNum = findArr[82];
	tombstoneoverfiftyScore = findArr[83];
	tombstoneoverfiftyReason = findArr[84];
	operatingareaNum = findArr[85];
	operatingareaScore = findArr[86];
	operatingareaReason = findArr[87];
	archivesareaNum = findArr[88];
	archivesareaScore = findArr[89];
	archivesareaReason = findArr[90];
	officeareaNum = findArr[91];
	officeareaScore = findArr[92];
	officeareaReason = findArr[93];
	roadsafetyScore = findArr[94];
	roadsafetyReason = findArr[95];
	civilizationMemorialScore = findArr[96];
	civilizationMemorialReason = findArr[97];
	fireMemorialScore = findArr[98];
	fireMemorialReason = findArr[99];
	ecologyNum = findArr[100];
	ecologyScore = findArr[101];
	ecologyReason = findArr[102];
	greenCoverageNum = findArr[103];
	greenCoverageScore = findArr[104];
	greenCoverageReason = findArr[105];
	greenareaRatioNum = findArr[106];
	greenareaRatioScore = findArr[107];
	greenareaRatioReason = findArr[108];
	burialTombScore = findArr[109];
	burialTombReason = findArr[110];
	burialConformScore = findArr[111];
	burialConformReason = findArr[112];
	acceptanceComplianceScore = findArr[113];
	acceptanceComplianceReason = findArr[114];
	changeComplianceScore = findArr[115];
	changeComplianceReason = findArr[116];
	paymentCertificateScore = findArr[117];
	paymentCertificateReason = findArr[118];
	agenciesScore = findArr[119];
	agenciesReason = findArr[120];
	businessTrainingScore = findArr[121];
	businessTrainingReason = findArr[122];
	systemSoundScore = findArr[123];
	systemSoundReason = findArr[124];
	contingencyPlansScore = findArr[125];
	contingencyPlansReason = findArr[126];
	informationScore = findArr[127];
	informationReason = findArr[128];

	totalScore = findArr[129];
	annuareport = findArr[130];

	showMap.put("cemeName", cemeName);
	showMap.put("manaLevel", manaLevel);
	showMap.put("unitProperties", getUnit(unitProperties));
	showMap.put("cemeId", cemeId);
	showMap.put("organizer", organizer);
	showMap.put("prop", getProp(prop));
	showMap.put("legalPerson", legalPerson);
	showMap.put("totalStaff", totalStaff);
	showMap.put("directorMobile", directorMobile);
	showMap.put("officePhone", officePhone);
	showMap.put("fixeDassets", fixeDassets);
	showMap.put("totalInvestment", totalInvestment);
	showMap.put("gestionTime", gestionTime);
	showMap.put("postalcode", postalcode);
	showMap.put("totalArea", totalArea);
	showMap.put("builtArea", builtArea);
	showMap.put("builtTotalArea", builtTotalArea);
	showMap.put("areaLevel", areaLevel);
	showMap.put("address", address);

	showMap.put("yearPeopleNum", yearPeopleNum);
	showMap.put("sincePeopleNum", sincePeopleNum);
	showMap.put("sellSingleHole", sellSingleHole);
	showMap.put("sellDoubleHole", sellDoubleHole);
	showMap.put("sellMoreHole", sellMoreHole);
	showMap.put("yearSellNum", yearSellNum);
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
	showMap.put("notReasons", notReasons);

	showMap.put("businesscertificateScore", businesscertificateScore);
	showMap.put("businesscertificateReason", businesscertificateReason);
	showMap.put("businesslicenseScore", businesslicenseScore);
	showMap.put("businesslicenseReason", businesslicenseReason);
	showMap.put("taxcertificateScore", taxcertificateScore);
	showMap.put("taxcertificateReason", taxcertificateReason);
	showMap.put("feeScore", feeScore);
	showMap.put("feeReason", feeReason);
	showMap.put("purchasegravesScore", purchasegravesScore);
	showMap.put("purchasegravesReason", purchasegravesReason);
	showMap.put("pledgeScore", pledgeScore);
	showMap.put("pledgeReason", pledgeReason);
	showMap.put("staffresponsibilitiesScore", staffresponsibilitiesScore);
	showMap.put("staffresponsibilitiesReason", staffresponsibilitiesReason);
	showMap.put("officeTimeScore", officeTimeScore);
	showMap.put("officeTimeReason", officeTimeReason);
	showMap.put("provincialdocumentsScore", provincialdocumentsScore);
	showMap.put("provincialdocumentsReason", provincialdocumentsReason);
	showMap.put("departmentchargesScore", departmentchargesScore);
	showMap.put("departmentchargesReason", departmentchargesReason);
	showMap.put("nooffenseScore", nooffenseScore);
	showMap.put("nooffenseReason", nooffenseReason);
	showMap.put("propergraveScore", propergraveScore);
	showMap.put("propergraveReason", propergraveReason);
	showMap.put("boxesandbagsScore", boxesandbagsScore);
	showMap.put("boxesandbagsReason", boxesandbagsReason);
	showMap.put("deathcertificateScore", deathcertificateScore);
	showMap.put("deathcertificateReason", deathcertificateReason);
	showMap.put("ashescontractScore", ashescontractScore);
	showMap.put("ashescontractReason", ashescontractReason);
	showMap.put("contractorssignatureScore", contractorssignatureScore);
	showMap.put("contractorssignatureReason", contractorssignatureReason);
	showMap.put("contractoridScore", contractoridScore);
	showMap.put("contractoridReason", contractoridReason);
	showMap.put("addcontractScore", addcontractScore);
	showMap.put("addcontractReason", addcontractReason);
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
	showMap.put("operatingareaNum", operatingareaNum);
	showMap.put("operatingareaScore", operatingareaScore);
	showMap.put("operatingareaReason", operatingareaReason);
	showMap.put("archivesareaNum", archivesareaNum);
	showMap.put("archivesareaScore", archivesareaScore);
	showMap.put("archivesareaReason", archivesareaReason);
	showMap.put("officeareaNum", officeareaNum);
	showMap.put("officeareaScore", officeareaScore);
	showMap.put("officeareaReason", officeareaReason);
	showMap.put("roadsafetyScore", roadsafetyScore);
	showMap.put("roadsafetyReason", roadsafetyReason);
	showMap.put("civilizationMemorialScore", civilizationMemorialScore);
	showMap.put("civilizationMemorialReason", civilizationMemorialReason);
	showMap.put("fireMemorialScore", fireMemorialScore);
	showMap.put("fireMemorialReason", fireMemorialReason);
	showMap.put("ecologyNum", ecologyNum);
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
	showMap.put("acceptanceComplianceScore", acceptanceComplianceScore);
	showMap.put("acceptanceComplianceReason", acceptanceComplianceReason);
	showMap.put("changeComplianceScore", changeComplianceScore);
	showMap.put("changeComplianceReason", changeComplianceReason);
	showMap.put("paymentCertificateScore", paymentCertificateScore);
	showMap.put("paymentCertificateReason", paymentCertificateReason);
	showMap.put("agenciesScore", agenciesScore);
	showMap.put("agenciesReason", agenciesReason);
	showMap.put("businessTrainingScore", businessTrainingScore);
	showMap.put("businessTrainingReason", businessTrainingReason);
	showMap.put("systemSoundScore", systemSoundScore);
	showMap.put("systemSoundReason", systemSoundReason);
	showMap.put("contingencyPlansScore", contingencyPlansScore);
	showMap.put("contingencyPlansReason", contingencyPlansReason);
	showMap.put("informationScore", informationScore);
	showMap.put("informationReason", informationReason);

	showMap.put("totalScore", totalScore);
	showMap.put("annuareport", annuareport);

	getMarks();
	writeDoc(showMap);

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
function getUnit(value) {
	if (value == undefined || value == "")
		return "";
	var reStr = "";
	if (value == '1') {
		reStr = "全额拨款事业单位"
	} else if (value == '2') {
		reStr = "差额拨款事业单位"
	} else if (value == '3') {
		reStr = "自收自支事业单位"
	} else if (value == '4') {
		reStr = "企业"
	} else if (value == '5') {
		reStr = "其它"
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