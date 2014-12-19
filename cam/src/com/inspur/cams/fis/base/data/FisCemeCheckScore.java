package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓年检打分databean
 * @author 
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_CHECK_SCORE", keyFields = "scoreId")
public class FisCemeCheckScore extends StatefulDatabean {

	// SCORE_ID
	private String scoreId;

	// 业务审批编码
	private String cemeApplyId;

	// 经营性合格证/县级民政部门批准建设文件得分2
	private BigDecimal businesscertificateScore;

	// 经营性合格证/县级民政部门批准建设文件原因2
	private String businesscertificateReason;

	// 营业执照/本公益性公墓管理章程得分2
	private BigDecimal businesslicenseScore;

	// 营业执照/本公益性公墓管理章程原因2
	private String businesslicenseReason;

	// 税务登记证得分
	private BigDecimal taxcertificateScore;

	// 税务登记证原因
	private String taxcertificateReason;

	// 收费得分2
	private BigDecimal feeScore;

	// 收费原因2
	private String feeReason;

	// 购置墓穴/安葬程序得分2
	private BigDecimal purchasegravesScore;

	// 购置墓穴/安葬程序原因2
	private String purchasegravesReason;

	// 服务承诺得分2
	private BigDecimal pledgeScore;

	// 服务承诺原因2
	private String pledgeReason;

	// 工作人员职责得分2
	private BigDecimal staffresponsibilitiesScore;

	// 工作人员职责原因2
	private String staffresponsibilitiesReason;

	// 办公时间/服务时间得分2
	private BigDecimal officeTimeScore;

	// 办公时间/服务时间原因2
	private String officeTimeReason;

	// 全省统一证得分
	private BigDecimal provincialdocumentsScore;

	// 全省统一证原因
	private String provincialdocumentsReason;

	// 物价部门收费标准
	private BigDecimal departmentchargesScore;

	// 物价部门收费标准原因
	private String departmentchargesReason;

	// 无违法出租得分2
	private BigDecimal nooffenseScore;

	// 无违法出租原因2
	private String nooffenseReason;

	// 墓穴妥善处理/有骨灰安放（葬）协议得分2
	private BigDecimal propergraveScore;

	// 墓穴妥善处理/有骨灰安放（葬）协议原因2
	private String propergraveReason;

	// 统一卷盒得分2
	private BigDecimal boxesandbagsScore;

	// 统一卷盒原因2
	private String boxesandbagsReason;

	// 死亡证明复印件得分2
	private BigDecimal deathcertificateScore;

	// 死亡证明复印件原因2
	private String deathcertificateReason;

	// 骨灰安放合同/骨灰安放（葬）处理表得分2
	private BigDecimal ashescontractScore;

	// 骨灰安放合同/骨灰安放（葬）处理表原因2
	private String ashescontractReason;

	// 承办人签名得分
	private BigDecimal contractorssignatureScore;

	// 承办人签名原因
	private String contractorssignatureReason;

	// 承办人身份证得分2
	private BigDecimal contractoridScore;

	// 承办人身份证原因2
	private String contractoridReason;

	// 补充合同协议得分
	private BigDecimal addcontractScore;

	// 补充合同协议原因
	private String addcontractReason;

	// 其他材料得分2
	private BigDecimal othermaterialsScore;

	// 其他材料原因2
	private String othermaterialsReason;

	// 墓碑20%以下得分2
	private BigDecimal tombstoneTwentyScore;

	// 墓碑20%以下原因2
	private String tombstoneTwentyReason;

	// TOMBSTONE_FIFTY_SCORE
	private BigDecimal tombstoneFiftyScore;

	// TOMBSTONE_FIFTY_REASON
	private String tombstoneFiftyReason;

	// 墓碑50%以上得分2
	private BigDecimal tombstoneoverfiftyScore;

	// 墓碑50%以上原因2
	private String tombstoneoverfiftyReason;

	// 营业室面积得分
	private BigDecimal operatingareaScore;

	// 营业室面积原因
	private String operatingareaReason;

	// 档案室面积得分
	private BigDecimal archivesareaScore;

	// 档案室面积原因
	private String archivesareaReason;

	// 办公室面积得分
	private BigDecimal officeareaScore;

	// 办公室面积原因
	private String officeareaReason;

	// 道路供水得分2
	private BigDecimal roadsafetyScore;

	// 道路供水原因2
	private String roadsafetyReason;

	// 文明祭奠得分2
	private BigDecimal civilizationMemorialScore;

	// 文明祭奠原因2
	private String civilizationMemorialReason;

	// 明火祭奠得分2
	private BigDecimal fireMemorialScore;

	// 明火祭奠原因2
	private String fireMemorialReason;

	// 生态得分2
	private BigDecimal ecologyScore;

	// 生态原因2
	private String ecologyReason;

	// 绿化率得分2
	private BigDecimal greenCoverageScore;

	// 绿化率原因2
	private String greenCoverageReason;

	// 绿地面积比率得分2
	private BigDecimal greenareaRatioScore;

	// 绿地面积比率原因2
	private String greenareaRatioReason;

	// 标准安葬墓穴得分2
	private BigDecimal burialTombScore;

	// 标准安葬墓穴原因2
	private String burialTombReason;

	// 墓区相符得分2
	private BigDecimal burialConformScore;

	// 墓区相符原因2
	private String burialConformReason;

	// 手续符合规定得分2
	private BigDecimal acceptanceComplianceScore;

	// 手续符合规定原因2
	private String acceptanceComplianceReason;

	// 改变符合规定/公墓更名符合规定得分2
	private BigDecimal changeComplianceScore;

	// 改变符合规定/公墓更名符合规定原因2
	private String changeComplianceReason;

	// 有交款凭证得分
	private BigDecimal paymentCertificateScore;

	// 有交款凭证原因
	private String paymentCertificateReason;

	// 管理机构组建相符得分2
	private BigDecimal agenciesScore;

	// 管理机构组建相符原因2
	private String agenciesReason;

	// 业务培训得分2
	private BigDecimal businessTrainingScore;

	// 业务培训原因2
	private String businessTrainingReason;

	// 规章制度健全得分2
	private BigDecimal systemSoundScore;

	// 规章制度健全原因2
	private String systemSoundReason;

	// 应急预案得分2
	private BigDecimal contingencyPlansScore;

	// 应急预案原因2
	private String contingencyPlansReason;

	// 信息化得分
	private BigDecimal informationScore;

	// 信息化原因
	private String informationReason;

	// 墓碑20%以下个数2
	private BigDecimal tombstoneTwentyNum;

	// TOMBSTONE_FIFTY_NUM
	private BigDecimal tombstoneFiftyNum;

	// 墓碑50%以上个数2
	private BigDecimal tombstoneoverfiftyNum;

	// 营业室面积
	private BigDecimal operatingareaNum;

	// 档案室面积
	private BigDecimal archivesareaNum;

	// 办公室面积
	private BigDecimal officeareaNum;

	// 生态比率2
	private BigDecimal ecologyNum;

	// 绿化率2
	private BigDecimal greenCoverageNum;

	// 绿地面积比率2
	private BigDecimal greenareaRatioNum;
	
	//当年安葬墓穴数
	private BigDecimal yearSinceHoleNum;
	
	//累计安葬墓穴
	private BigDecimal totalSinceHoleNum;
	
	//当年存放骨灰
	private BigDecimal yearBoneAshNum;
	
	//累计存放骨灰
    private BigDecimal totalBoneAshNum;
    
	//当年维护费缴纳数量
    private BigDecimal yearMaintenanceFee;
    
    //当年安葬超标墓穴数
    private BigDecimal yearOverproofHoleNum;
    
	//有无炒买炒卖数量
    private String isSpeculation;

	/**
	 * 获取 SCORE_ID
	 * @return String
	 */
	public String getScoreId() {
		return scoreId;
	}

	/**
	 * 设置 SCORE_ID
	 */
	public void setScoreId(String scoreId) {
		this.scoreId = scoreId;
	}

	/**
	 * 获取 业务审批编码
	 * @return String
	 */
	public String getCemeApplyId() {
		return cemeApplyId;
	}

	/**
	 * 设置 业务审批编码
	 */
	public void setCemeApplyId(String cemeApplyId) {
		this.cemeApplyId = cemeApplyId;
	}

	/**
	 * 获取 经营性合格证/县级民政部门批准建设文件得分2
	 * @return BigDecimal
	 */
	public BigDecimal getBusinesscertificateScore() {
		return businesscertificateScore;
	}

	/**
	 * 设置 经营性合格证/县级民政部门批准建设文件得分2
	 */
	public void setBusinesscertificateScore(BigDecimal businesscertificateScore) {
		this.businesscertificateScore = businesscertificateScore;
	}

	/**
	 * 获取 经营性合格证/县级民政部门批准建设文件原因2
	 * @return String
	 */
	public String getBusinesscertificateReason() {
		return businesscertificateReason;
	}

	/**
	 * 设置 经营性合格证/县级民政部门批准建设文件原因2
	 */
	public void setBusinesscertificateReason(String businesscertificateReason) {
		this.businesscertificateReason = businesscertificateReason;
	}

	/**
	 * 获取 营业执照/本公益性公墓管理章程得分2
	 * @return BigDecimal
	 */
	public BigDecimal getBusinesslicenseScore() {
		return businesslicenseScore;
	}

	/**
	 * 设置 营业执照/本公益性公墓管理章程得分2
	 */
	public void setBusinesslicenseScore(BigDecimal businesslicenseScore) {
		this.businesslicenseScore = businesslicenseScore;
	}

	/**
	 * 获取 营业执照/本公益性公墓管理章程原因2
	 * @return String
	 */
	public String getBusinesslicenseReason() {
		return businesslicenseReason;
	}

	/**
	 * 设置 营业执照/本公益性公墓管理章程原因2
	 */
	public void setBusinesslicenseReason(String businesslicenseReason) {
		this.businesslicenseReason = businesslicenseReason;
	}

	/**
	 * 获取 税务登记证得分
	 * @return BigDecimal
	 */
	public BigDecimal getTaxcertificateScore() {
		return taxcertificateScore;
	}

	/**
	 * 设置 税务登记证得分
	 */
	public void setTaxcertificateScore(BigDecimal taxcertificateScore) {
		this.taxcertificateScore = taxcertificateScore;
	}

	/**
	 * 获取 税务登记证原因
	 * @return String
	 */
	public String getTaxcertificateReason() {
		return taxcertificateReason;
	}

	/**
	 * 设置 税务登记证原因
	 */
	public void setTaxcertificateReason(String taxcertificateReason) {
		this.taxcertificateReason = taxcertificateReason;
	}

	/**
	 * 获取 收费得分2
	 * @return BigDecimal
	 */
	public BigDecimal getFeeScore() {
		return feeScore;
	}

	/**
	 * 设置 收费得分2
	 */
	public void setFeeScore(BigDecimal feeScore) {
		this.feeScore = feeScore;
	}

	/**
	 * 获取 收费原因2
	 * @return String
	 */
	public String getFeeReason() {
		return feeReason;
	}

	/**
	 * 设置 收费原因2
	 */
	public void setFeeReason(String feeReason) {
		this.feeReason = feeReason;
	}

	/**
	 * 获取 购置墓穴/安葬程序得分2
	 * @return BigDecimal
	 */
	public BigDecimal getPurchasegravesScore() {
		return purchasegravesScore;
	}

	/**
	 * 设置 购置墓穴/安葬程序得分2
	 */
	public void setPurchasegravesScore(BigDecimal purchasegravesScore) {
		this.purchasegravesScore = purchasegravesScore;
	}

	/**
	 * 获取 购置墓穴/安葬程序原因2
	 * @return String
	 */
	public String getPurchasegravesReason() {
		return purchasegravesReason;
	}

	/**
	 * 设置 购置墓穴/安葬程序原因2
	 */
	public void setPurchasegravesReason(String purchasegravesReason) {
		this.purchasegravesReason = purchasegravesReason;
	}

	/**
	 * 获取 服务承诺得分2
	 * @return BigDecimal
	 */
	public BigDecimal getPledgeScore() {
		return pledgeScore;
	}

	/**
	 * 设置 服务承诺得分2
	 */
	public void setPledgeScore(BigDecimal pledgeScore) {
		this.pledgeScore = pledgeScore;
	}

	/**
	 * 获取 服务承诺原因2
	 * @return String
	 */
	public String getPledgeReason() {
		return pledgeReason;
	}

	/**
	 * 设置 服务承诺原因2
	 */
	public void setPledgeReason(String pledgeReason) {
		this.pledgeReason = pledgeReason;
	}

	/**
	 * 获取 工作人员职责得分2
	 * @return BigDecimal
	 */
	public BigDecimal getStaffresponsibilitiesScore() {
		return staffresponsibilitiesScore;
	}

	/**
	 * 设置 工作人员职责得分2
	 */
	public void setStaffresponsibilitiesScore(BigDecimal staffresponsibilitiesScore) {
		this.staffresponsibilitiesScore = staffresponsibilitiesScore;
	}

	/**
	 * 获取 工作人员职责原因2
	 * @return String
	 */
	public String getStaffresponsibilitiesReason() {
		return staffresponsibilitiesReason;
	}

	/**
	 * 设置 工作人员职责原因2
	 */
	public void setStaffresponsibilitiesReason(String staffresponsibilitiesReason) {
		this.staffresponsibilitiesReason = staffresponsibilitiesReason;
	}

	/**
	 * 获取 办公时间/服务时间得分2
	 * @return BigDecimal
	 */
	public BigDecimal getOfficeTimeScore() {
		return officeTimeScore;
	}

	/**
	 * 设置 办公时间/服务时间得分2
	 */
	public void setOfficeTimeScore(BigDecimal officeTimeScore) {
		this.officeTimeScore = officeTimeScore;
	}

	/**
	 * 获取 办公时间/服务时间原因2
	 * @return String
	 */
	public String getOfficeTimeReason() {
		return officeTimeReason;
	}

	/**
	 * 设置 办公时间/服务时间原因2
	 */
	public void setOfficeTimeReason(String officeTimeReason) {
		this.officeTimeReason = officeTimeReason;
	}

	/**
	 * 获取 全省统一证得分
	 * @return BigDecimal
	 */
	public BigDecimal getProvincialdocumentsScore() {
		return provincialdocumentsScore;
	}

	/**
	 * 设置 全省统一证得分
	 */
	public void setProvincialdocumentsScore(BigDecimal provincialdocumentsScore) {
		this.provincialdocumentsScore = provincialdocumentsScore;
	}

	/**
	 * 获取 全省统一证原因
	 * @return String
	 */
	public String getProvincialdocumentsReason() {
		return provincialdocumentsReason;
	}

	/**
	 * 设置 全省统一证原因
	 */
	public void setProvincialdocumentsReason(String provincialdocumentsReason) {
		this.provincialdocumentsReason = provincialdocumentsReason;
	}

	/**
	 * 获取 物价部门收费标准
	 * @return BigDecimal
	 */
	public BigDecimal getDepartmentchargesScore() {
		return departmentchargesScore;
	}

	/**
	 * 设置 物价部门收费标准
	 */
	public void setDepartmentchargesScore(BigDecimal departmentchargesScore) {
		this.departmentchargesScore = departmentchargesScore;
	}

	/**
	 * 获取 物价部门收费标准原因
	 * @return String
	 */
	public String getDepartmentchargesReason() {
		return departmentchargesReason;
	}

	/**
	 * 设置 物价部门收费标准原因
	 */
	public void setDepartmentchargesReason(String departmentchargesReason) {
		this.departmentchargesReason = departmentchargesReason;
	}

	/**
	 * 获取 无违法出租得分2
	 * @return BigDecimal
	 */
	public BigDecimal getNooffenseScore() {
		return nooffenseScore;
	}

	/**
	 * 设置 无违法出租得分2
	 */
	public void setNooffenseScore(BigDecimal nooffenseScore) {
		this.nooffenseScore = nooffenseScore;
	}

	/**
	 * 获取 无违法出租原因2
	 * @return String
	 */
	public String getNooffenseReason() {
		return nooffenseReason;
	}

	/**
	 * 设置 无违法出租原因2
	 */
	public void setNooffenseReason(String nooffenseReason) {
		this.nooffenseReason = nooffenseReason;
	}

	/**
	 * 获取 墓穴妥善处理/有骨灰安放（葬）协议得分2
	 * @return BigDecimal
	 */
	public BigDecimal getPropergraveScore() {
		return propergraveScore;
	}

	/**
	 * 设置 墓穴妥善处理/有骨灰安放（葬）协议得分2
	 */
	public void setPropergraveScore(BigDecimal propergraveScore) {
		this.propergraveScore = propergraveScore;
	}

	/**
	 * 获取 墓穴妥善处理/有骨灰安放（葬）协议原因2
	 * @return String
	 */
	public String getPropergraveReason() {
		return propergraveReason;
	}

	/**
	 * 设置 墓穴妥善处理/有骨灰安放（葬）协议原因2
	 */
	public void setPropergraveReason(String propergraveReason) {
		this.propergraveReason = propergraveReason;
	}

	/**
	 * 获取 统一卷盒得分2
	 * @return BigDecimal
	 */
	public BigDecimal getBoxesandbagsScore() {
		return boxesandbagsScore;
	}

	/**
	 * 设置 统一卷盒得分2
	 */
	public void setBoxesandbagsScore(BigDecimal boxesandbagsScore) {
		this.boxesandbagsScore = boxesandbagsScore;
	}

	/**
	 * 获取 统一卷盒原因2
	 * @return String
	 */
	public String getBoxesandbagsReason() {
		return boxesandbagsReason;
	}

	/**
	 * 设置 统一卷盒原因2
	 */
	public void setBoxesandbagsReason(String boxesandbagsReason) {
		this.boxesandbagsReason = boxesandbagsReason;
	}

	/**
	 * 获取 死亡证明复印件得分2
	 * @return BigDecimal
	 */
	public BigDecimal getDeathcertificateScore() {
		return deathcertificateScore;
	}

	/**
	 * 设置 死亡证明复印件得分2
	 */
	public void setDeathcertificateScore(BigDecimal deathcertificateScore) {
		this.deathcertificateScore = deathcertificateScore;
	}

	/**
	 * 获取 死亡证明复印件原因2
	 * @return String
	 */
	public String getDeathcertificateReason() {
		return deathcertificateReason;
	}

	/**
	 * 设置 死亡证明复印件原因2
	 */
	public void setDeathcertificateReason(String deathcertificateReason) {
		this.deathcertificateReason = deathcertificateReason;
	}

	/**
	 * 获取 骨灰安放合同/骨灰安放（葬）处理表得分2
	 * @return BigDecimal
	 */
	public BigDecimal getAshescontractScore() {
		return ashescontractScore;
	}

	/**
	 * 设置 骨灰安放合同/骨灰安放（葬）处理表得分2
	 */
	public void setAshescontractScore(BigDecimal ashescontractScore) {
		this.ashescontractScore = ashescontractScore;
	}

	/**
	 * 获取 骨灰安放合同/骨灰安放（葬）处理表原因2
	 * @return String
	 */
	public String getAshescontractReason() {
		return ashescontractReason;
	}

	/**
	 * 设置 骨灰安放合同/骨灰安放（葬）处理表原因2
	 */
	public void setAshescontractReason(String ashescontractReason) {
		this.ashescontractReason = ashescontractReason;
	}

	/**
	 * 获取 承办人签名得分
	 * @return BigDecimal
	 */
	public BigDecimal getContractorssignatureScore() {
		return contractorssignatureScore;
	}

	/**
	 * 设置 承办人签名得分
	 */
	public void setContractorssignatureScore(BigDecimal contractorssignatureScore) {
		this.contractorssignatureScore = contractorssignatureScore;
	}

	/**
	 * 获取 承办人签名原因
	 * @return String
	 */
	public String getContractorssignatureReason() {
		return contractorssignatureReason;
	}

	/**
	 * 设置 承办人签名原因
	 */
	public void setContractorssignatureReason(String contractorssignatureReason) {
		this.contractorssignatureReason = contractorssignatureReason;
	}

	/**
	 * 获取 承办人身份证得分2
	 * @return BigDecimal
	 */
	public BigDecimal getContractoridScore() {
		return contractoridScore;
	}

	/**
	 * 设置 承办人身份证得分2
	 */
	public void setContractoridScore(BigDecimal contractoridScore) {
		this.contractoridScore = contractoridScore;
	}

	/**
	 * 获取 承办人身份证原因2
	 * @return String
	 */
	public String getContractoridReason() {
		return contractoridReason;
	}

	/**
	 * 设置 承办人身份证原因2
	 */
	public void setContractoridReason(String contractoridReason) {
		this.contractoridReason = contractoridReason;
	}

	/**
	 * 获取 补充合同协议得分
	 * @return BigDecimal
	 */
	public BigDecimal getAddcontractScore() {
		return addcontractScore;
	}

	/**
	 * 设置 补充合同协议得分
	 */
	public void setAddcontractScore(BigDecimal addcontractScore) {
		this.addcontractScore = addcontractScore;
	}

	/**
	 * 获取 补充合同协议原因
	 * @return String
	 */
	public String getAddcontractReason() {
		return addcontractReason;
	}

	/**
	 * 设置 补充合同协议原因
	 */
	public void setAddcontractReason(String addcontractReason) {
		this.addcontractReason = addcontractReason;
	}

	/**
	 * 获取 其他材料得分2
	 * @return BigDecimal
	 */
	public BigDecimal getOthermaterialsScore() {
		return othermaterialsScore;
	}

	/**
	 * 设置 其他材料得分2
	 */
	public void setOthermaterialsScore(BigDecimal othermaterialsScore) {
		this.othermaterialsScore = othermaterialsScore;
	}

	/**
	 * 获取 其他材料原因2
	 * @return String
	 */
	public String getOthermaterialsReason() {
		return othermaterialsReason;
	}

	/**
	 * 设置 其他材料原因2
	 */
	public void setOthermaterialsReason(String othermaterialsReason) {
		this.othermaterialsReason = othermaterialsReason;
	}

	/**
	 * 获取 墓碑20%以下得分2
	 * @return BigDecimal
	 */
	public BigDecimal getTombstoneTwentyScore() {
		return tombstoneTwentyScore;
	}

	/**
	 * 设置 墓碑20%以下得分2
	 */
	public void setTombstoneTwentyScore(BigDecimal tombstoneTwentyScore) {
		this.tombstoneTwentyScore = tombstoneTwentyScore;
	}

	/**
	 * 获取 墓碑20%以下原因2
	 * @return String
	 */
	public String getTombstoneTwentyReason() {
		return tombstoneTwentyReason;
	}

	/**
	 * 设置 墓碑20%以下原因2
	 */
	public void setTombstoneTwentyReason(String tombstoneTwentyReason) {
		this.tombstoneTwentyReason = tombstoneTwentyReason;
	}

	/**
	 * 获取 TOMBSTONE_FIFTY_SCORE
	 * @return BigDecimal
	 */
	public BigDecimal getTombstoneFiftyScore() {
		return tombstoneFiftyScore;
	}

	/**
	 * 设置 TOMBSTONE_FIFTY_SCORE
	 */
	public void setTombstoneFiftyScore(BigDecimal tombstoneFiftyScore) {
		this.tombstoneFiftyScore = tombstoneFiftyScore;
	}

	/**
	 * 获取 TOMBSTONE_FIFTY_REASON
	 * @return String
	 */
	public String getTombstoneFiftyReason() {
		return tombstoneFiftyReason;
	}

	/**
	 * 设置 TOMBSTONE_FIFTY_REASON
	 */
	public void setTombstoneFiftyReason(String tombstoneFiftyReason) {
		this.tombstoneFiftyReason = tombstoneFiftyReason;
	}

	/**
	 * 获取 墓碑50%以上得分2
	 * @return BigDecimal
	 */
	public BigDecimal getTombstoneoverfiftyScore() {
		return tombstoneoverfiftyScore;
	}

	/**
	 * 设置 墓碑50%以上得分2
	 */
	public void setTombstoneoverfiftyScore(BigDecimal tombstoneoverfiftyScore) {
		this.tombstoneoverfiftyScore = tombstoneoverfiftyScore;
	}

	/**
	 * 获取 墓碑50%以上原因2
	 * @return String
	 */
	public String getTombstoneoverfiftyReason() {
		return tombstoneoverfiftyReason;
	}

	/**
	 * 设置 墓碑50%以上原因2
	 */
	public void setTombstoneoverfiftyReason(String tombstoneoverfiftyReason) {
		this.tombstoneoverfiftyReason = tombstoneoverfiftyReason;
	}

	/**
	 * 获取 营业室面积得分
	 * @return BigDecimal
	 */
	public BigDecimal getOperatingareaScore() {
		return operatingareaScore;
	}

	/**
	 * 设置 营业室面积得分
	 */
	public void setOperatingareaScore(BigDecimal operatingareaScore) {
		this.operatingareaScore = operatingareaScore;
	}

	/**
	 * 获取 营业室面积原因
	 * @return String
	 */
	public String getOperatingareaReason() {
		return operatingareaReason;
	}

	/**
	 * 设置 营业室面积原因
	 */
	public void setOperatingareaReason(String operatingareaReason) {
		this.operatingareaReason = operatingareaReason;
	}

	/**
	 * 获取 档案室面积得分
	 * @return BigDecimal
	 */
	public BigDecimal getArchivesareaScore() {
		return archivesareaScore;
	}

	/**
	 * 设置 档案室面积得分
	 */
	public void setArchivesareaScore(BigDecimal archivesareaScore) {
		this.archivesareaScore = archivesareaScore;
	}

	/**
	 * 获取 档案室面积原因
	 * @return String
	 */
	public String getArchivesareaReason() {
		return archivesareaReason;
	}

	/**
	 * 设置 档案室面积原因
	 */
	public void setArchivesareaReason(String archivesareaReason) {
		this.archivesareaReason = archivesareaReason;
	}

	/**
	 * 获取 办公室面积得分
	 * @return BigDecimal
	 */
	public BigDecimal getOfficeareaScore() {
		return officeareaScore;
	}

	/**
	 * 设置 办公室面积得分
	 */
	public void setOfficeareaScore(BigDecimal officeareaScore) {
		this.officeareaScore = officeareaScore;
	}

	/**
	 * 获取 办公室面积原因
	 * @return String
	 */
	public String getOfficeareaReason() {
		return officeareaReason;
	}

	/**
	 * 设置 办公室面积原因
	 */
	public void setOfficeareaReason(String officeareaReason) {
		this.officeareaReason = officeareaReason;
	}

	/**
	 * 获取 道路供水得分2
	 * @return BigDecimal
	 */
	public BigDecimal getRoadsafetyScore() {
		return roadsafetyScore;
	}

	/**
	 * 设置 道路供水得分2
	 */
	public void setRoadsafetyScore(BigDecimal roadsafetyScore) {
		this.roadsafetyScore = roadsafetyScore;
	}

	/**
	 * 获取 道路供水原因2
	 * @return String
	 */
	public String getRoadsafetyReason() {
		return roadsafetyReason;
	}

	/**
	 * 设置 道路供水原因2
	 */
	public void setRoadsafetyReason(String roadsafetyReason) {
		this.roadsafetyReason = roadsafetyReason;
	}

	/**
	 * 获取 文明祭奠得分2
	 * @return BigDecimal
	 */
	public BigDecimal getCivilizationMemorialScore() {
		return civilizationMemorialScore;
	}

	/**
	 * 设置 文明祭奠得分2
	 */
	public void setCivilizationMemorialScore(BigDecimal civilizationMemorialScore) {
		this.civilizationMemorialScore = civilizationMemorialScore;
	}

	/**
	 * 获取 文明祭奠原因2
	 * @return String
	 */
	public String getCivilizationMemorialReason() {
		return civilizationMemorialReason;
	}

	/**
	 * 设置 文明祭奠原因2
	 */
	public void setCivilizationMemorialReason(String civilizationMemorialReason) {
		this.civilizationMemorialReason = civilizationMemorialReason;
	}

	/**
	 * 获取 明火祭奠得分2
	 * @return BigDecimal
	 */
	public BigDecimal getFireMemorialScore() {
		return fireMemorialScore;
	}

	/**
	 * 设置 明火祭奠得分2
	 */
	public void setFireMemorialScore(BigDecimal fireMemorialScore) {
		this.fireMemorialScore = fireMemorialScore;
	}

	/**
	 * 获取 明火祭奠原因2
	 * @return String
	 */
	public String getFireMemorialReason() {
		return fireMemorialReason;
	}

	/**
	 * 设置 明火祭奠原因2
	 */
	public void setFireMemorialReason(String fireMemorialReason) {
		this.fireMemorialReason = fireMemorialReason;
	}

	/**
	 * 获取 生态得分2
	 * @return BigDecimal
	 */
	public BigDecimal getEcologyScore() {
		return ecologyScore;
	}

	/**
	 * 设置 生态得分2
	 */
	public void setEcologyScore(BigDecimal ecologyScore) {
		this.ecologyScore = ecologyScore;
	}

	/**
	 * 获取 生态原因2
	 * @return String
	 */
	public String getEcologyReason() {
		return ecologyReason;
	}

	/**
	 * 设置 生态原因2
	 */
	public void setEcologyReason(String ecologyReason) {
		this.ecologyReason = ecologyReason;
	}

	/**
	 * 获取 绿化率得分2
	 * @return BigDecimal
	 */
	public BigDecimal getGreenCoverageScore() {
		return greenCoverageScore;
	}

	/**
	 * 设置 绿化率得分2
	 */
	public void setGreenCoverageScore(BigDecimal greenCoverageScore) {
		this.greenCoverageScore = greenCoverageScore;
	}

	/**
	 * 获取 绿化率原因2
	 * @return String
	 */
	public String getGreenCoverageReason() {
		return greenCoverageReason;
	}

	/**
	 * 设置 绿化率原因2
	 */
	public void setGreenCoverageReason(String greenCoverageReason) {
		this.greenCoverageReason = greenCoverageReason;
	}

	/**
	 * 获取 绿地面积比率得分2
	 * @return BigDecimal
	 */
	public BigDecimal getGreenareaRatioScore() {
		return greenareaRatioScore;
	}

	/**
	 * 设置 绿地面积比率得分2
	 */
	public void setGreenareaRatioScore(BigDecimal greenareaRatioScore) {
		this.greenareaRatioScore = greenareaRatioScore;
	}

	/**
	 * 获取 绿地面积比率原因2
	 * @return String
	 */
	public String getGreenareaRatioReason() {
		return greenareaRatioReason;
	}

	/**
	 * 设置 绿地面积比率原因2
	 */
	public void setGreenareaRatioReason(String greenareaRatioReason) {
		this.greenareaRatioReason = greenareaRatioReason;
	}

	/**
	 * 获取 标准安葬墓穴得分2
	 * @return BigDecimal
	 */
	public BigDecimal getBurialTombScore() {
		return burialTombScore;
	}

	/**
	 * 设置 标准安葬墓穴得分2
	 */
	public void setBurialTombScore(BigDecimal burialTombScore) {
		this.burialTombScore = burialTombScore;
	}

	/**
	 * 获取 标准安葬墓穴原因2
	 * @return String
	 */
	public String getBurialTombReason() {
		return burialTombReason;
	}

	/**
	 * 设置 标准安葬墓穴原因2
	 */
	public void setBurialTombReason(String burialTombReason) {
		this.burialTombReason = burialTombReason;
	}

	/**
	 * 获取 墓区相符得分2
	 * @return BigDecimal
	 */
	public BigDecimal getBurialConformScore() {
		return burialConformScore;
	}

	/**
	 * 设置 墓区相符得分2
	 */
	public void setBurialConformScore(BigDecimal burialConformScore) {
		this.burialConformScore = burialConformScore;
	}

	/**
	 * 获取 墓区相符原因2
	 * @return String
	 */
	public String getBurialConformReason() {
		return burialConformReason;
	}

	/**
	 * 设置 墓区相符原因2
	 */
	public void setBurialConformReason(String burialConformReason) {
		this.burialConformReason = burialConformReason;
	}

	/**
	 * 获取 手续符合规定得分2
	 * @return BigDecimal
	 */
	public BigDecimal getAcceptanceComplianceScore() {
		return acceptanceComplianceScore;
	}

	/**
	 * 设置 手续符合规定得分2
	 */
	public void setAcceptanceComplianceScore(BigDecimal acceptanceComplianceScore) {
		this.acceptanceComplianceScore = acceptanceComplianceScore;
	}

	/**
	 * 获取 手续符合规定原因2
	 * @return String
	 */
	public String getAcceptanceComplianceReason() {
		return acceptanceComplianceReason;
	}

	/**
	 * 设置 手续符合规定原因2
	 */
	public void setAcceptanceComplianceReason(String acceptanceComplianceReason) {
		this.acceptanceComplianceReason = acceptanceComplianceReason;
	}

	/**
	 * 获取 改变符合规定/公墓更名符合规定得分2
	 * @return BigDecimal
	 */
	public BigDecimal getChangeComplianceScore() {
		return changeComplianceScore;
	}

	/**
	 * 设置 改变符合规定/公墓更名符合规定得分2
	 */
	public void setChangeComplianceScore(BigDecimal changeComplianceScore) {
		this.changeComplianceScore = changeComplianceScore;
	}

	/**
	 * 获取 改变符合规定/公墓更名符合规定原因2
	 * @return String
	 */
	public String getChangeComplianceReason() {
		return changeComplianceReason;
	}

	/**
	 * 设置 改变符合规定/公墓更名符合规定原因2
	 */
	public void setChangeComplianceReason(String changeComplianceReason) {
		this.changeComplianceReason = changeComplianceReason;
	}

	/**
	 * 获取 有交款凭证得分
	 * @return BigDecimal
	 */
	public BigDecimal getPaymentCertificateScore() {
		return paymentCertificateScore;
	}

	/**
	 * 设置 有交款凭证得分
	 */
	public void setPaymentCertificateScore(BigDecimal paymentCertificateScore) {
		this.paymentCertificateScore = paymentCertificateScore;
	}

	/**
	 * 获取 有交款凭证原因
	 * @return String
	 */
	public String getPaymentCertificateReason() {
		return paymentCertificateReason;
	}

	/**
	 * 设置 有交款凭证原因
	 */
	public void setPaymentCertificateReason(String paymentCertificateReason) {
		this.paymentCertificateReason = paymentCertificateReason;
	}

	/**
	 * 获取 管理机构组建相符得分2
	 * @return BigDecimal
	 */
	public BigDecimal getAgenciesScore() {
		return agenciesScore;
	}

	/**
	 * 设置 管理机构组建相符得分2
	 */
	public void setAgenciesScore(BigDecimal agenciesScore) {
		this.agenciesScore = agenciesScore;
	}

	/**
	 * 获取 管理机构组建相符原因2
	 * @return String
	 */
	public String getAgenciesReason() {
		return agenciesReason;
	}

	/**
	 * 设置 管理机构组建相符原因2
	 */
	public void setAgenciesReason(String agenciesReason) {
		this.agenciesReason = agenciesReason;
	}

	/**
	 * 获取 业务培训得分2
	 * @return BigDecimal
	 */
	public BigDecimal getBusinessTrainingScore() {
		return businessTrainingScore;
	}

	/**
	 * 设置 业务培训得分2
	 */
	public void setBusinessTrainingScore(BigDecimal businessTrainingScore) {
		this.businessTrainingScore = businessTrainingScore;
	}

	/**
	 * 获取 业务培训原因2
	 * @return String
	 */
	public String getBusinessTrainingReason() {
		return businessTrainingReason;
	}

	/**
	 * 设置 业务培训原因2
	 */
	public void setBusinessTrainingReason(String businessTrainingReason) {
		this.businessTrainingReason = businessTrainingReason;
	}

	/**
	 * 获取 规章制度健全得分2
	 * @return BigDecimal
	 */
	public BigDecimal getSystemSoundScore() {
		return systemSoundScore;
	}

	/**
	 * 设置 规章制度健全得分2
	 */
	public void setSystemSoundScore(BigDecimal systemSoundScore) {
		this.systemSoundScore = systemSoundScore;
	}

	/**
	 * 获取 规章制度健全原因2
	 * @return String
	 */
	public String getSystemSoundReason() {
		return systemSoundReason;
	}

	/**
	 * 设置 规章制度健全原因2
	 */
	public void setSystemSoundReason(String systemSoundReason) {
		this.systemSoundReason = systemSoundReason;
	}

	/**
	 * 获取 应急预案得分2
	 * @return BigDecimal
	 */
	public BigDecimal getContingencyPlansScore() {
		return contingencyPlansScore;
	}

	/**
	 * 设置 应急预案得分2
	 */
	public void setContingencyPlansScore(BigDecimal contingencyPlansScore) {
		this.contingencyPlansScore = contingencyPlansScore;
	}

	/**
	 * 获取 应急预案原因2
	 * @return String
	 */
	public String getContingencyPlansReason() {
		return contingencyPlansReason;
	}

	/**
	 * 设置 应急预案原因2
	 */
	public void setContingencyPlansReason(String contingencyPlansReason) {
		this.contingencyPlansReason = contingencyPlansReason;
	}

	/**
	 * 获取 信息化得分
	 * @return BigDecimal
	 */
	public BigDecimal getInformationScore() {
		return informationScore;
	}

	/**
	 * 设置 信息化得分
	 */
	public void setInformationScore(BigDecimal informationScore) {
		this.informationScore = informationScore;
	}

	/**
	 * 获取 信息化原因
	 * @return String
	 */
	public String getInformationReason() {
		return informationReason;
	}

	/**
	 * 设置 信息化原因
	 */
	public void setInformationReason(String informationReason) {
		this.informationReason = informationReason;
	}

	/**
	 * 获取 墓碑20%以下个数2
	 * @return BigDecimal
	 */
	public BigDecimal getTombstoneTwentyNum() {
		return tombstoneTwentyNum;
	}

	/**
	 * 设置 墓碑20%以下个数2
	 */
	public void setTombstoneTwentyNum(BigDecimal tombstoneTwentyNum) {
		this.tombstoneTwentyNum = tombstoneTwentyNum;
	}

	/**
	 * 获取 TOMBSTONE_FIFTY_NUM
	 * @return BigDecimal
	 */
	public BigDecimal getTombstoneFiftyNum() {
		return tombstoneFiftyNum;
	}

	/**
	 * 设置 TOMBSTONE_FIFTY_NUM
	 */
	public void setTombstoneFiftyNum(BigDecimal tombstoneFiftyNum) {
		this.tombstoneFiftyNum = tombstoneFiftyNum;
	}

	/**
	 * 获取 墓碑50%以上个数2
	 * @return BigDecimal
	 */
	public BigDecimal getTombstoneoverfiftyNum() {
		return tombstoneoverfiftyNum;
	}

	/**
	 * 设置 墓碑50%以上个数2
	 */
	public void setTombstoneoverfiftyNum(BigDecimal tombstoneoverfiftyNum) {
		this.tombstoneoverfiftyNum = tombstoneoverfiftyNum;
	}

	/**
	 * 获取 营业室面积
	 * @return BigDecimal
	 */
	public BigDecimal getOperatingareaNum() {
		return operatingareaNum;
	}

	/**
	 * 设置 营业室面积
	 */
	public void setOperatingareaNum(BigDecimal operatingareaNum) {
		this.operatingareaNum = operatingareaNum;
	}

	/**
	 * 获取 档案室面积
	 * @return BigDecimal
	 */
	public BigDecimal getArchivesareaNum() {
		return archivesareaNum;
	}

	/**
	 * 设置 档案室面积
	 */
	public void setArchivesareaNum(BigDecimal archivesareaNum) {
		this.archivesareaNum = archivesareaNum;
	}

	/**
	 * 获取 办公室面积
	 * @return BigDecimal
	 */
	public BigDecimal getOfficeareaNum() {
		return officeareaNum;
	}

	/**
	 * 设置 办公室面积
	 */
	public void setOfficeareaNum(BigDecimal officeareaNum) {
		this.officeareaNum = officeareaNum;
	}

	/**
	 * 获取 生态比率2
	 * @return BigDecimal
	 */
	public BigDecimal getEcologyNum() {
		return ecologyNum;
	}

	/**
	 * 设置 生态比率2
	 */
	public void setEcologyNum(BigDecimal ecologyNum) {
		this.ecologyNum = ecologyNum;
	}

	/**
	 * 获取 绿化率2
	 * @return BigDecimal
	 */
	public BigDecimal getGreenCoverageNum() {
		return greenCoverageNum;
	}

	/**
	 * 设置 绿化率2
	 */
	public void setGreenCoverageNum(BigDecimal greenCoverageNum) {
		this.greenCoverageNum = greenCoverageNum;
	}

	/**
	 * 获取 绿地面积比率2
	 * @return BigDecimal
	 */
	public BigDecimal getGreenareaRatioNum() {
		return greenareaRatioNum;
	}

	/**
	 * 设置 绿地面积比率2
	 */
	public void setGreenareaRatioNum(BigDecimal greenareaRatioNum) {
		this.greenareaRatioNum = greenareaRatioNum;
	}

	/**
	 * 获取 当年安葬墓穴数
	 * @return yearSinceHoleNum
	 */
	public BigDecimal getYearSinceHoleNum() {
		return yearSinceHoleNum;
	}

	/**
	 * 设置 当年安葬墓穴数
	 */
	public void setYearSinceHoleNum(BigDecimal yearSinceHoleNum) {
		this.yearSinceHoleNum = yearSinceHoleNum;
	}

	/**
	 * 获取 累计安葬墓穴
	 * @return totalSinceHoleNum
	 */
	public BigDecimal getTotalSinceHoleNum() {
		return totalSinceHoleNum;
	}

	/**
	 * 设置 累计安葬墓穴
	 */
	public void setTotalSinceHoleNum(BigDecimal totalSinceHoleNum) {
		this.totalSinceHoleNum = totalSinceHoleNum;
	}

	/**
	 * 获取 当年存放骨灰
	 * @return yearBoneAshNum
	 */
	public BigDecimal getYearBoneAshNum() {
		return yearBoneAshNum;
	}

	/**
	 * 设置 当年存放骨灰
	 */
	public void setYearBoneAshNum(BigDecimal yearBoneAshNum) {
		this.yearBoneAshNum = yearBoneAshNum;
	}

	/**
	 * 获取 累计存放骨灰
	 * @return totalBoneAshNum
	 */
	public BigDecimal getTotalBoneAshNum() {
		return totalBoneAshNum;
	}

	/**
	 * 设置 累计存放骨灰
	 * @param totalBoneAshNum 要设置的 totalBoneAshNum
	 */
	public void setTotalBoneAshNum(BigDecimal totalBoneAshNum) {
		this.totalBoneAshNum = totalBoneAshNum;
	}

	/**
	 * 获取 当年维护费缴纳数量
	 * @return yearMaintenanceFee
	 */
	public BigDecimal getYearMaintenanceFee() {
		return yearMaintenanceFee;
	}

	/**
	 * 设置 当年维护费缴纳数量
	 */
	public void setYearMaintenanceFee(BigDecimal yearMaintenanceFee) {
		this.yearMaintenanceFee = yearMaintenanceFee;
	}

	/**
	 * 获取当年安葬超标墓穴数
	 * @return yearOverproofHoleNum
	 */
	public BigDecimal getYearOverproofHoleNum() {
		return yearOverproofHoleNum;
	}

	/**
	 * 设置 当年安葬超标墓穴数
	 */
	public void setYearOverproofHoleNum(BigDecimal yearOverproofHoleNum) {
		this.yearOverproofHoleNum = yearOverproofHoleNum;
	}

	/**
	 * 获取 是否炒买炒卖
	 * @return isSpeculation
	 */
	public String getIsSpeculation() {
		return isSpeculation;
	}

	/**
	 * 设置 是否炒买炒卖
	 */
	public void setIsSpeculation(String isSpeculation) {
		this.isSpeculation = isSpeculation;
	}

}