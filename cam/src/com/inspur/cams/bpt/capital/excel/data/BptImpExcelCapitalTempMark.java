package com.inspur.cams.bpt.capital.excel.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 资金发放验证信息data
 * 
 * @author zhanghui
 * 
 */
@Table(tableName = "BPT_IMP_CAPITAL_TEMP_MARK", keyFields = "id")
public class BptImpExcelCapitalTempMark extends StatefulDatabean {

	// 主键
	@Rule(value = "require")
	@Column(name = "ID")
	private String id;
	// 姓名
	@Column(name = "NAME")
	private String name;
	// 身份证号
	@Column(name = "ID_CARD")
	private String idCard;
	// 发放日期
	@Column(name = "GRANT_STA_MON")
	private String grantStaMon;
	// 发放月数
	@Column(name = "GRANT_MONTHS")
	private String grantMonths;
	// 护理费
	@Column(name = "NURSING_MON")
	private String nursingMon;
	// 发放资金金额
	@Column(name = "GRANT_MON")
	private String grantMon;
	// 自然增长机制
	@Column(name = "INCREASE_MECHANISM")
	private String increaseMechanism;
	// 粮油增发
	@Column(name = "GRAIN_OIL_MON")
	private String grainOilMon;
	// 煤补增发
	@Column(name = "COAL_SUBSIDY_MON")
	private String coalSubsidyMon;
	// 抗日增发
	@Column(name = "ANTI_JAPANESE_MON")
	private String antiJapaneseMon;
	// 孤老增发
	@Column(name = "OLD_LONELY_MON")
	private String oldLonelyMon;
	// 其他补助1
	@Column(name = "OTHER_SUBSIDY_ONE")
	private String otherSubsidyOne;
	// 其他补助2
	@Column(name = "OTHER_SUBSIDY_TWO")
	private String otherSubsidyTwo;
	// 其他补助3
	@Column(name = "OTHER_SUBSIDY_THREE")
	private String otherSubsidyThree;
	// 其他补助4
	@Column(name = "OTHER_SUBSIDY_FOUR")
	private String otherSubsidyFour;
	// 其他补助5
	@Column(name = "OTHER_SUBSIDY_FIVE")
	private String otherSubsidyFive;
	// 地方补贴小计
	@Column(name = "SUB_TOTAL")
	private String subTotal;
	// 发放资金总额
	@Column(name = "GRANT_MON_SUM")
	private String grantMonSum;
	// 备注
	@Column(name = "NOTE")
	private String note;
	// 发放日期
	@Rule(value = "require")
	@Column(name = "GRANT_DATE")
	private String grantDate;
	// 发放起
	@Column(name = "START_DATE")
	private String startDate;
	// 发放止
	@Column(name = "END_DATE")
	private String endDate;
	// 名册类别
	@Column(name = "REGISTER_TYPE")
	private String registerType;
	// 提交标示
	@Column(name = "COMMIT_FLAG")
	private String commitFlag;
	// 验证标示
	@Column(name = "VALIDATE_FLAG")
	private String validateFlag;
	// 验证信息
	@Column(name = "ERROR_MESSAGE")
	private String errorMessage;
	// 导入地行政区划
	@Column(name = "ORGAN_CODE")
	private String organCode;

	/**
	 * getter for 主键
	 * 
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for 主键
	 * 
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for 姓名
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 姓名
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * getter for 发放日期
	 * 
	 * @generated
	 */
	public String getGrantStaMon() {
		return this.grantStaMon;
	}

	/**
	 * setter for 发放日期
	 * 
	 * @generated
	 */
	public void setGrantStaMon(String grantStaMon) {
		this.grantStaMon = grantStaMon;
	}

	/**
	 * getter for 发放月数
	 * 
	 * @generated
	 */
	public String getGrantMonths() {
		return this.grantMonths;
	}

	/**
	 * setter for 发放月数
	 * 
	 * @generated
	 */
	public void setGrantMonths(String grantMonths) {
		this.grantMonths = grantMonths;
	}

	/**
	 * getter for 护理费
	 * 
	 * @generated
	 */
	public String getNursingMon() {
		return this.nursingMon;
	}

	/**
	 * setter for 护理费
	 * 
	 * @generated
	 */
	public void setNursingMon(String nursingMon) {
		this.nursingMon = nursingMon;
	}

	/**
	 * getter for 发放资金金额
	 * 
	 * @generated
	 */
	public String getGrantMon() {
		return this.grantMon;
	}

	/**
	 * setter for 发放资金金额
	 * 
	 * @generated
	 */
	public void setGrantMon(String grantMon) {
		this.grantMon = grantMon;
	}

	/**
	 * getter for 自然增长机制
	 * 
	 * @generated
	 */
	public String getIncreaseMechanism() {
		return this.increaseMechanism;
	}

	/**
	 * setter for 自然增长机制
	 * 
	 * @generated
	 */
	public void setIncreaseMechanism(String increaseMechanism) {
		this.increaseMechanism = increaseMechanism;
	}

	/**
	 * getter for 粮油增发
	 * 
	 * @generated
	 */
	public String getGrainOilMon() {
		return this.grainOilMon;
	}

	/**
	 * setter for 粮油增发
	 * 
	 * @generated
	 */
	public void setGrainOilMon(String grainOilMon) {
		this.grainOilMon = grainOilMon;
	}

	/**
	 * getter for 煤补增发
	 * 
	 * @generated
	 */
	public String getCoalSubsidyMon() {
		return this.coalSubsidyMon;
	}

	/**
	 * setter for 煤补增发
	 * 
	 * @generated
	 */
	public void setCoalSubsidyMon(String coalSubsidyMon) {
		this.coalSubsidyMon = coalSubsidyMon;
	}

	/**
	 * getter for 抗日增发
	 * 
	 * @generated
	 */
	public String getAntiJapaneseMon() {
		return this.antiJapaneseMon;
	}

	/**
	 * setter for 抗日增发
	 * 
	 * @generated
	 */
	public void setAntiJapaneseMon(String antiJapaneseMon) {
		this.antiJapaneseMon = antiJapaneseMon;
	}

	/**
	 * getter for 孤老增发
	 * 
	 * @generated
	 */
	public String getOldLonelyMon() {
		return this.oldLonelyMon;
	}

	/**
	 * setter for 孤老增发
	 * 
	 * @generated
	 */
	public void setOldLonelyMon(String oldLonelyMon) {
		this.oldLonelyMon = oldLonelyMon;
	}

	/**
	 * getter for 其他补助1
	 * 
	 * @generated
	 */
	public String getOtherSubsidyOne() {
		return this.otherSubsidyOne;
	}

	/**
	 * setter for 其他补助1
	 * 
	 * @generated
	 */
	public void setOtherSubsidyOne(String otherSubsidyOne) {
		this.otherSubsidyOne = otherSubsidyOne;
	}

	/**
	 * getter for 其他补助2
	 * 
	 * @generated
	 */
	public String getOtherSubsidyTwo() {
		return this.otherSubsidyTwo;
	}

	/**
	 * setter for 其他补助2
	 * 
	 * @generated
	 */
	public void setOtherSubsidyTwo(String otherSubsidyTwo) {
		this.otherSubsidyTwo = otherSubsidyTwo;
	}

	/**
	 * getter for 其他补助3
	 * 
	 * @generated
	 */
	public String getOtherSubsidyThree() {
		return this.otherSubsidyThree;
	}

	/**
	 * setter for 其他补助3
	 * 
	 * @generated
	 */
	public void setOtherSubsidyThree(String otherSubsidyThree) {
		this.otherSubsidyThree = otherSubsidyThree;
	}

	/**
	 * getter for 其他补助4
	 * 
	 * @generated
	 */
	public String getOtherSubsidyFour() {
		return this.otherSubsidyFour;
	}

	/**
	 * setter for 其他补助4
	 * 
	 * @generated
	 */
	public void setOtherSubsidyFour(String otherSubsidyFour) {
		this.otherSubsidyFour = otherSubsidyFour;
	}

	/**
	 * getter for 其他补助5
	 * 
	 * @generated
	 */
	public String getOtherSubsidyFive() {
		return this.otherSubsidyFive;
	}

	/**
	 * setter for 其他补助5
	 * 
	 * @generated
	 */
	public void setOtherSubsidyFive(String otherSubsidyFive) {
		this.otherSubsidyFive = otherSubsidyFive;
	}

	/**
	 * getter for 地方补贴小计
	 * 
	 * @generated
	 */
	public String getSubTotal() {
		return this.subTotal;
	}

	/**
	 * setter for 地方补贴小计
	 * 
	 * @generated
	 */
	public void setSubTotal(String subTotal) {
		this.subTotal = subTotal;
	}

	/**
	 * getter for 发放资金总额
	 * 
	 * @generated
	 */
	public String getGrantMonSum() {
		return this.grantMonSum;
	}

	/**
	 * setter for 发放资金总额
	 * 
	 * @generated
	 */
	public void setGrantMonSum(String grantMonSum) {
		this.grantMonSum = grantMonSum;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * getter for 发放日期
	 * 
	 * @generated
	 */
	public String getGrantDate() {
		return this.grantDate;
	}

	/**
	 * setter for 发放日期
	 * 
	 * @generated
	 */
	public void setGrantDate(String grantDate) {
		this.grantDate = grantDate;
	}

	/**
	 * getter for 发放起
	 * 
	 * @generated
	 */
	public String getStartDate() {
		return this.startDate;
	}

	/**
	 * setter for 发放起
	 * 
	 * @generated
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * getter for 发放止
	 * 
	 * @generated
	 */
	public String getEndDate() {
		return this.endDate;
	}

	/**
	 * setter for 发放止
	 * 
	 * @generated
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * getter for 名册类别
	 * 
	 * @generated
	 */
	public String getRegisterType() {
		return this.registerType;
	}

	/**
	 * setter for 名册类别
	 * 
	 * @generated
	 */
	public void setRegisterType(String registerType) {
		this.registerType = registerType;
	}

	/**
	 * getter for 提交标示
	 * 
	 * @generated
	 */
	public String getCommitFlag() {
		return this.commitFlag;
	}

	/**
	 * setter for 提交标示
	 * 
	 * @generated
	 */
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
	}

	/**
	 * getter for 验证标示
	 * 
	 * @generated
	 */
	public String getValidateFlag() {
		return this.validateFlag;
	}

	/**
	 * setter for 验证标示
	 * 
	 * @generated
	 */
	public void setValidateFlag(String validateFlag) {
		this.validateFlag = validateFlag;
	}

	/**
	 * getter for 验证信息
	 * 
	 * @generated
	 */
	public String getErrorMessage() {
		return this.errorMessage;
	}

	/**
	 * setter for 验证信息
	 * 
	 * @generated
	 */
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

}
