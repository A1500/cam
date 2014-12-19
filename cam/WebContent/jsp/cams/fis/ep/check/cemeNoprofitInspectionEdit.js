var isReport = "0"; // 是否上报，默认为不上报

function init() {
	var infoDataSet = L5.DatasetMgr.lookup("infoDataSet");// 公墓基本信息
	var wfDs = L5.DatasetMgr.lookup("wfDs");
	var resultDs = L5.DatasetMgr.lookup("resultDs");
	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");
	var auditDataSet = L5.DatasetMgr.lookup("auditDataSet");
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");// 附件

	// 进度条
	L5.Msg.progress("加载数据", "进度条", "正在加载数据，请等待...");
	inte = setInterval(progressFunc, 500);

	if (wfId == "") {
		_tatal = 2;
		infoDataSet.setParameter("CEME_ID", cemeId);
		infoDataSet.setParameter("WF_ID", wfId);
		infoDataSet.setParameter("CHECK_NUM", checkNumber);
		infoDataSet.on("load", function() {
					if (infoDataSet.getCount() > 0) {
						infoDataSet.getAt(0).set("applyId", newApplyId);
						infoDataSet.getAt(0).set("wfId", newWfId);
					}
					_i++;
				});
		infoDataSet.load();

		wfDs.newRecord({
					"wfId" : newWfId,
					"checkYear" : checkYear,
					"checkNum" : checkNumber
				});

		resultDs.newRecord({
					"wfId" : newWfId,
					"resultId" : newResultId
				});

		scoreDataSet.newRecord();
		scoreDataSet.set("scoreId", newScoreId);
		scoreDataSet.set("applyId", newApplyId);

		// 分数合计及年检报告
		auditDataSet.newRecord();
		auditDataSet.set("auditId", newAuditId);
		auditDataSet.set("applyId", newApplyId);
		auditDataSet.set("secondUnit", orgName);
		auditDataSet.set("secondUnitId", orgCode);

		accessoriesDataSet.setParameter("applayId", (wfId == "")
						? newWfId
						: wfId);
		accessoriesDataSet.on("load", function() {
					_i++;
				});
		accessoriesDataSet.load();
	} else {
		_tatal = 6;
		infoDataSet.setParameter("CEME_ID", cemeId);
		infoDataSet.setParameter("APPLY_ID", endApplyId);
		infoDataSet.on("load", function() {
					_i++;
				});
		infoDataSet.load();

		scoreDataSet.setParameter("APPLY_ID", endApplyId);
		scoreDataSet.on("load", function() {
					_i++;
				});
		scoreDataSet.load();

		auditDataSet.setParameter("APPLY_ID", endApplyId);
		auditDataSet.on("load", function() {
					_i++;
				});
		auditDataSet.load();

		wfDs.setParameter("WF_ID", wfId);
		wfDs.on("load", function() {
					_i++;
				});
		wfDs.load();

		resultDs.setParameter("WF_ID", wfId);
		resultDs.on("load", function() {
					_i++;
				});
		resultDs.load();

		accessoriesDataSet.setParameter("applayId", (wfId == "")
						? newWfId
						: wfId);
		accessoriesDataSet.on("load", function() {
					_i++;
				});
		accessoriesDataSet.load();
	}

	var mainTabPanel = L5.getCmp("tab");
	mainTabPanel.setActiveTab(1);
	mainTabPanel.setActiveTab(3);
	mainTabPanel.setActiveTab(2);
	mainTabPanel.setActiveTab(0);

	var statisticalScore = L5.getCmp("statisticalScore");
	statisticalScore.on("activate", function() {
				getTotalScore();
				getopinion();
			});
}

function returnClick() {
	history.go(-1);
}

function reportClick() {
	isReport = "1";
	saveFun();
}

function saveClick() {
	isReport = "0";
	saveFun();
}

function saveFun() {
	var infoDataSet = L5.DatasetMgr.lookup("infoDataSet");// 公墓基本信息
	var infoRecord = infoDataSet.getCurrent();

	var wfRecord = L5.DatasetMgr.lookup("wfDs");// 公墓流程数据
	var wfRecord = wfDs.getCurrent();

	var resultDs = L5.DatasetMgr.lookup("resultDs");// 公墓年检结果数据
	var resultRecord = resultDs.getCurrent();

	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");// 公墓打分标准数据
	var scoreRecord = scoreDataSet.getCurrent();

	var auditDataSet = L5.DatasetMgr.lookup("auditDataSet");// 分数合计及年检报告
	var auditRecord = auditDataSet.getCurrent();

	if (infoRecord.get("yearPeopleNum") > infoRecord.get("sincePeopleNum")) {
		L5.Msg.alert("提示", "本年安葬总人数不能大于自使用至今安葬总人数！");
		return false;
	}

	if (auditRecord.get("secondTime") == '') {
		L5.Msg.alert("提示", "年检时间不能为空！");
		return false;
	}
	if (auditRecord.get("secondResult") == '') {
		L5.Msg.alert("提示", "年检结果不能为空！");
		return false;
	}
	if (auditRecord.get("annuareport") == '') {
		L5.Msg.alert("提示", "年检报告不能为空！");
		return false;
	}

	// 公墓基本信息数据保存校验
	var ds = L5.DatasetMgr.lookup("infoDataSet");
	var valid = ds.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", valid);
		return false;
	}
	// 打分项数据保存校验
	var ds = L5.DatasetMgr.lookup("scoreDataSet");
	var valid = ds.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", valid);
		return false;
	}
	// 分数合计及年检报告数据保存校验
	var ds = L5.DatasetMgr.lookup("auditDataSet");
	var valid = ds.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", valid);
		return false;
	}

	// 校验是否上传材料
	/*
	 * var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet"); var
	 * accessoriesType = L5.DatasetMgr.lookup("accessoriesType"); for (var i =
	 * 0; i < accessoriesDataSet.getCount(); i++) { var rec =
	 * accessoriesDataSet.getAt(i); if (rec.get("accessoriesName") == "") { var
	 * pos = accessoriesType.find("value", rec.get("code"), 0); var
	 * accessoriesName = accessoriesType.getAt(pos).get("text");
	 * L5.Msg.alert("提示", "校验未通过：\"" + accessoriesName + "\"需要上传"); return
	 * false; } }
	 */

	var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCheckCmd");
	command.setParameter("infoRecord", infoRecord);
	command.setParameter("wfRecord", wfRecord);
	command.setParameter("resultRecord", resultRecord);
	command.setParameter("scoreRecord", scoreRecord);
	command.setParameter("auditRecord", auditRecord);
	command.setParameter("isReport", isReport);

	if (wfId == "") {
		command.execute("insertNoProfitCheck");
	} else {
		if (isEdit == "0") {
			// 年检次数+1
			var newCheckNum = (parseInt(checkNumber) + 1) + "";
			wfRecord.set("checkNum", newCheckNum);

			// 当进行第一编辑的保存或上报时，需要重新添加一条子表数据
			infoRecord.set("applyId", newApplyId);

			scoreRecord.set("scoreId", newScoreId);
			scoreRecord.set("applyId", newApplyId);

			auditRecord.set("auditId", newAuditId);
			auditRecord.set("applyId", newApplyId);

			command.setParameter("isUpdate", "false");
		} else {
			command.setParameter("isUpdate", "true");
		}

		command.execute("updateNoProfitCheck");
	}
	if (!command.error) {
		L5.Msg.alert("提示", "保存成功", function() {
					history.go(-1);
				});
	} else {
		L5.Msg.alert("错误", command.error);
	}
}

/**
 * 上传
 */
function clickUploadFile() {

	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=", (wfId == "")
					? newWfId
					: wfId);

	accessoriesItemDataSet.load();
	var win = L5.getCmp("uploadList");
	win.show();
}

function click_upload() {
	var uploadGrid = L5.getCmp('uploadGrid');
	var selected = uploadGrid.getSelectionModel().getSelections();
	var record = selected[0];
	if (document.getElementById("files").value == "") {
		L5.Msg.alert("提示", "请选择要上传的附件");
		return false;
	};
	var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCheckCmd");
	command.setParameter("applyId", (wfId == "") ? newWfId : wfId);
	command.setParameter("note", document.getElementById("fileMess").value);
	command.setParameter("code", record.get("code"));
	command.setForm("form_content");
	command.execute("uploadSave");
	// 包含有大字段的异常判断
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("提示", "上传附件成功!", function() {
						var win = L5.getCmp("uploadWin");
						document.forms["form_content"].reset();
						win.hide();
						var accessoriesItemDataSet = L5.DatasetMgr
								.lookup("accessoriesItemDataSet");
						accessoriesItemDataSet.setParameter("CODE@=", record
										.get("code"));
						accessoriesItemDataSet.setParameter("ITEM_ID@=",
								(wfId == "") ? newWfId : wfId);
						accessoriesItemDataSet.load();
					});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}

// 增加上传附件
function addUploadFile() {
	var win = L5.getCmp("uploadWin");
	win.show();

}

function delUploadFile(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:clickDelete(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + '删除' + '</a>';
}

function clickDelete(index) {
	var record = accessoriesItemDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？', function(sure) {
		if (sure == "yes") {
			var accessoriesId = record.get("accessoriesId");
			var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCheckCmd");
			command.setParameter("id", accessoriesId);
			command.execute("delAccessoriesById");
			if (!command.error) {
				accessoriesItemDataSet.reload();
				// accessoriesDataSet.reload();
				L5.Msg.alert('提示', '删除成功！');
			} else {
				L5.Msg.alert("错误", command.error);
			}
		} else
			return;
	});
}

function closeUploadList() {
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", (wfId == "") ? newWfId : wfId);
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
	win.hide();
}

function scoreIsNotNull(id) {
	var score = document.getElementById(id).value;
	if (score == "" || score == undefined) {
		return false;
	}
	return true;
}

// 年检报告录入
function getopinion() {
	var auditDataSet = L5.DatasetMgr.lookup("auditDataSet");
	var auditRecord = auditDataSet.getCurrent();

	var a = "    ";
	var b;
	if (scoreIsNotNull("businesscertificateScore")
			&& Number(getscore("businesscertificateScore")) < 2) {
		b = 2 - Number(getscore("businesscertificateScore"));
		a += "在服务场所公开展示内容" + ",县级民政部门批准建设文件扣" + b + "分,扣分原因:"
				+ document.getElementById("businesscertificateReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("businesslicenseScore")
			&& Number(getscore("businesslicenseScore")) < 2) {
		b = 2 - Number(getscore("businesslicenseScore"));
		a += "在服务场所公开展示内容" + ",本公益性公墓管理章程扣" + b + "分,扣分原因:"
				+ document.getElementById("businesslicenseReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("purchasegravesScore")
			&& Number(getscore("purchasegravesScore")) < 1) {
		a += "在服务场所公开展示内容" + ",安葬(安放)墓穴(格位)的条件和程序扣1分,扣分原因:"
				+ document.getElementById("purchasegravesReason").value + ";  ";
	}
	if (scoreIsNotNull("feeScore") && Number(getscore("feeScore")) < 3) {
		b = 3 - Number(getscore("feeScore"));
		a += "在服务场所公开展示内容" + ",收费项目、收费标准、收费依据等价格公示内容扣" + b + "分,扣分原因:"
				+ document.getElementById("feeReason").value + ";  ";
	}
	if (scoreIsNotNull("pledgeScore") && Number(getscore("pledgeScore")) < 4) {
		b = 4 - Number(getscore("pledgeScore"));
		a += "在服务场所公开展示内容" + ",服务承诺扣" + b + "分,扣分原因:"
				+ document.getElementById("pledgeReason").value + ";  ";
	}
	if (scoreIsNotNull("staffresponsibilitiesScore")
			&& Number(getscore("staffresponsibilitiesScore")) < 1) {
		a += "在服务场所公开展示内容" + ",工作人员职责及照片、编号扣1分,扣分原因:"
				+ document.getElementById("staffresponsibilitiesReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("officeTimeScore")
			&& Number(getscore("officeTimeScore")) < 2) {
		b = 2 - Number(getscore("officeTimeScore"));
		a += "在服务场所公开展示内容" + ",服务时间、地点、电话和监督电话扣" + b + "分,扣分原因:"
				+ document.getElementById("officeTimeReason").value + ";  ";
	}
	if (scoreIsNotNull("boxesandbagsScore")
			&& Number(getscore("boxesandbagsScore")) < 3) {
		b = 3 - Number(getscore("boxesandbagsScore"));
		a += "墓穴(格位)档案管理" + ",使用全省统一的卷盒和卷袋扣" + b + "分,扣分原因:"
				+ document.getElementById("boxesandbagsReason").value + ";  ";
	}
	if (scoreIsNotNull("deathcertificateScore")
			&& Number(getscore("deathcertificateScore")) < 3) {
		b = 3 - Number(getscore("deathcertificateScore"));
		a += "墓穴(格位)档案管理" + ",有死亡证明或火化证明的复印件扣" + b + "分,扣分原因:"
				+ document.getElementById("deathcertificateReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("propergraveScore")
			&& Number(getscore("propergraveScore")) < 3) {
		b = 3 - Number(getscore("propergraveScore"));
		a += "墓穴(格位)档案管理" + ",有骨灰安放(葬)协议、补充签订的协议扣" + b + "分,扣分原因:"
				+ document.getElementById("propergraveReason").value + ";  ";
	}
	if (scoreIsNotNull("ashescontractScore")
			&& Number(getscore("ashescontractScore")) < 3) {
		b = 3 - Number(getscore("ashescontractScore"));
		a += "墓穴(格位)档案管理" + ",有丧事承办人签名的骨灰安放(葬)处理表扣" + b + "分,扣分原因:"
				+ document.getElementById("ashescontractReason").value + ";  ";
	}
	if (scoreIsNotNull("contractoridScore")
			&& Number(getscore("contractoridScore")) < 2) {
		b = 2 - Number(getscore("contractoridScore"));
		a += "墓穴(格位)档案管理" + ",有丧事承办人的有效身份证件复印件扣" + b + "分,扣分原因:"
				+ document.getElementById("contractoridReason").value + ";  ";
	}
	if (scoreIsNotNull("othermaterialsScore")
			&& Number(getscore("othermaterialsScore")) < 2) {
		b = 2 - Number(getscore("othermaterialsScore"));
		a += "墓穴(格位)档案管理" + ",有其他应当归档的材料扣" + b + "分,扣分原因:"
				+ document.getElementById("othermaterialsReason").value + ";  ";
	}
	if (scoreIsNotNull("tombstoneTwentyScore")
			&& Number(getscore("tombstoneTwentyScore")) < 3) {
		b = 3 - Number(getscore("tombstoneTwentyScore"));
		a += "墓穴建设" + ",墓穴面积或墓碑高度超过规定标准20%以下的个数扣" + b + "分,扣分原因:"
				+ document.getElementById("tombstoneTwentyReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("tombstoneFiftyScore")
			&& Number(getscore("tombstoneFiftyScore")) < 5) {
		b = 5 - Number(getscore("tombstoneFiftyScore"));
		a += "墓穴建设" + ",墓穴面积或墓碑高度超过规定标准20%至50%的个数扣" + b + "分,扣分原因:"
				+ document.getElementById("tombstoneFiftyReason").value + ";  ";
	}
	if (scoreIsNotNull("tombstoneoverfiftyScore")
			&& Number(getscore("tombstoneoverfiftyScore")) < 8) {
		b = 8 - Number(getscore("tombstoneoverfiftyScore"));
		a += "墓穴建设" + ",墓穴面积或墓碑高度超过规定标准50%以上的个数扣" + b + "分,扣分原因:"
				+ document.getElementById("tombstoneoverfiftyReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("roadsafetyScore")
			&& Number(getscore("roadsafetyScore")) < 3) {
		b = 3 - Number(getscore("roadsafetyScore"));
		a += "墓区管理" + ",道路畅通，安全防护措施到位扣" + b + "分,扣分原因:"
				+ document.getElementById("roadsafetyReason").value + ";  ";
	}
	if (scoreIsNotNull("civilizationMemorialScore")
			&& Number(getscore("civilizationMemorialScore")) < 5) {
		b = 5 - Number(getscore("civilizationMemorialScore"));
		a += "墓区管理" + ",有文明祭奠举措,无封建迷信活动扣" + b + "分,扣分原因:"
				+ document.getElementById("civilizationMemorialReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("fireMemorialScore")
			&& Number(getscore("fireMemorialScore")) < 3) {
		b = 3 - Number(getscore("fireMemorialScore"));
		a += "墓区管理" + ",允许明火祭奠的,设立固定明火祭奠设施、开设防火隔离带等措施,并经县（市、区）以上林业部门审批扣" + b
				+ "分,扣分原因:"
				+ document.getElementById("fireMemorialReason").value + ";  ";
	}

	if (scoreIsNotNull("ecologyScore") && Number(getscore("ecologyScore")) < 5) {
		b = 5 - Number(getscore("ecologyScore"));
		a += "墓区管理" + ",生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例扣" + b + "分,扣分原因:"
				+ document.getElementById("ecologyReason").value + ";  ";
	}

	if (scoreIsNotNull("greenCoverageScore")
			&& Number(getscore("greenCoverageScore")) < 5) {
		b = 5 - Number(getscore("greenCoverageScore"));
		a += "墓区管理" + ",绿化覆盖率扣" + b + "分,扣分原因:"
				+ document.getElementById("greenCoverageReason").value + ";  ";
	}

	if (scoreIsNotNull("greenareaRatioScore")
			&& Number(getscore("greenareaRatioScore")) < 5) {
		b = 5 - Number(getscore("greenareaRatioScore"));
		a += "墓区管理" + ",绿地面积和占总面积的比例扣" + b + "分,扣分原因:"
				+ document.getElementById("greenareaRatioReason").value + ";  ";
	}

	if (scoreIsNotNull("burialTombScore")
			&& Number(getscore("burialTombScore")) < 4) {
		b = 4 - Number(getscore("burialTombScore"));
		a += "墓区管理" + ",按照所购墓穴(格位)标准进行安葬或安放,无自行改建墓穴(格位)扣" + b + "分,扣分原因:"
				+ document.getElementById("burialTombReason").value + ";  ";
	}

	if (scoreIsNotNull("burialConformScore")
			&& Number(getscore("burialConformScore")) < 4) {
		b = 4 - Number(getscore("burialConformScore"));
		a += "公墓管理" + ",墓区建设地点和规模与申报材料相符扣" + b + "分,扣分原因:"
				+ document.getElementById("burialConformReason").value + ";  ";
	}
	if (scoreIsNotNull("nooffenseScore")
			&& Number(getscore("nooffenseScore")) < 3) {
		b = 3 - Number(getscore("nooffenseScore"));
		a += "公墓管理" + ",无违法出租或买卖墓穴(格位)现象扣" + b + "分,扣分原因:"
				+ document.getElementById("nooffenseReason").value + ";  ";
	}
	if (scoreIsNotNull("acceptanceComplianceScore")
			&& Number(getscore("acceptanceComplianceScore")) < 4) {
		b = 4 - Number(getscore("acceptanceComplianceScore"));
		a += "公墓管理" + ",新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定扣" + b + "分,扣分原因:"
				+ document.getElementById("acceptanceComplianceReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("changeComplianceScore")
			&& Number(getscore("changeComplianceScore")) < 2) {
		b = 2 - Number(getscore("changeComplianceScore"));
		a += "公墓管理" + ",公墓更名符合《山东省公墓管理办法》规定扣" + b + "分,扣分原因:"
				+ document.getElementById("changeComplianceReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("agenciesScore")
			&& Number(getscore("agenciesScore")) < 2) {
		b = 2 - Number(getscore("agenciesScore"));
		a += "公墓管理" + ",墓区管理机构的组建与申报报告相符扣" + b + "分,扣分原因:"
				+ document.getElementById("agenciesReason").value + ";  ";
	}
	if (scoreIsNotNull("businessTrainingScore")
			&& Number(getscore("businessTrainingScore")) < 2) {
		b = 2 - Number(getscore("businessTrainingScore"));
		a += "公墓管理" + ",工作人员参加省或设区的市人民政府民政部门组织的业务培训扣" + b + "分,扣分原因:"
				+ document.getElementById("businessTrainingReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("systemSoundScore")
			&& Number(getscore("systemSoundScore")) < 3) {
		b = 3 - Number(getscore("systemSoundScore"));
		a += "公墓管理" + ",公墓管理的各项规章制度健全扣" + b + "分,扣分原因:"
				+ document.getElementById("systemSoundReason").value + ";  ";
	}
	if (scoreIsNotNull("contingencyPlansScore")
			&& Number(getscore("contingencyPlansScore")) < 3) {
		b = 3 - Number(getscore("contingencyPlansScore"));
		a += "公墓管理" + ",有高峰应急预案扣" + b + "分,扣分原因:"
				+ document.getElementById("contingencyPlansReason").value
				+ ";  ";
	}
	auditRecord.set("annuareport", a);

}
// 合计数量
function getNum() {
	var infoDataSet = L5.DatasetMgr.lookup("infoDataSet");// 基本信息
	var infoRecord = infoDataSet.getCurrent();
	if (infoRecord != undefined) {
		var yearholeNum = Number(getscore("yearSingleHole"))
				+ Number(getscore("yearDoubleHole"))
				+ Number(getscore("yearMoreHole"));
		var yearoutNum = Number(getscore("outSingleHole"))
				+ Number(getscore("outDoubleHole"))
				+ Number(getscore("outMoreHole"));
		var sinceholeNum = Number(getscore("singleHole"))
				+ Number(getscore("doubleHole")) + Number(getscore("moreHole"));

		infoRecord.set("yearHoleNum", yearholeNum);
		infoRecord.set("yearOutNum", yearoutNum);
		infoRecord.set("sinceHoleNum", sinceholeNum);
	}
}
// 合计分数
function getTotalScore() {
	var auditDataSet = L5.DatasetMgr.lookup("auditDataSet");// 分数合计及年检报告
	var auditRecord = auditDataSet.getCurrent();
	if (auditRecord != undefined) {
		var score = Number(getscore("businesscertificateScore"))
				+ Number(getscore("businesslicenseScore"))
				+ Number(getscore("purchasegravesScore"))
				+ Number(getscore("feeScore"))
				+ Number(getscore("pledgeScore"))
				+ Number(getscore("staffresponsibilitiesScore"))
				+ Number(getscore("officeTimeScore"))
				+ Number(getscore("boxesandbagsScore"))
				+ Number(getscore("deathcertificateScore"))
				+ Number(getscore("propergraveScore"))
				+ Number(getscore("ashescontractScore"))
				+ Number(getscore("contractoridScore"))
				+ Number(getscore("othermaterialsScore"))
				+ Number(getscore("tombstoneTwentyScore"))
				+ Number(getscore("tombstoneFiftyScore"))
				+ Number(getscore("tombstoneoverfiftyScore"))
				+ Number(getscore("roadsafetyScore"))
				+ Number(getscore("civilizationMemorialScore"))
				+ Number(getscore("fireMemorialScore"))
				+ Number(getscore("ecologyScore"))
				+ Number(getscore("greenCoverageScore"))
				+ Number(getscore("greenareaRatioScore"))
				+ Number(getscore("burialTombScore"))
				+ Number(getscore("burialConformScore"))
				+ Number(getscore("nooffenseScore"))
				+ Number(getscore("acceptanceComplianceScore"))
				+ Number(getscore("changeComplianceScore"))
				+ Number(getscore("agenciesScore"))
				+ Number(getscore("businessTrainingScore"))
				+ Number(getscore("systemSoundScore"))
				+ Number(getscore("contingencyPlansScore"));
		auditRecord.set("totalScore", score);
	}
}

function getscore(id) {
	var score = document.getElementById(id).value;
	if (score == "" || score == undefined) {
		return 0;
	} else {
		return score;
	}
}

// 渲染下载
function downloadUploadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ accessoriesItemDataSet.indexOf(record) + '\')">' + '下载' + '</a>';
}

// 点击下载
function clickDownload(index) {
	var record = accessoriesItemDataSet.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=FIS_CEME_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}