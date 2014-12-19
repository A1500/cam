function init() {
	L5.getCmp("baseGridPanel").show();
	L5.getCmp("disbilityGridPanel").hide();
	L5.getCmp("depentGridPanel").hide();
	L5.getCmp("demobilizedGridPanel").hide();
	L5.getCmp("demobilizeInelldGridPanel").hide();
	L5.getCmp("warGridPanel").hide();
	L5.getCmp("testedGridPanel").hide();
	L5.getCmp("countretiredsoldierGridPanel").hide();
	var form = L5.getCmp("form");
	form.el.dom.document.getElementById("objectState").disabled = "true";
	form.el.dom.document.getElementById("objectState").value = "2";
	
	var disabilityform = L5.getCmp("disabilityform");
	disabilityform.el.dom.document.getElementById("disabilityStateCode").disabled = "true";
	disabilityform.el.dom.document.getElementById("disabilityStateCode").value = "2";
	
	var dependantform = L5.getCmp("dependantform");
	dependantform.el.dom.document.getElementById("dependantDisabilityStateCode").disabled = "true";
	dependantform.el.dom.document.getElementById("dependantDisabilityStateCode").value = "2";
	
	var demobilizeform = L5.getCmp("demobilizeform");
	demobilizeform.el.dom.document.getElementById("bilizedObjectState").disabled = "true";
	demobilizeform.el.dom.document.getElementById("bilizedObjectState").value = "2";
	
	var demobilizedIllnessform = L5.getCmp("demobilizedIllnessform");
	demobilizedIllnessform.el.dom.document.getElementById("illnessObjectState").disabled = "true";
	demobilizedIllnessform.el.dom.document.getElementById("illnessObjectState").value = "2";
	
	var warform = L5.getCmp("warform");
	warform.el.dom.document.getElementById("warObjectState").disabled = "true";
	warform.el.dom.document.getElementById("warObjectState").value = "2";
	
	var testform = L5.getCmp("testform");
	testform.el.dom.document.getElementById("warStateCode").disabled = "true";
	testform.el.dom.document.getElementById("warStateCode").value = "2";
	
	/*var countretiredsoldierform = L5.getCmp("countretiredsoldierform");
	countretiredsoldierform.el.dom.document.getElementById("soldierObjectTypeName").disabled = "true";
	countretiredsoldierform.el.dom.document.getElementById("soldierObjectTypeName").value = "2";*/
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var bptNo = getParam("bptNo");
	var objectState = getParam("objectState");
	var objectType = getParam("bptObjectType");// 获取节点ID

	if (objectType == '1') {// 伤残
		BptPeopleDisabilityDataSet.setParameter("domicileCode",
				getParam("disabilityDomicileCode"));
		BptPeopleDisabilityDataSet.setParameter("name", getParam("name"));
		BptPeopleDisabilityDataSet.setParameter("idCard", getParam("idCard"));
		BptPeopleDisabilityDataSet.setParameter("domicileType",
				getParam("domicileType"));
		BptPeopleDisabilityDataSet.setParameter("disabilityStateCode",
				getParam("disabilityStateCode"));
		if (getParam("disabilityObjectType") != 1) {
			BptPeopleDisabilityDataSet.setParameter("disabilityTypeCode",
					getParam("disabilityObjectType"));
		}
		BptPeopleDisabilityDataSet.setParameter("disabilityLevelCode",
				getParam("disabilityLevelCode"));
		BptPeopleDisabilityDataSet.setParameter("disabilityCaseCode",
				getParam("disabilityCaseCode"));
		BptPeopleDisabilityDataSet.setParameter("disabilityGenusCode",
				getParam("disabilityGenusCode"));
		BptPeopleDisabilityDataSet.setParameter("disabilityWarCode",
				getParam("disabilityWarCode"));
		BptPeopleDisabilityDataSet.setParameter("organCode", organCode);
		BptPeopleDisabilityDataSet.setParameter("disabilityNo",
				getParam("disabilityNo"));
		BptPeopleDisabilityDataSet.load();
	} else if (objectType == '2') {// 三属
		DependantDataset.setParameter("domicileCode",
				getParam("dependantDomicileCode"));
		DependantDataset.setParameter("name", getParam("dependantName"));
		DependantDataset.setParameter("idCard", getParam("dependantIdCard"));
		DependantDataset.setParameter("domicileType",
				getParam("dependantDomicileType"));
		DependantDataset.setParameter("disabilityStateCode",
				getParam("dependantDisabilityStateCode"));
		if (getParam("dependantObjectType") != 2) {
			DependantDataset.setParameter("dependantTypeCode",
					getParam("dependantObjectType"));
		}
		DependantDataset.setParameter("dependantNo", getParam("dependantNo"));
		DependantDataset.setParameter("organCode", organCode);
		DependantDataset.load();

	} else if (objectType == '41') {// 在乡
		demobilizedDataSet.setParameter("domicileCode",
				getParam("demobilizeDomicileCode"));
		demobilizedDataSet.setParameter("name", getParam("bilizedName"));
		demobilizedDataSet.setParameter("idCard", getParam("bilizedIdCard"));
		demobilizedDataSet.setParameter("belongDate", getParam("belongDate"));
		demobilizedDataSet.setParameter("isKoreanwar", getParam("isKoreanwar"));
		demobilizedDataSet.setParameter("objectState",
				getParam("bilizedObjectState"));
		demobilizedDataSet.setParameter("domicileType",
				getParam("bilizedDomicileType"));
		demobilizedDataSet.setParameter("organCode", organCode);
		demobilizedDataSet.load();
	} else if (objectType == '42') {// 带病回乡退伍军人
		dsDemobilizeInelld.setParameter("domicileCode",
				getParam("illnessDomicileCode"));
		dsDemobilizeInelld.setParameter("name", getParam("illnessName"));
		dsDemobilizeInelld.setParameter("idCard", getParam("illnessIdCard"));
		dsDemobilizeInelld.setParameter("isWar", getParam("isWar"));
		dsDemobilizeInelld.setParameter("isInnuclear", getParam("isInnuclear"));
		dsDemobilizeInelld.setParameter("objectState",
				getParam("illnessObjectState"));
		dsDemobilizeInelld.setParameter("domicileType",
				getParam("illnessDomicileType"));
		dsDemobilizeInelld.setParameter("organCode", organCode);
		dsDemobilizeInelld.load();
	} else if (objectType == '5') {// 参战
		dataSetWar.setParameter("domicileCode", getParam("warDomicileCode"));
		dataSetWar.setParameter("name", getParam("warName"));
		dataSetWar.setParameter("idCard", getParam("warIdCard"));
		dataSetWar.setParameter("objectState", getParam("warObjectState"));
		dataSetWar.setParameter("domicileType", getParam("warDomicileType"));
		dataSetWar.setParameter("warTypeCode", getParam("warTypeCode"));
		dataSetWar.setParameter("organCode", organCode);
		dataSetWar.load();
	} else if (objectType == '6') {// 参试
		dataSetTested
				.setParameter("domicileCode", getParam("testDomicileCode"));
		dataSetTested.setParameter("name", getParam("testName"));
		dataSetTested.setParameter("idCard", getParam("testIdCard"));
		dataSetTested
				.setParameter("domicileType", getParam("testDomicileType"));
		dataSetTested.setParameter("warStateCode", getParam("warStateCode"));
		dataSetTested.setParameter("disabilityLevelCode",
				getParam("disabilityLevelCode"));
		dataSetTested.setParameter("organCode", organCode);
		dataSetTested.load();
	} else if (objectType == '8') {// 60周岁以上农村籍退役军人
		countretiredSoldierDataSet.setParameter("domicileCode",
				getParam("soldierDomicileCode"));
		countretiredSoldierDataSet.setParameter("organCode", organCode);
		countretiredSoldierDataSet
				.setParameter("name", getParam("soldierName"));
		countretiredSoldierDataSet.setParameter("idCard",
				getParam("soldierIdCard"));
		countretiredSoldierDataSet.setParameter("domicileType",
				getParam("soldierDomicileType"));
		countretiredSoldierDataSet.setParameter("isGuarant",
				getParam("isGuarant"));
		countretiredSoldierDataSet.setParameter("isFiveGuarant",
				getParam("isFiveGuarant"));
		countretiredSoldierDataSet.load();
	} else { // 全部显示
		dsBptObject.setParameter("domicileCode", domicileCode);
		dsBptObject.setParameter("name", name);
		dsBptObject.setParameter("idCard", idCard);
		dsBptObject.setParameter("objectState", objectState);
		dsBptObject.setParameter("objectType", getParam("objectType"));
		dsBptObject.setParameter("organCode", organCode);
		dsBptObject.setParameter("bptNo", bptNo);
		dsBptObject.load();
	}
}

function reset() {
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("marriageCode").value = "";
	document.getElementById("careerCode").value = "";
	document.getElementById("politicalCode").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("personalStatsTag").value = "";
	document.getElementById("bptNo").value = "";
}

function commit() {
	var basicInfoGrid;
	var objectType = '';
	if (document.getElementById("bptObjectType").value == '1') {
		basicInfoGrid = L5.getCmp('disbilityGridPanel');
		objectType = '11';
	} else if (document.getElementById("bptObjectType").value == '2') {
		basicInfoGrid = L5.getCmp('depentGridPanel');
		objectType = '21';
	} else if (document.getElementById("bptObjectType").value == '41') {
		basicInfoGrid = L5.getCmp('demobilizedGridPanel');
		objectType = '41';
	} else if (document.getElementById("bptObjectType").value == '42') {
		basicInfoGrid = L5.getCmp('demobilizeInelldGridPanel');
		objectType = '42';
	} else if (document.getElementById("bptObjectType").value == '5') {
		basicInfoGrid = L5.getCmp('warGridPanel');
		objectType = '51';
	} else if (document.getElementById("bptObjectType").value == '6') {
		basicInfoGrid = L5.getCmp('testedGridPanel');
		objectType = '61';
	} else if (document.getElementById("bptObjectType").value == '8') {
		basicInfoGrid = L5.getCmp('countretiredsoldierGridPanel');
		objectType = '81';
	} else {
		basicInfoGrid = L5.getCmp('baseGridPanel');
	}

	var selected = basicInfoGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要添加的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要添加选中的记录吗?', function(state) {
		if (state == "yes") {
			var baseinfos = [];
			for (var i = 0; i < selected.length; i++) {
				baseinfos[i] = selected[i];
				var birthday = getBirthByCode(baseinfos[i].get("ID_CARD"));
				baseinfos[i].set("birthday",birthday);
			}
			var command = new L5.Command("com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateCommand");
			command.setParameter("baseinfos", baseinfos);
			command.setParameter("beachId", idField);
			command.setParameter("objectType", objectType);
			command.execute("addDetails");
			if(!command.error){
				L5.Msg.alert('提示', "添加成功",function(){
					//window.close();
				});
			}
		} else {
			L5.Msg.alert("错误", command.error);
		}
	});
}
function cancel() {
	window.close();
}


function forHelp() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/bpt/comm/getselect_code.jsp?rootId="
							+ struId
							+ "&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1",
					"",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");

		// 获取优抚对象类别的值，然后判断是哪个查询页面,写入所属机构的值
		var type = getParam("bptObjectType");
		if (type == '1') {
			document.getElementById("disabilityDomicileCode").value = list[0];
			document.getElementById("disabilityDomicileName").value = list[1];
		} else if (type == '2') {
			document.getElementById("dependantDomicileCode").value = list[0];
			document.getElementById("dependantDomicileName").value = list[1];
		} else if (type == '41') {
			document.getElementById("demobilizeDomicileCode").value = list[0];
			document.getElementById("demobilizeDomicileName").value = list[1];
		} else if (type == '42') {
			document.getElementById("illnessDomicileCode").value = list[0];
			document.getElementById("illnessDomicileName").value = list[1];
		} else if (type == '5') {
			document.getElementById("warDomicileCode").value = list[0];
			document.getElementById("warDomicileName").value = list[1];
		} else if (type == '6') {
			document.getElementById("testDomicileCode").value = list[0];
			document.getElementById("testDomicileName").value = list[1];
		} else if (type == '8') {
			document.getElementById("soldierDomicileCode").value = list[0];
			document.getElementById("soldierDomicileName").value = list[1];
		} else {
			document.getElementById("domicileCode").value = list[0];
			document.getElementById("domicileName").value = list[1];
		}

	}
}

function forHelpOT() {
	var revalue = window
			.showModalDialog("../../dicobjecttype/dicobjecttype.jsp");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var listTypeId = list[0].split(",");

		/*
		 * 获取第一个数的第一位和最后一个数的第一位， 相等则是有相同的一个上级节点，反之则不是同一个上级节点
		 */
		var tistart = 0;// 第一个数的第一位
		var tiend = 0;// 最后一个数的第一位
		if (listTypeId.length != 0) {
			tistart = listTypeId[0].substring(0, 1);// 获取第一个数的第一位
			tiend = listTypeId[listTypeId.length - 1].substring(0, 1);// 获取最后一个数的第一位
		}
		if (listTypeId.length != 0 && tistart == tiend) {
			document.getElementById("bptObjectType").value = tistart;
			if (tistart == 1) {// 伤残
				document.getElementById("disabilityObjectTypeName").value = list[1];
				document.getElementById("disabilityObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").show();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").show();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 2) {// 三属
				document.getElementById("dependantObjectTypeName").value = list[1];
				document.getElementById("dependantObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").show();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").show();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (list[0] == 41) {// 在乡
				document.getElementById("bilizedObjectTypeName").value = list[1];
				document.getElementById("bilizedObjectType").value = list[0];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").show();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").show();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (list[0] == 42) {// 带病回乡
				document.getElementById("illnessObjectTypeName").value = list[1];
				document.getElementById("illnessObjectType").value = list[0];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").show();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").show();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 5) {// 参战
				document.getElementById("warObjectTypeName").value = list[1];
				document.getElementById("warObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").show();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").show();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 6) {// 参试
				document.getElementById("testObjectTypeName").value = list[1];
				document.getElementById("testObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").show();
				L5.getCmp("countretiredsoldierform").hide();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").show();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 8) {// 60周岁以上农村籍退役军人
				document.getElementById("soldierObjectTypeName").value = list[1];
				document.getElementById("soldierObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").show();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").show();
			} else {
				document.getElementById("objectType").value = list[0];
				document.getElementById("objectTypeName").value = list[1];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").show();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();

				L5.getCmp("baseGridPanel").show();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			}
		} else {
			document.getElementById("objectType").value = list[0];
			document.getElementById("objectTypeName").value = list[1];
			document.getElementById("bptObjectType").value = list[0];

			L5.getCmp("form").show();
			L5.getCmp("disabilityform").hide();
			L5.getCmp("dependantform").hide();
			L5.getCmp("demobilizeform").hide();
			L5.getCmp("demobilizedIllnessform").hide();
			L5.getCmp("warform").hide();
			L5.getCmp("testform").hide();
			L5.getCmp("countretiredsoldierform").hide();

			L5.getCmp("baseGridPanel").show();
			L5.getCmp("disbilityGridPanel").hide();
			L5.getCmp("depentGridPanel").hide();
			L5.getCmp("demobilizedGridPanel").hide();
			L5.getCmp("demobilizeInelldGridPanel").hide();
			L5.getCmp("warGridPanel").hide();
			L5.getCmp("testedGridPanel").hide();
			L5.getCmp("countretiredsoldierGridPanel").hide();
		}

	}
}

// 伤残等级
function forDisability() {
	var revalue = window
			.showModalDialog("../dicdisabilitylevel/dicdisabilitylevel.jsp");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");

		if (list[0] == 0) {
			// document.getElementById("disabilityLevelCode").value=list[0];
			document.getElementById("disabilityLevelCodeName").value = "所有伤残等级";
		} else {
			document.getElementById("disabilityLevelCode").value = list[0];
			document.getElementById("disabilityLevelCodeName").value = list[1];
		}

	}
}