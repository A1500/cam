var isSave="";
function init(){
	//激活tab页
	var tabPanel = L5.getCmp("tabPanel");
	tabPanel.setActiveTab(1);
	tabPanel.setActiveTab(2);
	tabPanel.setActiveTab(3);
	tabPanel.setActiveTab(0);
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");//公墓信息

	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");//打分
	
	var daFenDataset = L5.DatasetMgr.lookup("daFenDataset");//业务
	
	var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	//平查业务表，查询当前单位下的年检业务记录
	var applyDs = L5.DatasetMgr.lookup("applyDs");
	applyDs.setParameter("FILL_ORGAN_CODE",organCode);
	applyDs.setParameter("APPLY_FLAG","A");
	applyDs.load(true);
	
	var accessoriesDataSet = L5.DatasetMgr.lookup("accessoriesDataSet");
	accessoriesDataSet.setParameter("applayId", (cemeApplyId=="null") ? newCemeApplyId : cemeApplyId);
	accessoriesDataSet.setParameter("code","A");
	accessoriesDataSet.load(true);
	
	if(method == "UPDATE"){
		document.getElementById("imgs").style.display = 'none';
		daFenDataset.setParameter("CEME_APPLY_ID",cemeApplyId);
		daFenDataset.load(true);
		
		scoreDataSet.setParameter("SCORE_ID",scoreId);
		scoreDataSet.load(true);
		
		historyDataSet.setParameter("CEME_APPLY_ID",cemeApplyId);
		historyDataSet.load(true);
		
		CemeInfoDs.setParameter("ORGAN_ID",organId);
		CemeInfoDs.load(true);
		
		
	}
	if(method == "INSERT"){
		historyDataSet.newRecord();
		historyDataSet.set("hisId",newHisId);
		historyDataSet.set("cemeApplyId", newCemeApplyId);
		
		
		scoreDataSet.newRecord();
		scoreDataSet.set("scoreId", newScoreId);
		scoreDataSet.set("cemeApplyId", newCemeApplyId);
		
		daFenDataset.newRecord();
		daFenDataset.set("cemeApplyId", newCemeApplyId);
		//CemeInfoDs.load(true);
		CemeInfoDs.newRecord(); 
	}
	//
	if(organType == "13"){
		document.getElementById("sjdiv").style.display="none";
	}
	else if(organType == "12"){
		document.getElementById("xjdiv").style.display="none";
	}
	
	var statisticalScore = L5.getCmp("statisticalScore");
	statisticalScore.on("activate", function() {
				getTotalScore();
				getopinion();
			});
	
}
//单击返回按钮
function returnClick(){
	if(method == 'INSERT'){
		if(!(isSave=="true")){
			var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeAccessoriesCmd");
			command.setParameter("itemId",newCemeApplyId);
			command.execute("deleteAll");
		}
	}
	history.go(-1);
}

//单击保存按钮
function saveClick() {
	saveFun();
}

function saveFun(){

	
	
	//年检报告数据保存校验
	var ds1 = L5.DatasetMgr.lookup("daFenDataset");
	var valid = ds1.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", valid);
		return false;
	}
	
	var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");//历史记录表
	var historyRecord = historyDataSet.getCurrent();
	
	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");// 公墓打分标准数据
	var scoreRecord = scoreDataSet.getCurrent();
	
	var daFenDataset = L5.DatasetMgr.lookup("daFenDataset");// 分数合计及年检报告
	var daFenRecord = daFenDataset.getCurrent();
	
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
	var cemeRecord = CemeInfoDs.getCurrent();
	if(method == "INSERT"){
		if(cemeRecord.get("recordId")==""){
			L5.Msg.alert('提示', "您还没有选择要检查的公墓！");
			return false;
		}
	}
	// 打分项数据保存校验
	
	var ds = L5.DatasetMgr.lookup("scoreDataSet");
	var valid = ds.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", valid);
		return false;
	}
	
	if(Number(getscore("firstTotalScore"))>100){
		L5.Msg.alert("提示", "总分不合理，请重新打分！");
		return false;
	}
	if(organType == "13"){
		if (daFenRecord.get("firstTime") == '') {
			L5.Msg.alert("提示", "县级检查时间不能为空！");
			return false;
		}
		if (daFenRecord.get("firstResult") == '') {
			L5.Msg.alert("提示", "县级检查结果不能为空！");
			return false;
		}
	}
	if(organType == "12"){
		if (daFenRecord.get("secondTime") == '') {
			L5.Msg.alert("提示", "市级检查时间不能为空！");
			return false;
		}
		if (daFenRecord.get("secondResult") == '') {
			L5.Msg.alert("提示", "市级检查结果不能为空！");
			return false;
		}
	}
	
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	if(method == "INSERT"){
		
		daFenRecord.set("recordId",cemeRecord.get("recordId"));
		daFenRecord.set("applyFlag","A");
		
		//当前处理单位(未上报)
		daFenRecord.set("curOrganCode",organCode);
		daFenRecord.set("curOrgan",organName);
		//当前填报单位
		daFenRecord.set("fillOrganCode",organCode);
		daFenRecord.set("fillOrganName",organName);
		//插入历史记录表  发起页面创建历史记录
		historyRecord.set("recordId",cemeRecord.get("recordId"));
		if(organType == "13"){//县级
			historyDataSet.set("createTime", createTime);
			historyRecord.set("firstUnit",organName);
			historyRecord.set("firstUnitId",organCode);
			historyRecord.set("firstTime",daFenRecord.get("firstTime"));
			historyRecord.set("firstOpinion",daFenRecord.get("firstOpinion"));
			historyRecord.set("firstResult",daFenRecord.get("firstResult"));
			historyRecord.set("isReport","0");
			historyRecord.set("checkResult","0");
			daFenRecord.set("recTime",document.getElementById("firstTime").value);
			daFenRecord.set("curActivity","县级检查");
			daFenRecord.set("isReport","4");//上报状态0:县级上报 4:未上报
			if(prop == "1"){//公益性 直接出年检结果
				if(daFenRecord.get("firstResult") == "1"){//合格
					daFenRecord.set("applyState","1");//业务状体1:检查通过
				}
				if(daFenRecord.get("firstResult") == "2"){//不合格
					daFenRecord.set("applyState","5");//业务状体5:检查未通过
				}
				daFenRecord.set("checkResult",daFenRecord.get("firstResult"));//年检结果
				historyRecord.set("checkResult",daFenRecord.get("firstResult"));//年检结果
			}else{
				if(daFenRecord.get("firstResult") == "1"){//合格
					daFenRecord.set("applyState","1");//业务状体1:检查通过
				}
				if(daFenRecord.get("firstResult") == "2"){//合格
					daFenRecord.set("applyState","5");//业务状体5:检查未通过
				}
				daFenRecord.set("checkResult","0");//未参检
			}
			
			daFenRecord.set("firstUnitId",organCode);//县级审核单位
			daFenRecord.set("firstUnit",organName);
		}
		if(organType == "12"){//市级
			historyDataSet.set("createTime", createTime);
			historyRecord.set("secondUnit",organName);
			historyRecord.set("secondUnitId",organCode);
			historyRecord.set("secondTime",daFenRecord.get("secondTime"));
			historyRecord.set("secondAnnuareport",daFenRecord.get("secondAnnuareport"));
			historyRecord.set("secondResult",daFenRecord.get("secondResult"));
			historyRecord.set("isReport","1");
			daFenRecord.set("secondUnit",organName);
			daFenRecord.set("secondUnitId",organCode);
			daFenRecord.set("isReport","10");//市级未上报
			daFenRecord.set("curActivity","市级审批");
			daFenRecord.set("recTime",daFenRecord.get("secondTime"));
			if(daFenRecord.get("secondResult") == "1"){//合格
				daFenRecord.set("applyState","3");//将业务状态改成审批通过
				daFenRecord.set("checkResult","1");//合格
				historyRecord.set("checkResult","1");//合格
			}
			if(daFenRecord.get("secondResult") == "2"){//不合格
				daFenRecord.set("applyState","4");//将业务状态改成审批不通过
				daFenRecord.set("checkResult","2");//不合格
				historyRecord.set("checkResult","2");//不合格
			}
			//daFenRecord.set("firstUnitId",organCode);//县级审核单位
			//daFenRecord.set("firstUnit",organName);
		}
		command.setParameter("daFenRecord", daFenRecord);
		command.setParameter("scoreRecord",scoreRecord);
		command.setParameter("historyRecord",historyRecord);
		command.execute("insertAll");
		if (!command.error) {
			L5.Msg.alert("提示", "保存成功", function() {
					isSave="true";
					history.go(-1);
				});
		} else {
			L5.Msg.alert('提示', "保存时出现错误！" + command.error);
		}
	}else if(method == "UPDATE"){
		//如果是更新保存
		if(organType == "13"){
			historyRecord.set("firstTime",daFenRecord.get("firstTime"));
			historyRecord.set("firstOpinion",daFenRecord.get("firstOpinion"));
			historyRecord.set("firstResult",daFenRecord.get("firstResult"));
			if(daFenRecord.get("firstResult") == "1"){//合格
				daFenRecord.set("applyState","1");//业务状体1:检查通过
				if(prop == "1"){//公益性直接出结果
					daFenRecord.set("checkResult","1");//年检结果
					historyRecord.set("checkResult","1");//年检结果
				}
			}
			if(daFenRecord.get("firstResult") == "2"){//不合格
				daFenRecord.set("applyState","5");//业务状体5:检查未通过
				if(prop == "1"){
					daFenRecord.set("checkResult","2");//年检结果
					historyRecord.set("checkResult","2");//年检结果
				}
			}
		}
		if(organType == "12"){
			historyRecord.set("secondTime",daFenRecord.get("secondTime"));
			historyRecord.set("secondAnnuareport",daFenRecord.get("secondAnnuareport"));
			historyRecord.set("secondResult",daFenRecord.get("secondResult"));
			if(daFenRecord.get("secondResult") == "1"){//合格
				daFenRecord.set("applyState","3");//将业务状态改成审批通过
				daFenRecord.set("checkResult","1");//合格
				historyRecord.set("checkResult","1");//合格
			}
			if(daFenRecord.get("secondResult") == "2"){//不合格
				daFenRecord.set("applyState","4");//将业务状态改成审批不通过
				daFenRecord.set("checkResult","2");//不合格
				historyRecord.set("checkResult","2");//不合格
			}
		}
		command.setParameter("daFenRecord", daFenRecord);
		command.setParameter("scoreRecord",scoreRecord);
		command.setParameter("historyRecord", historyRecord);
		command.setParameter("method","faQiUpdate");
		command.execute("updateAll");
		if (!command.error) {
			L5.Msg.alert('提示', "保存成功!", function() {
				history.go(-1);
			});
		} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
	}
}

//校验数字+越界
function checkNum(domId){
	if(document.getElementById(domId).value){
		if(!_isNum(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}else if(Number(document.getElementById(domId).value)>Number(document.getElementById(domId+"Limit").innerHTML)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","输入分数超过限定值，请重新输入");
			return;
		}
	}
}
//只校验数字
function checkNumOnly(domId){
	if(document.getElementById(domId).value){
		if(!_isNum(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
	}
}
//小数点位数处理
function checkAssMon(domId){
	if(document.getElementById(domId).value){
		if(!isFloat(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
		document.getElementById(domId).value=changeTwoDecimal(document.getElementById(domId).value);
	}
}
//手机号码校验
function isMTel(s){
	return /^1(3\d|(58|59|56|52|53|50|51|80|85|86|87|88|89))\d{8}$/g.test(s);
}
//手机号码校验
function checkMobile(domId){
   if(document.getElementById(domId).value){
		if(!isMTel(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入正确的手机号码");
			return;
		}
	}
}
//联系电话校验
function checkTel(domId){
  if(document.getElementById(domId).value){
		if(!isTel(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入正确的联系电话");
			return;
		}
	}
}

//邮政编码校验
function checkpostalcode(domId){
   if(document.getElementById(domId).value){
		if(!_isPostCode(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入正确的邮政编码");
			return;
		}
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
function getTotalScore() {
	var daFenDataset = L5.DatasetMgr.lookup("daFenDataset");// 分数合计及年检报告
	var daFenRecord = daFenDataset.getCurrent();
	if (daFenRecord != undefined) {
		var score = Number(getscore("businesscertificateScore"))
				+ Number(getscore("businesslicenseScore"))
				+ Number(getscore("taxcertificateScore"))
				+ Number(getscore("feeScore"))
				+ Number(getscore("purchasegravesScore"))
				+ Number(getscore("pledgeScore"))
				+ Number(getscore("staffresponsibilitiesScore"))
				+ Number(getscore("officeTimeScore"))
				+ Number(getscore("provincialdocumentsScore"))
				+ Number(getscore("departmentchargesScore"))
				+ Number(getscore("nooffenseScore"))
				+ Number(getscore("propergraveScore"))
				+ Number(getscore("boxesandbagsScore"))
				+ Number(getscore("deathcertificateScore"))
				+ Number(getscore("ashescontractScore"))
				+ Number(getscore("contractorssignatureScore"))
				+ Number(getscore("contractoridScore"))
				+ Number(getscore("addcontractScore"))
				+ Number(getscore("othermaterialsScore"))
				+ Number(getscore("tombstoneTwentyScore"))
				+ Number(getscore("tombstoneFiftyScore"))
				+ Number(getscore("tombstoneoverfiftyScore"))
				+ Number(getscore("operatingareaScore"))
				+ Number(getscore("archivesareaScore"))
				+ Number(getscore("officeareaScore"))
				+ Number(getscore("roadsafetyScore"))
				+ Number(getscore("civilizationMemorialScore"))
				+ Number(getscore("fireMemorialScore"))
				+ Number(getscore("ecologyScore"))
				+ Number(getscore("greenCoverageScore"))
				+ Number(getscore("greenareaRatioScore"))
				+ Number(getscore("burialTombScore"))
				+ Number(getscore("burialConformScore"))
				+ Number(getscore("acceptanceComplianceScore"))
				+ Number(getscore("changeComplianceScore"))
				+ Number(getscore("paymentCertificateScore"))
				+ Number(getscore("agenciesScore"))
				+ Number(getscore("businessTrainingScore"))
				+ Number(getscore("systemSoundScore"))
				+ Number(getscore("contingencyPlansScore"))
				+ Number(getscore("informationScore"));
		if(organType == "13"){
			daFenRecord.set("firstTotalScore", score);
		}
		if(organType == "12"){
			daFenRecord.set("secondTotalScore", score);
		}
	}
}
function scoreIsNotNull(id) {
	var score = document.getElementById(id).value;
	if (score == "" || score == undefined) {
		return false;
	}
	return true;
}
// 检查意见录入
function getopinion() {
	var scoreDataSet = L5.DatasetMgr.lookup("scoreDataSet");
	var scoreRecord = scoreDataSet.getCurrent();
	
	var daFenDataset = L5.DatasetMgr.lookup("daFenDataset");// 年检报告
	var daFenRecord = daFenDataset.getCurrent();
	var b;
	var a = "    ";
	if (scoreIsNotNull("businesscertificateScore")
			&& Number(getscore("businesscertificateScore")) < 1) {
		a += "在销售服务场所公开展示内容" + ",《经营性公墓合格证》扣1分,扣分原因:"
				+ document.getElementById("businesscertificateReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("businesslicenseScore")
			&& Number(getscore("businesslicenseScore")) < 1) {
		a += "在销售服务场所公开展示内容" + ",营业执照扣1分,扣分原因:"
				+ document.getElementById("businesslicenseReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("taxcertificateScore")
			&& Number(getscore("taxcertificateScore")) < 1) {
		a += "在销售服务场所公开展示内容" + ",税务登记证扣1分,扣分原因:"
				+ document.getElementById("taxcertificateReason").value + ";  ";
	}
	if (scoreIsNotNull("feeScore") && Number(getscore("feeScore")) < 2) {
		b = 2 - Number(getscore("feeScore"));
		a += "在销售服务场所公开展示内容" + ",收费项目、收费标准、收费依据等价格公示内容扣" + b + "分,扣分原因:"
				+ document.getElementById("feeReason").value + ";  ";
	}
	if (scoreIsNotNull("purchasegravesScore")
			&& Number(getscore("purchasegravesScore")) < 1) {
		a += "在销售服务场所公开展示内容" + ",购置墓穴(格位)的条件和程序扣1分,扣分原因:"
				+ document.getElementById("purchasegravesReason").value + ";  ";
	}
	if (scoreIsNotNull("pledgeScore") && Number(getscore("pledgeScore")) < 2) {
		b = 2 - Number(getscore("pledgeScore"));
		a += "在销售服务场所公开展示内容" + ",服务承诺扣" + b + "分,扣分原因:"
				+ document.getElementById("pledgeReason").value + ";  ";
	}
	if (scoreIsNotNull("staffresponsibilitiesScore")
			&& Number(getscore("staffresponsibilitiesScore")) < 1) {
		a += "在销售服务场所公开展示内容" + ",工作人员职责及照片、编号扣1分,扣分原因:"
				+ document.getElementById("staffresponsibilitiesReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("officeTimeScore")
			&& Number(getscore("officeTimeScore")) < 1) {
		a += "在销售服务场所公开展示内容" + ",办公时间、服务电话和监督电话扣1分,扣分原因:"
				+ document.getElementById("officeTimeReason").value + ";  ";
	}
	if (scoreIsNotNull("provincialdocumentsScore")
			&& Number(getscore("provincialdocumentsScore")) < 1) {
		a += "墓穴(格位)销售管理" + ",使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》扣1分,扣分原因:"
				+ document.getElementById("provincialdocumentsReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("departmentchargesScore")
			&& Number(getscore("departmentchargesScore")) < 1) {
		a += "墓穴(格位)销售管理" + ",物价部门核定收费标准扣1分,扣分原因:"
				+ document.getElementById("departmentchargesReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("nooffenseScore")
			&& Number(getscore("nooffenseScore")) < 2) {
		b = 2 - Number(getscore("nooffenseScore"));
		a += "墓穴(格位)销售管理" + ",无违法出租或买卖墓穴(格位)现象扣" + b + "分,扣分原因:"
				+ document.getElementById("nooffenseReason").value + ";  ";
	}
	if (scoreIsNotNull("propergraveScore")
			&& Number(getscore("propergraveScore")) < 1) {
		a += "墓穴(格位)销售管理" + ",对超过20年的墓穴能够妥善处理扣1分,扣分原因:"
				+ document.getElementById("propergraveReason").value + ";  ";
	}
	if (scoreIsNotNull("boxesandbagsScore")
			&& Number(getscore("boxesandbagsScore")) < 1) {
		a += "墓穴(格位)销售档案管理" + ",使用全省统一的卷盒和卷袋扣1分,扣分原因:"
				+ document.getElementById("boxesandbagsReason").value + ";  ";
	}
	if (scoreIsNotNull("deathcertificateScore")
			&& Number(getscore("deathcertificateScore")) < 1) {
		a += "墓穴(格位)销售档案管理" + ",有死亡证明或火化证明的复印件扣1分,扣分原因:"
				+ document.getElementById("deathcertificateReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("ashescontractScore")
			&& Number(getscore("ashescontractScore")) < 1) {
		a += "墓穴(格位)销售档案管理" + ",有骨灰安放(葬)合同扣1分,扣分原因:"
				+ document.getElementById("ashescontractReason").value + ";  ";
	}
	if (scoreIsNotNull("contractorssignatureScore")
			&& Number(getscore("contractorssignatureScore")) < 1) {
		a += "墓穴(格位)销售档案管理" + ",有丧事承办人签名的骨灰安放(葬)处理表、业务流程单等扣1分,扣分原因:"
				+ document.getElementById("contractorssignatureReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("contractoridScore")
			&& Number(getscore("contractoridScore")) < 1) {
		a += "墓穴(格位)销售档案管理" + ",有丧事承办人的有效身份证件复印件扣1分,扣分原因:"
				+ document.getElementById("contractoridReason").value + ";  ";
	}
	if (scoreIsNotNull("addcontractScore")
			&& Number(getscore("addcontractScore")) < 1) {
		a += "墓穴(格位)销售档案管理" + ",有补充签订的合同或者协议扣1分,扣分原因:"
				+ document.getElementById("addcontractReason").value + ";  ";
	}
	if (scoreIsNotNull("othermaterialsScore")
			&& Number(getscore("othermaterialsScore")) < 1) {
		a += "墓穴(格位)销售档案管理" + ",有其他应当归档的材料扣1分,扣分原因:"
				+ document.getElementById("othermaterialsReason").value + ";  ";
	}
	if (scoreIsNotNull("tombstoneTwentyScore")
			&& Number(getscore("tombstoneTwentyScore")) < 2) {
		b = 2 - Number(getscore("tombstoneTwentyScore"));
		a += "墓穴建设" + ",墓穴面积或墓碑高度超过规定标准20%以下的个数扣" + b + "分,扣分原因:"
				+ document.getElementById("tombstoneTwentyReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("tombstoneFiftyScore")
			&& Number(getscore("tombstoneFiftyScore")) < 3) {
		b = 3 - Number(getscore("tombstoneFiftyScore"));
		a += "墓穴建设" + ",墓穴面积或墓碑高度超过规定标准20%至50%的个数扣" + b + "分,扣分原因:"
				+ document.getElementById("tombstoneFiftyReason").value + ";  ";
	}
	if (scoreIsNotNull("tombstoneoverfiftyScore")
			&& Number(getscore("tombstoneoverfiftyScore")) < 4) {
		b = 4 - Number(getscore("tombstoneoverfiftyScore"));
		a += "墓穴建设" + ",墓穴面积或墓碑高度超过规定标准50%以上的个数扣" + b + "分,扣分原因:"
				+ document.getElementById("tombstoneoverfiftyReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("operatingareaScore")
			&& Number(getscore("operatingareaScore")) < 1) {
		a += "墓区管理" + ",营业室面积扣1分,扣分原因:"
				+ document.getElementById("operatingareaReason").value + ";  ";
	}
	if (scoreIsNotNull("archivesareaScore")
			&& Number(getscore("archivesareaScore")) < 1) {
		a += "墓区管理" + ",档案室面积扣1分,扣分原因:"
				+ document.getElementById("archivesareaReason").value + ";  ";
	}
	if (scoreIsNotNull("officeareaScore")
			&& Number(getscore("officeareaScore")) < 1) {
		a += "墓区管理" + ",办公室面积扣1分,扣分原因:"
				+ document.getElementById("officeareaReason").value + ";  ";
	}

	if (scoreIsNotNull("roadsafetyScore")
			&& Number(getscore("roadsafetyScore")) < 3) {
		b = 3 - Number(getscore("roadsafetyScore"));
		a += "墓区管理" + ",道路、供水、供电畅通,安全防护措施到位扣" + b + "分,扣分原因:"
				+ document.getElementById("roadsafetyReason").value + ";  ";
	}

	if (scoreIsNotNull("civilizationMemorialScore")
			&& Number(getscore("civilizationMemorialScore")) < 3) {
		b = 3 - Number(getscore("civilizationMemorialScore"));
		a += "墓区管理" + ",有文明祭奠举措,无封建迷信活动扣" + b + "分,扣分原因:"
				+ document.getElementById("civilizationMemorialReason").value
				+ ";  ";
	}

	if (scoreIsNotNull("fireMemorialScore")
			&& Number(getscore("fireMemorialScore")) < 2) {
		b = 2 - Number(getscore("fireMemorialScore"));
		a += "墓区管理" + ",允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施,并经县（市、区）以上林业部门审批扣" + b
				+ "分,扣分原因:"
				+ document.getElementById("fireMemorialReason").value + ";  ";
	}

	if (scoreIsNotNull("ecologyScore") && Number(getscore("ecologyScore")) < 6) {
		b = 6 - Number(getscore("ecologyScore"));
		a += "墓区管理" + ",生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例扣" + b + "分,扣分原因:"
				+ document.getElementById("ecologyReason").value + ";  ";
	}

	if (scoreIsNotNull("greenCoverageScore")
			&& Number(getscore("greenCoverageScore")) < 6) {
		b = 6 - Number(getscore("greenCoverageScore"));
		a += "墓区管理" + ",绿化覆盖率扣" + b + "分,扣分原因:"
				+ document.getElementById("greenCoverageReason").value + ";  ";
	}

	if (scoreIsNotNull("greenareaRatioScore")
			&& Number(getscore("greenareaRatioScore")) < 6) {
		b = 6 - Number(getscore("greenareaRatioScore"));
		a += "墓区管理" + ",绿地面积和占总面积的比例扣" + b + "分,扣分原因:"
				+ document.getElementById("greenareaRatioReason").value + ";  ";
	}

	if (scoreIsNotNull("burialTombScore")
			&& Number(getscore("burialTombScore")) < 1) {
		a += "墓区管理" + ",按照所购墓穴(格位)标准进行安葬或安放,无自行改建墓穴(格位)扣1分,扣分原因:"
				+ document.getElementById("burialTombReason").value + ";  ";
	}
	if (scoreIsNotNull("burialConformScore")
			&& Number(getscore("burialConformScore")) < 6) {
		b = 6 - Number(getscore("burialConformScore"));
		a += "公墓管理" + ",墓区建设地点和规模与申报材料相符扣" + b + "分,扣分原因:"
				+ document.getElementById("burialConformReason").value + ";  ";
	}
	if (scoreIsNotNull("acceptanceComplianceScore")
			&& Number(getscore("acceptanceComplianceScore")) < 6) {
		b = 6 - Number(getscore("acceptanceComplianceScore"));
		a += "公墓管理" + ",新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定扣" + b + "分,扣分原因:"
				+ document.getElementById("acceptanceComplianceReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("changeComplianceScore")
			&& Number(getscore("changeComplianceScore")) < 3) {
		b = 3 - Number(getscore("changeComplianceScore"));
		a += "公墓管理" + ",公墓更名、变更法人代表,改变性质或改变合作(合资)单位符合《山东省公墓管理办法》规定扣" + b
				+ "分,扣分原因:"
				+ document.getElementById("changeComplianceReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("paymentCertificateScore")
			&& Number(getscore("paymentCertificateScore")) < 7) {
		b = 7 - Number(getscore("paymentCertificateScore"));
		a += "公墓管理" + ",公墓根据销售墓穴的数量和使用年限,有不低于6%的税后收入预留,有交款凭证扣" + b + "分,扣分原因:"
				+ document.getElementById("paymentCertificateReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("agenciesScore")
			&& Number(getscore("agenciesScore")) < 4) {
		b = 4 - Number(getscore("agenciesScore"));
		a += "公墓管理" + ",墓区管理机构的组建与申报报告相符扣" + b + "分,扣分原因:"
				+ document.getElementById("agenciesReason").value + ";  ";
	}
	if (scoreIsNotNull("businessTrainingScore")
			&& Number(getscore("businessTrainingScore")) < 1) {
		a += "公墓管理" + ",工作人员参加省或设区的市人民政府民政部门组织的业务培训扣1分,扣分原因:"
				+ document.getElementById("businessTrainingReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("systemSoundScore")
			&& Number(getscore("systemSoundScore")) < 3) {
		b = 3 - Number(getscore("systemSoundScore"));
		a += "公墓管理" + ",公墓管理的各项规章制度健全相符扣" + b + "分,扣分原因:"
				+ document.getElementById("systemSoundReason").value + ";  ";
	}
	if (scoreIsNotNull("contingencyPlansScore")
			&& Number(getscore("contingencyPlansScore")) < 3) {
		b = 3 - Number(getscore("contingencyPlansScore"));
		a += "公墓管理" + ",有高峰应急预案扣" + b + "分,扣分原因:"
				+ document.getElementById("contingencyPlansReason").value
				+ ";  ";
	}
	if (scoreIsNotNull("informationScore")
			&& Number(getscore("informationScore")) < 6) {
		b = 6 - Number(getscore("informationScore"));
		a += "公墓管理" + ",实行信息化管理,使用省厅研制的软件信息系统扣" + b + "分,扣分原因:"
				+ document.getElementById("informationReason").value + ";  ";
	}
	if(organType == "13"){
		daFenRecord.set("firstOpinion", a);
	}
	if(organType == "12"){
		daFenRecord.set("secondAnnuareport", a);
	}
}
//点击选择公墓后加载
function forCemeSelect(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		//arrs[2] 为公墓记录编码
		var applyDs = L5.DatasetMgr.lookup("applyDs");
		var records = applyDs.getAllRecords();
		for(var i=0;i<records.length;i++){
			if(records[i].get("recordId") == arrs[2] && records[i].get("checkYear") == NJYear){
				L5.Msg.alert('提示', "该公墓已经参加过今年的业务检查了!");
				//history.go(-1);
				document.getElementById("save").style.display = 'none';
				return false;
			}
			
		}
		
		var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
		CemeInfoDs.setParameter("RECORD_ID",arrs[2]);
		CemeInfoDs.load();
	}
}
function openCemeChoose(){
	return window.showModalDialog("../fisCemeInfomation.jsp?manaCode="+organCode+"&prop="+prop, "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}

//附件管理
function clickUploadFile() {
	var editGrid = L5.getCmp('uploadGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一种文件类型!");
		return false;
	}
	var record = selected[0];
	var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
	accessoriesItemDataSet.setParameter("CODE", record.get("code"));
	accessoriesItemDataSet.setParameter("ITEM_ID@=",(cemeApplyId=="null") ? newCemeApplyId : cemeApplyId);
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
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
	command.setParameter("applyId", (cemeApplyId=="null") ? newCemeApplyId : cemeApplyId);
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
						var accessoriesItemDataSet = L5.DatasetMgr.lookup("accessoriesItemDataSet");
						accessoriesItemDataSet.setParameter("CODE@=", record.get("code"));
						accessoriesItemDataSet.setParameter("ITEM_ID@=",(cemeApplyId=="null") ? newCemeApplyId : cemeApplyId);
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
			var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
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
	accessoriesDataSet.setParameter("applayId", (cemeApplyId=="null") ? newCemeApplyId : cemeApplyId);
	accessoriesDataSet.setParameter("code","A");
	accessoriesDataSet.load();
	var win = L5.getCmp("uploadList");
	win.hide();
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
function downloadCheckStandard() {
	L5.Msg.confirm('信息确认', '确认要导出信息？', function(btn) {
				    if (btn == 'yes') {
				    	window.open('../downloadCheck.jsp');
				    	}
		});
}
