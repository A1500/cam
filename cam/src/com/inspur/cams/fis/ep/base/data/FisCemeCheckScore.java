package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:FisCemeCheckScore
 * @description:
 * @author:
 * @since:2011-12-14
 * @version:1.0
*/
 @Table(tableName = "FIS_CEME_CHECK_SCORE" , keyFields = "scoreId")
public class FisCemeCheckScore extends StatefulDatabean {
   //SCORE_ID
	@Column(name = "SCORE_ID")
   private String scoreId;
   //年检记录ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //经营性合格证得分/县级民政部门批准建设文件得分2
   	@Rule(value="number")
	@Column(name = "BUSINESSCERTIFICATE_SCORE")
   private BigDecimal businesscertificateScore;
   //经营性合格证/县级民政部门批准建设文件原因2
	@Column(name = "BUSINESSCERTIFICATE_REASON")
   private String businesscertificateReason;
   //营业执照/本公益性公墓管理章程得分2
   	@Rule(value="number")
	@Column(name = "BUSINESSLICENSE_SCORE")
   private BigDecimal businesslicenseScore;
   //营业执照/本公益性公墓管理章程原因2
	@Column(name = "BUSINESSLICENSE_REASON")
   private String businesslicenseReason;
   //税务登记证得分
   	@Rule(value="number")
	@Column(name = "TAXCERTIFICATE_SCORE")
   private BigDecimal taxcertificateScore;
   //税务登记证原因
	@Column(name = "TAXCERTIFICATE_REASON")
   private String taxcertificateReason;
   //收费得分2
   	@Rule(value="number")
	@Column(name = "FEE_SCORE")
   private BigDecimal feeScore;
   //收费原因2
	@Column(name = "FEE_REASON")
   private String feeReason;
   //购置墓穴/安葬程序得分2
   	@Rule(value="number")
	@Column(name = "PURCHASEGRAVES_SCORE")
   private BigDecimal purchasegravesScore;
   //购置墓穴/安葬程序原因2
	@Column(name = "PURCHASEGRAVES_REASON")
   private String purchasegravesReason;
   //服务承诺得分2
   	@Rule(value="number")
	@Column(name = "PLEDGE_SCORE")
   private BigDecimal pledgeScore;
   //服务承诺原因2
	@Column(name = "PLEDGE_REASON")
   private String pledgeReason;
   //工作人员职责得分2
   	@Rule(value="number")
	@Column(name = "STAFFRESPONSIBILITIES_SCORE")
   private BigDecimal staffresponsibilitiesScore;
   //工作人员职责原因2
	@Column(name = "STAFFRESPONSIBILITIES_REASON")
   private String staffresponsibilitiesReason;
   //办公时间/服务时间得分2
   	@Rule(value="number")
	@Column(name = "OFFICE_TIME_SCORE")
   private BigDecimal officeTimeScore;
   //办公时间/服务时间原因2
	@Column(name = "OFFICE_TIME_REASON")
   private String officeTimeReason;
   //全省统一证得分
   	@Rule(value="number")
	@Column(name = "PROVINCIALDOCUMENTS_SCORE")
   private BigDecimal provincialdocumentsScore;
   //全省统一证原因
	@Column(name = "PROVINCIALDOCUMENTS_REASON")
   private String provincialdocumentsReason;
   //物价部门收费标准
   	@Rule(value="number")
	@Column(name = "DEPARTMENTCHARGES_SCORE")
   private BigDecimal departmentchargesScore;
   //物价部门收费标准原因
	@Column(name = "DEPARTMENTCHARGES_REASON")
   private String departmentchargesReason;
   //无违法出租得分2
   	@Rule(value="number")
	@Column(name = "NOOFFENSE_SCORE")
   private BigDecimal nooffenseScore;
   //无违法出租原因2
	@Column(name = "NOOFFENSE_REASON")
   private String nooffenseReason;
   //墓穴妥善处理/有骨灰安放（葬）协议得分2
   	@Rule(value="number")
	@Column(name = "PROPERGRAVE_SCORE")
   private BigDecimal propergraveScore;
   //墓穴妥善处理/有骨灰安放（葬）协议原因2
	@Column(name = "PROPERGRAVE_REASON")
   private String propergraveReason;
   //统一卷盒得分2
   	@Rule(value="number")
	@Column(name = "BOXESANDBAGS_SCORE")
   private BigDecimal boxesandbagsScore;
   //统一卷盒原因2
	@Column(name = "BOXESANDBAGS_REASON")
   private String boxesandbagsReason;
   //死亡证明复印件得分2
   	@Rule(value="number")
	@Column(name = "DEATHCERTIFICATE_SCORE")
   private BigDecimal deathcertificateScore;
   //死亡证明复印件原因2
	@Column(name = "DEATHCERTIFICATE_REASON")
   private String deathcertificateReason;
   //骨灰安放合同/骨灰安放（葬）处理表得分2
   	@Rule(value="number")
	@Column(name = "ASHESCONTRACT_SCORE")
   private BigDecimal ashescontractScore;
   //骨灰安放合同/骨灰安放（葬）处理表原因2
	@Column(name = "ASHESCONTRACT_REASON")
   private String ashescontractReason;
   //承办人签名得分
   	@Rule(value="number")
	@Column(name = "CONTRACTORSSIGNATURE_SCORE")
   private BigDecimal contractorssignatureScore;
   //承办人签名原因
	@Column(name = "CONTRACTORSSIGNATURE_REASON")
   private String contractorssignatureReason;
   //承办人身份证得分2
   	@Rule(value="number")
	@Column(name = "CONTRACTORID_SCORE")
   private BigDecimal contractoridScore;
   //承办人身份证原因2
	@Column(name = "CONTRACTORID_REASON")
   private String contractoridReason;
   //补充合同协议得分
   	@Rule(value="number")
	@Column(name = "ADDCONTRACT_SCORE")
   private BigDecimal addcontractScore;
   //补充合同协议原因
	@Column(name = "ADDCONTRACT_REASON")
   private String addcontractReason;
   //其他材料得分2
   	@Rule(value="number")
	@Column(name = "OTHERMATERIALS_SCORE")
   private BigDecimal othermaterialsScore;
   //其他材料原因2
	@Column(name = "OTHERMATERIALS_REASON")
   private String othermaterialsReason;
   //墓碑20%以下得分E2
   	@Rule(value="number")
	@Column(name = "TOMBSTONE_TWENTY_SCORE")
   private BigDecimal tombstoneTwentyScore;
   //墓碑20%以下个数2
   	@Rule(value="number")
	@Column(name = "TOMBSTONE_TWENTY_NUM")
   private BigDecimal tombstoneTwentyNum;
   	
   //墓碑20%以下原因2
	@Column(name = "TOMBSTONE_TWENTY_REASON")
   private String tombstoneTwentyReason;
   //墓碑20%到50%得分2
   	@Rule(value="number")
	@Column(name = "TOMBSTONE_FIFTY_SCORE")
   private BigDecimal tombstoneFiftyScore;
    //墓碑20%到50%个数2
   	@Rule(value="number")
	@Column(name = "TOMBSTONE_FIFTY_NUM")
   private BigDecimal tombstoneFiftyNum;
   //墓碑20%到50%原因2
	@Column(name = "TOMBSTONE_FIFTY_REASON")
   private String tombstoneFiftyReason;
   //墓碑50%以上得分2
   	@Rule(value="number")
	@Column(name = "TOMBSTONEOVERFIFTY_SCORE")
   private BigDecimal tombstoneoverfiftyScore;
  //墓碑50%以上个数2
   	@Rule(value="number")
	@Column(name = "TOMBSTONEOVERFIFTY_NUM")
   private BigDecimal tombstoneoverfiftyNum;
   //墓碑50%以上原因2
	@Column(name = "TOMBSTONEOVERFIFTY_REASON")
   private String tombstoneoverfiftyReason;
   //营业室面积得分
   	@Rule(value="number")
	@Column(name = "OPERATINGAREA_SCORE")
   private BigDecimal operatingareaScore;
    //营业室面积
   	@Rule(value="number")
	@Column(name = "OPERATINGAREA_NUM")
   private BigDecimal operatingareaNum;
   //营业室面积原因
	@Column(name = "OPERATINGAREA_REASON")
   private String operatingareaReason;
   //档案室面积得分
   	@Rule(value="number")
	@Column(name = "ARCHIVESAREA_SCORE")
   private BigDecimal archivesareaScore;
  //档案室面积
   	@Rule(value="number")
	@Column(name = "ARCHIVESAREA_NUM")
   private BigDecimal archivesareaNum;
   //档案室面积原因
	@Column(name = "ARCHIVESAREA_REASON")
   private String archivesareaReason;
   //办公室面积得分
   	@Rule(value="number")
	@Column(name = "OFFICEAREA_SCORE")
   private BigDecimal officeareaScore;
  //办公室面积
   	@Rule(value="number")
	@Column(name = "OFFICEAREA_NUM")
   private BigDecimal officeareaNum;
   //办公室面积原因
	@Column(name = "OFFICEAREA_REASON")
   private String officeareaReason;
   //道路供水得分2
   	@Rule(value="number")
	@Column(name = "ROADSAFETY_SCORE")
   private BigDecimal roadsafetyScore;
   //道路供水原因2
	@Column(name = "ROADSAFETY_REASON")
   private String roadsafetyReason;
   //文明祭奠得分2
   	@Rule(value="number")
	@Column(name = "CIVILIZATION_MEMORIAL_SCORE")
   private BigDecimal civilizationMemorialScore;
   //文明祭奠原因2
	@Column(name = "CIVILIZATION_MEMORIAL_REASON")
   private String civilizationMemorialReason;
   //明火祭奠得分2
   	@Rule(value="number")
	@Column(name = "FIRE_MEMORIAL_SCORE")
   private BigDecimal fireMemorialScore;
   //明火祭奠原因2
	@Column(name = "FIRE_MEMORIAL_REASON")
   private String fireMemorialReason;
   //生态得分2
   	@Rule(value="number")
	@Column(name = "ECOLOGY_SCORE")
   private BigDecimal ecologyScore;
  //生态2
   	@Rule(value="number")
	@Column(name = "ECOLOGY_NUM")
   private BigDecimal ecologyNum;
   //生态原因2
	@Column(name = "ECOLOGY_REASON")
   private String ecologyReason;
   //绿化率得分2
   	@Rule(value="number")
	@Column(name = "GREEN_COVERAGE_SCORE")
   private BigDecimal greenCoverageScore;
  //绿化率2
   	@Rule(value="number")
	@Column(name = "GREEN_COVERAGE_NUM")
   private BigDecimal greenCoverageNum;
   //绿化率原因2
	@Column(name = "GREEN_COVERAGE_REASON")
   private String greenCoverageReason;
   //绿地面积比率得分2
   	@Rule(value="number")
	@Column(name = "GREENAREA_RATIO_SCORE")
   private BigDecimal greenareaRatioScore;
  //绿地面积比率2
   	@Rule(value="number")
	@Column(name = "GREENAREA_RATIO_NUM")
   private BigDecimal greenareaRatioNum;
   //绿地面积比率原因2
	@Column(name = "GREENAREA_RATIO_REASON")
   private String greenareaRatioReason;
   //标准安葬墓穴得分2
   	@Rule(value="number")
	@Column(name = "BURIAL_TOMB_SCORE")
   private BigDecimal burialTombScore;
   //标准安葬墓穴原因2
	@Column(name = "BURIAL_TOMB_REASON")
   private String burialTombReason;
   //墓区相符得分2
   	@Rule(value="number")
	@Column(name = "BURIAL_CONFORM_SCORE")
   private BigDecimal burialConformScore;
   //墓区相符原因2
	@Column(name = "BURIAL_CONFORM_REASON")
   private String burialConformReason;
   //手续符合规定得分2
   	@Rule(value="number")
	@Column(name = "ACCEPTANCE_COMPLIANCE_SCORE")
   private BigDecimal acceptanceComplianceScore;
   //手续符合规定原因2
	@Column(name = "ACCEPTANCE_COMPLIANCE_REASON")
   private String acceptanceComplianceReason;
   //改变符合规定/公墓更名符合规定得分2
   	@Rule(value="number")
	@Column(name = "CHANGE_COMPLIANCE_SCORE")
   private BigDecimal changeComplianceScore;
   //改变符合规定/公墓更名符合规定原因2
	@Column(name = "CHANGE_COMPLIANCE_REASON")
   private String changeComplianceReason;
   //有交款凭证得分
   	@Rule(value="number")
	@Column(name = "PAYMENT_CERTIFICATE_SCORE")
   private BigDecimal paymentCertificateScore;
   //有交款凭证原因
	@Column(name = "PAYMENT_CERTIFICATE_REASON")
   private String paymentCertificateReason;
   //管理机构组建相符得分2
   	@Rule(value="number")
	@Column(name = "AGENCIES_SCORE")
   private BigDecimal agenciesScore;
   //管理机构组建相符原因2
	@Column(name = "AGENCIES_REASON")
   private String agenciesReason;
   //业务培训得分2
   	@Rule(value="number")
	@Column(name = "BUSINESS_TRAINING_SCORE")
   private BigDecimal businessTrainingScore;
   //业务培训原因2
	@Column(name = "BUSINESS_TRAINING_REASON")
   private String businessTrainingReason;
   //规章制度健全得分2
   	@Rule(value="number")
	@Column(name = "SYSTEM_SOUND_SCORE")
   private BigDecimal systemSoundScore;
   //规章制度健全原因2
	@Column(name = "SYSTEM_SOUND_REASON")
   private String systemSoundReason;
   //应急预案得分2
   	@Rule(value="number")
	@Column(name = "CONTINGENCY_PLANS_SCORE")
   private BigDecimal contingencyPlansScore;
   //应急预案原因2
	@Column(name = "CONTINGENCY_PLANS_REASON")
   private String contingencyPlansReason;
   //信息化得分
   	@Rule(value="number")
	@Column(name = "INFORMATION_SCORE")
   private BigDecimal informationScore;
   //信息化原因
	@Column(name = "INFORMATION_REASON")
   private String informationReason;
   /**
    * getter for SCORE_ID
    * @generated
    */
   public String getScoreId(){
      return this.scoreId;
   }
   /**
    * setter for SCORE_ID
    * @generated
    */
   public void setScoreId(String scoreId){
      this.scoreId = scoreId;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for BUSINESSCERTIFICATE_SCORE
    * @generated
    */
   public BigDecimal getBusinesscertificateScore(){
      return this.businesscertificateScore;
   }
   /**
    * setter for BUSINESSCERTIFICATE_SCORE
    * @generated
    */
   public void setBusinesscertificateScore(BigDecimal businesscertificateScore){
      this.businesscertificateScore = businesscertificateScore;
   }

   /**
    * getter for BUSINESSCERTIFICATE_REASON
    * @generated
    */
   public String getBusinesscertificateReason(){
      return this.businesscertificateReason;
   }
   /**
    * setter for BUSINESSCERTIFICATE_REASON
    * @generated
    */
   public void setBusinesscertificateReason(String businesscertificateReason){
      this.businesscertificateReason = businesscertificateReason;
   }

   /**
    * getter for BUSINESSLICENSE_SCORE
    * @generated
    */
   public BigDecimal getBusinesslicenseScore(){
      return this.businesslicenseScore;
   }
   /**
    * setter for BUSINESSLICENSE_SCORE
    * @generated
    */
   public void setBusinesslicenseScore(BigDecimal businesslicenseScore){
      this.businesslicenseScore = businesslicenseScore;
   }

   /**
    * getter for BUSINESSLICENSE_REASON
    * @generated
    */
   public String getBusinesslicenseReason(){
      return this.businesslicenseReason;
   }
   /**
    * setter for BUSINESSLICENSE_REASON
    * @generated
    */
   public void setBusinesslicenseReason(String businesslicenseReason){
      this.businesslicenseReason = businesslicenseReason;
   }

   /**
    * getter for TAXCERTIFICATE_SCORE
    * @generated
    */
   public BigDecimal getTaxcertificateScore(){
      return this.taxcertificateScore;
   }
   /**
    * setter for TAXCERTIFICATE_SCORE
    * @generated
    */
   public void setTaxcertificateScore(BigDecimal taxcertificateScore){
      this.taxcertificateScore = taxcertificateScore;
   }

   /**
    * getter for TAXCERTIFICATE_REASON
    * @generated
    */
   public String getTaxcertificateReason(){
      return this.taxcertificateReason;
   }
   /**
    * setter for TAXCERTIFICATE_REASON
    * @generated
    */
   public void setTaxcertificateReason(String taxcertificateReason){
      this.taxcertificateReason = taxcertificateReason;
   }

   /**
    * getter for FEE_SCORE
    * @generated
    */
   public BigDecimal getFeeScore(){
      return this.feeScore;
   }
   /**
    * setter for FEE_SCORE
    * @generated
    */
   public void setFeeScore(BigDecimal feeScore){
      this.feeScore = feeScore;
   }

   /**
    * getter for FEE_REASON
    * @generated
    */
   public String getFeeReason(){
      return this.feeReason;
   }
   /**
    * setter for FEE_REASON
    * @generated
    */
   public void setFeeReason(String feeReason){
      this.feeReason = feeReason;
   }

   /**
    * getter for PURCHASEGRAVES_SCORE
    * @generated
    */
   public BigDecimal getPurchasegravesScore(){
      return this.purchasegravesScore;
   }
   /**
    * setter for PURCHASEGRAVES_SCORE
    * @generated
    */
   public void setPurchasegravesScore(BigDecimal purchasegravesScore){
      this.purchasegravesScore = purchasegravesScore;
   }

   /**
    * getter for PURCHASEGRAVES_REASON
    * @generated
    */
   public String getPurchasegravesReason(){
      return this.purchasegravesReason;
   }
   /**
    * setter for PURCHASEGRAVES_REASON
    * @generated
    */
   public void setPurchasegravesReason(String purchasegravesReason){
      this.purchasegravesReason = purchasegravesReason;
   }

   /**
    * getter for PLEDGE_SCORE
    * @generated
    */
   public BigDecimal getPledgeScore(){
      return this.pledgeScore;
   }
   /**
    * setter for PLEDGE_SCORE
    * @generated
    */
   public void setPledgeScore(BigDecimal pledgeScore){
      this.pledgeScore = pledgeScore;
   }

   /**
    * getter for PLEDGE_REASON
    * @generated
    */
   public String getPledgeReason(){
      return this.pledgeReason;
   }
   /**
    * setter for PLEDGE_REASON
    * @generated
    */
   public void setPledgeReason(String pledgeReason){
      this.pledgeReason = pledgeReason;
   }

   /**
    * getter for STAFFRESPONSIBILITIES_SCORE
    * @generated
    */
   public BigDecimal getStaffresponsibilitiesScore(){
      return this.staffresponsibilitiesScore;
   }
   /**
    * setter for STAFFRESPONSIBILITIES_SCORE
    * @generated
    */
   public void setStaffresponsibilitiesScore(BigDecimal staffresponsibilitiesScore){
      this.staffresponsibilitiesScore = staffresponsibilitiesScore;
   }

   /**
    * getter for STAFFRESPONSIBILITIES_REASON
    * @generated
    */
   public String getStaffresponsibilitiesReason(){
      return this.staffresponsibilitiesReason;
   }
   /**
    * setter for STAFFRESPONSIBILITIES_REASON
    * @generated
    */
   public void setStaffresponsibilitiesReason(String staffresponsibilitiesReason){
      this.staffresponsibilitiesReason = staffresponsibilitiesReason;
   }

   /**
    * getter for OFFICE_TIME_SCORE
    * @generated
    */
   public BigDecimal getOfficeTimeScore(){
      return this.officeTimeScore;
   }
   /**
    * setter for OFFICE_TIME_SCORE
    * @generated
    */
   public void setOfficeTimeScore(BigDecimal officeTimeScore){
      this.officeTimeScore = officeTimeScore;
   }

   /**
    * getter for OFFICE_TIME_REASON
    * @generated
    */
   public String getOfficeTimeReason(){
      return this.officeTimeReason;
   }
   /**
    * setter for OFFICE_TIME_REASON
    * @generated
    */
   public void setOfficeTimeReason(String officeTimeReason){
      this.officeTimeReason = officeTimeReason;
   }

   /**
    * getter for PROVINCIALDOCUMENTS_SCORE
    * @generated
    */
   public BigDecimal getProvincialdocumentsScore(){
      return this.provincialdocumentsScore;
   }
   /**
    * setter for PROVINCIALDOCUMENTS_SCORE
    * @generated
    */
   public void setProvincialdocumentsScore(BigDecimal provincialdocumentsScore){
      this.provincialdocumentsScore = provincialdocumentsScore;
   }

   /**
    * getter for PROVINCIALDOCUMENTS_REASON
    * @generated
    */
   public String getProvincialdocumentsReason(){
      return this.provincialdocumentsReason;
   }
   /**
    * setter for PROVINCIALDOCUMENTS_REASON
    * @generated
    */
   public void setProvincialdocumentsReason(String provincialdocumentsReason){
      this.provincialdocumentsReason = provincialdocumentsReason;
   }

   /**
    * getter for DEPARTMENTCHARGES_SCORE
    * @generated
    */
   public BigDecimal getDepartmentchargesScore(){
      return this.departmentchargesScore;
   }
   /**
    * setter for DEPARTMENTCHARGES_SCORE
    * @generated
    */
   public void setDepartmentchargesScore(BigDecimal departmentchargesScore){
      this.departmentchargesScore = departmentchargesScore;
   }

   /**
    * getter for DEPARTMENTCHARGES_REASON
    * @generated
    */
   public String getDepartmentchargesReason(){
      return this.departmentchargesReason;
   }
   /**
    * setter for DEPARTMENTCHARGES_REASON
    * @generated
    */
   public void setDepartmentchargesReason(String departmentchargesReason){
      this.departmentchargesReason = departmentchargesReason;
   }

   /**
    * getter for NOOFFENSE_SCORE
    * @generated
    */
   public BigDecimal getNooffenseScore(){
      return this.nooffenseScore;
   }
   /**
    * setter for NOOFFENSE_SCORE
    * @generated
    */
   public void setNooffenseScore(BigDecimal nooffenseScore){
      this.nooffenseScore = nooffenseScore;
   }

   /**
    * getter for NOOFFENSE_REASON
    * @generated
    */
   public String getNooffenseReason(){
      return this.nooffenseReason;
   }
   /**
    * setter for NOOFFENSE_REASON
    * @generated
    */
   public void setNooffenseReason(String nooffenseReason){
      this.nooffenseReason = nooffenseReason;
   }

   /**
    * getter for PROPERGRAVE_SCORE
    * @generated
    */
   public BigDecimal getPropergraveScore(){
      return this.propergraveScore;
   }
   /**
    * setter for PROPERGRAVE_SCORE
    * @generated
    */
   public void setPropergraveScore(BigDecimal propergraveScore){
      this.propergraveScore = propergraveScore;
   }

   /**
    * getter for PROPERGRAVE_REASON
    * @generated
    */
   public String getPropergraveReason(){
      return this.propergraveReason;
   }
   /**
    * setter for PROPERGRAVE_REASON
    * @generated
    */
   public void setPropergraveReason(String propergraveReason){
      this.propergraveReason = propergraveReason;
   }

   /**
    * getter for BOXESANDBAGS_SCORE
    * @generated
    */
   public BigDecimal getBoxesandbagsScore(){
      return this.boxesandbagsScore;
   }
   /**
    * setter for BOXESANDBAGS_SCORE
    * @generated
    */
   public void setBoxesandbagsScore(BigDecimal boxesandbagsScore){
      this.boxesandbagsScore = boxesandbagsScore;
   }

   /**
    * getter for BOXESANDBAGS_REASON
    * @generated
    */
   public String getBoxesandbagsReason(){
      return this.boxesandbagsReason;
   }
   /**
    * setter for BOXESANDBAGS_REASON
    * @generated
    */
   public void setBoxesandbagsReason(String boxesandbagsReason){
      this.boxesandbagsReason = boxesandbagsReason;
   }

   /**
    * getter for DEATHCERTIFICATE_SCORE
    * @generated
    */
   public BigDecimal getDeathcertificateScore(){
      return this.deathcertificateScore;
   }
   /**
    * setter for DEATHCERTIFICATE_SCORE
    * @generated
    */
   public void setDeathcertificateScore(BigDecimal deathcertificateScore){
      this.deathcertificateScore = deathcertificateScore;
   }

   /**
    * getter for DEATHCERTIFICATE_REASON
    * @generated
    */
   public String getDeathcertificateReason(){
      return this.deathcertificateReason;
   }
   /**
    * setter for DEATHCERTIFICATE_REASON
    * @generated
    */
   public void setDeathcertificateReason(String deathcertificateReason){
      this.deathcertificateReason = deathcertificateReason;
   }

   /**
    * getter for ASHESCONTRACT_SCORE
    * @generated
    */
   public BigDecimal getAshescontractScore(){
      return this.ashescontractScore;
   }
   /**
    * setter for ASHESCONTRACT_SCORE
    * @generated
    */
   public void setAshescontractScore(BigDecimal ashescontractScore){
      this.ashescontractScore = ashescontractScore;
   }

   /**
    * getter for ASHESCONTRACT_REASON
    * @generated
    */
   public String getAshescontractReason(){
      return this.ashescontractReason;
   }
   /**
    * setter for ASHESCONTRACT_REASON
    * @generated
    */
   public void setAshescontractReason(String ashescontractReason){
      this.ashescontractReason = ashescontractReason;
   }

   /**
    * getter for CONTRACTORSSIGNATURE_SCORE
    * @generated
    */
   public BigDecimal getContractorssignatureScore(){
      return this.contractorssignatureScore;
   }
   /**
    * setter for CONTRACTORSSIGNATURE_SCORE
    * @generated
    */
   public void setContractorssignatureScore(BigDecimal contractorssignatureScore){
      this.contractorssignatureScore = contractorssignatureScore;
   }

   /**
    * getter for CONTRACTORSSIGNATURE_REASON
    * @generated
    */
   public String getContractorssignatureReason(){
      return this.contractorssignatureReason;
   }
   /**
    * setter for CONTRACTORSSIGNATURE_REASON
    * @generated
    */
   public void setContractorssignatureReason(String contractorssignatureReason){
      this.contractorssignatureReason = contractorssignatureReason;
   }

   /**
    * getter for CONTRACTORID_SCORE
    * @generated
    */
   public BigDecimal getContractoridScore(){
      return this.contractoridScore;
   }
   /**
    * setter for CONTRACTORID_SCORE
    * @generated
    */
   public void setContractoridScore(BigDecimal contractoridScore){
      this.contractoridScore = contractoridScore;
   }

   /**
    * getter for CONTRACTORID_REASON
    * @generated
    */
   public String getContractoridReason(){
      return this.contractoridReason;
   }
   /**
    * setter for CONTRACTORID_REASON
    * @generated
    */
   public void setContractoridReason(String contractoridReason){
      this.contractoridReason = contractoridReason;
   }

   /**
    * getter for ADDCONTRACT_SCORE
    * @generated
    */
   public BigDecimal getAddcontractScore(){
      return this.addcontractScore;
   }
   /**
    * setter for ADDCONTRACT_SCORE
    * @generated
    */
   public void setAddcontractScore(BigDecimal addcontractScore){
      this.addcontractScore = addcontractScore;
   }

   /**
    * getter for ADDCONTRACT_REASON
    * @generated
    */
   public String getAddcontractReason(){
      return this.addcontractReason;
   }
   /**
    * setter for ADDCONTRACT_REASON
    * @generated
    */
   public void setAddcontractReason(String addcontractReason){
      this.addcontractReason = addcontractReason;
   }

   /**
    * getter for OTHERMATERIALS_SCORE
    * @generated
    */
   public BigDecimal getOthermaterialsScore(){
      return this.othermaterialsScore;
   }
   /**
    * setter for OTHERMATERIALS_SCORE
    * @generated
    */
   public void setOthermaterialsScore(BigDecimal othermaterialsScore){
      this.othermaterialsScore = othermaterialsScore;
   }

   /**
    * getter for OTHERMATERIALS_REASON
    * @generated
    */
   public String getOthermaterialsReason(){
      return this.othermaterialsReason;
   }
   /**
    * setter for OTHERMATERIALS_REASON
    * @generated
    */
   public void setOthermaterialsReason(String othermaterialsReason){
      this.othermaterialsReason = othermaterialsReason;
   }

   /**
    * getter for TOMBSTONE_TWENTY_SCORE
    * @generated
    */
   public BigDecimal getTombstoneTwentyScore(){
      return this.tombstoneTwentyScore;
   }
   /**
    * setter for TOMBSTONE_TWENTY_SCORE
    * @generated
    */
   public void setTombstoneTwentyScore(BigDecimal tombstoneTwentyScore){
      this.tombstoneTwentyScore = tombstoneTwentyScore;
   }

   /**
    * getter for TOMBSTONE_TWENTY_REASON
    * @generated
    */
   public String getTombstoneTwentyReason(){
      return this.tombstoneTwentyReason;
   }
   /**
    * setter for TOMBSTONE_TWENTY_REASON
    * @generated
    */
   public void setTombstoneTwentyReason(String tombstoneTwentyReason){
      this.tombstoneTwentyReason = tombstoneTwentyReason;
   }

   /**
    * getter for TOMBSTONE_FIFTY_SCORE
    * @generated
    */
   public BigDecimal getTombstoneFiftyScore(){
      return this.tombstoneFiftyScore;
   }
   /**
    * setter for TOMBSTONE_FIFTY_SCORE
    * @generated
    */
   public void setTombstoneFiftyScore(BigDecimal tombstoneFiftyScore){
      this.tombstoneFiftyScore = tombstoneFiftyScore;
   }

   /**
    * getter for TOMBSTONE_FIFTY_REASON
    * @generated
    */
   public String getTombstoneFiftyReason(){
      return this.tombstoneFiftyReason;
   }
   /**
    * setter for TOMBSTONE_FIFTY_REASON
    * @generated
    */
   public void setTombstoneFiftyReason(String tombstoneFiftyReason){
      this.tombstoneFiftyReason = tombstoneFiftyReason;
   }

   /**
    * getter for TOMBSTONEOVERFIFTY_SCORE
    * @generated
    */
   public BigDecimal getTombstoneoverfiftyScore(){
      return this.tombstoneoverfiftyScore;
   }
   /**
    * setter for TOMBSTONEOVERFIFTY_SCORE
    * @generated
    */
   public void setTombstoneoverfiftyScore(BigDecimal tombstoneoverfiftyScore){
      this.tombstoneoverfiftyScore = tombstoneoverfiftyScore;
   }

   /**
    * getter for TOMBSTONEOVERFIFTY_REASON
    * @generated
    */
   public String getTombstoneoverfiftyReason(){
      return this.tombstoneoverfiftyReason;
   }
   /**
    * setter for TOMBSTONEOVERFIFTY_REASON
    * @generated
    */
   public void setTombstoneoverfiftyReason(String tombstoneoverfiftyReason){
      this.tombstoneoverfiftyReason = tombstoneoverfiftyReason;
   }

   /**
    * getter for OPERATINGAREA_SCORE
    * @generated
    */
   public BigDecimal getOperatingareaScore(){
      return this.operatingareaScore;
   }
   /**
    * setter for OPERATINGAREA_SCORE
    * @generated
    */
   public void setOperatingareaScore(BigDecimal operatingareaScore){
      this.operatingareaScore = operatingareaScore;
   }

   /**
    * getter for OPERATINGAREA_REASON
    * @generated
    */
   public String getOperatingareaReason(){
      return this.operatingareaReason;
   }
   /**
    * setter for OPERATINGAREA_REASON
    * @generated
    */
   public void setOperatingareaReason(String operatingareaReason){
      this.operatingareaReason = operatingareaReason;
   }

   /**
    * getter for ARCHIVESAREA_SCORE
    * @generated
    */
   public BigDecimal getArchivesareaScore(){
      return this.archivesareaScore;
   }
   /**
    * setter for ARCHIVESAREA_SCORE
    * @generated
    */
   public void setArchivesareaScore(BigDecimal archivesareaScore){
      this.archivesareaScore = archivesareaScore;
   }

   /**
    * getter for ARCHIVESAREA_REASON
    * @generated
    */
   public String getArchivesareaReason(){
      return this.archivesareaReason;
   }
   /**
    * setter for ARCHIVESAREA_REASON
    * @generated
    */
   public void setArchivesareaReason(String archivesareaReason){
      this.archivesareaReason = archivesareaReason;
   }

   /**
    * getter for OFFICEAREA_SCORE
    * @generated
    */
   public BigDecimal getOfficeareaScore(){
      return this.officeareaScore;
   }
   /**
    * setter for OFFICEAREA_SCORE
    * @generated
    */
   public void setOfficeareaScore(BigDecimal officeareaScore){
      this.officeareaScore = officeareaScore;
   }

   /**
    * getter for OFFICEAREA_REASON
    * @generated
    */
   public String getOfficeareaReason(){
      return this.officeareaReason;
   }
   /**
    * setter for OFFICEAREA_REASON
    * @generated
    */
   public void setOfficeareaReason(String officeareaReason){
      this.officeareaReason = officeareaReason;
   }

   /**
    * getter for ROADSAFETY_SCORE
    * @generated
    */
   public BigDecimal getRoadsafetyScore(){
      return this.roadsafetyScore;
   }
   /**
    * setter for ROADSAFETY_SCORE
    * @generated
    */
   public void setRoadsafetyScore(BigDecimal roadsafetyScore){
      this.roadsafetyScore = roadsafetyScore;
   }

   /**
    * getter for ROADSAFETY_REASON
    * @generated
    */
   public String getRoadsafetyReason(){
      return this.roadsafetyReason;
   }
   /**
    * setter for ROADSAFETY_REASON
    * @generated
    */
   public void setRoadsafetyReason(String roadsafetyReason){
      this.roadsafetyReason = roadsafetyReason;
   }

   /**
    * getter for CIVILIZATION_MEMORIAL_SCORE
    * @generated
    */
   public BigDecimal getCivilizationMemorialScore(){
      return this.civilizationMemorialScore;
   }
   /**
    * setter for CIVILIZATION_MEMORIAL_SCORE
    * @generated
    */
   public void setCivilizationMemorialScore(BigDecimal civilizationMemorialScore){
      this.civilizationMemorialScore = civilizationMemorialScore;
   }

   /**
    * getter for CIVILIZATION_MEMORIAL_REASON
    * @generated
    */
   public String getCivilizationMemorialReason(){
      return this.civilizationMemorialReason;
   }
   /**
    * setter for CIVILIZATION_MEMORIAL_REASON
    * @generated
    */
   public void setCivilizationMemorialReason(String civilizationMemorialReason){
      this.civilizationMemorialReason = civilizationMemorialReason;
   }

   /**
    * getter for FIRE_MEMORIAL_SCORE
    * @generated
    */
   public BigDecimal getFireMemorialScore(){
      return this.fireMemorialScore;
   }
   /**
    * setter for FIRE_MEMORIAL_SCORE
    * @generated
    */
   public void setFireMemorialScore(BigDecimal fireMemorialScore){
      this.fireMemorialScore = fireMemorialScore;
   }

   /**
    * getter for FIRE_MEMORIAL_REASON
    * @generated
    */
   public String getFireMemorialReason(){
      return this.fireMemorialReason;
   }
   /**
    * setter for FIRE_MEMORIAL_REASON
    * @generated
    */
   public void setFireMemorialReason(String fireMemorialReason){
      this.fireMemorialReason = fireMemorialReason;
   }

   /**
    * getter for ECOLOGY_SCORE
    * @generated
    */
   public BigDecimal getEcologyScore(){
      return this.ecologyScore;
   }
   /**
    * setter for ECOLOGY_SCORE
    * @generated
    */
   public void setEcologyScore(BigDecimal ecologyScore){
      this.ecologyScore = ecologyScore;
   }

   /**
    * getter for ECOLOGY_REASON
    * @generated
    */
   public String getEcologyReason(){
      return this.ecologyReason;
   }
   /**
    * setter for ECOLOGY_REASON
    * @generated
    */
   public void setEcologyReason(String ecologyReason){
      this.ecologyReason = ecologyReason;
   }

   /**
    * getter for GREEN_COVERAGE_SCORE
    * @generated
    */
   public BigDecimal getGreenCoverageScore(){
      return this.greenCoverageScore;
   }
   /**
    * setter for GREEN_COVERAGE_SCORE
    * @generated
    */
   public void setGreenCoverageScore(BigDecimal greenCoverageScore){
      this.greenCoverageScore = greenCoverageScore;
   }

   /**
    * getter for GREEN_COVERAGE_REASON
    * @generated
    */
   public String getGreenCoverageReason(){
      return this.greenCoverageReason;
   }
   /**
    * setter for GREEN_COVERAGE_REASON
    * @generated
    */
   public void setGreenCoverageReason(String greenCoverageReason){
      this.greenCoverageReason = greenCoverageReason;
   }

   /**
    * getter for GREENAREA_RATIO_SCORE
    * @generated
    */
   public BigDecimal getGreenareaRatioScore(){
      return this.greenareaRatioScore;
   }
   /**
    * setter for GREENAREA_RATIO_SCORE
    * @generated
    */
   public void setGreenareaRatioScore(BigDecimal greenareaRatioScore){
      this.greenareaRatioScore = greenareaRatioScore;
   }

   /**
    * getter for GREENAREA_RATIO_REASON
    * @generated
    */
   public String getGreenareaRatioReason(){
      return this.greenareaRatioReason;
   }
   /**
    * setter for GREENAREA_RATIO_REASON
    * @generated
    */
   public void setGreenareaRatioReason(String greenareaRatioReason){
      this.greenareaRatioReason = greenareaRatioReason;
   }

   /**
    * getter for BURIAL_TOMB_SCORE
    * @generated
    */
   public BigDecimal getBurialTombScore(){
      return this.burialTombScore;
   }
   /**
    * setter for BURIAL_TOMB_SCORE
    * @generated
    */
   public void setBurialTombScore(BigDecimal burialTombScore){
      this.burialTombScore = burialTombScore;
   }

   /**
    * getter for BURIAL_TOMB_REASON
    * @generated
    */
   public String getBurialTombReason(){
      return this.burialTombReason;
   }
   /**
    * setter for BURIAL_TOMB_REASON
    * @generated
    */
   public void setBurialTombReason(String burialTombReason){
      this.burialTombReason = burialTombReason;
   }

   /**
    * getter for BURIAL_CONFORM_SCORE
    * @generated
    */
   public BigDecimal getBurialConformScore(){
      return this.burialConformScore;
   }
   /**
    * setter for BURIAL_CONFORM_SCORE
    * @generated
    */
   public void setBurialConformScore(BigDecimal burialConformScore){
      this.burialConformScore = burialConformScore;
   }

   /**
    * getter for BURIAL_CONFORM_REASON
    * @generated
    */
   public String getBurialConformReason(){
      return this.burialConformReason;
   }
   /**
    * setter for BURIAL_CONFORM_REASON
    * @generated
    */
   public void setBurialConformReason(String burialConformReason){
      this.burialConformReason = burialConformReason;
   }

   /**
    * getter for ACCEPTANCE_COMPLIANCE_SCORE
    * @generated
    */
   public BigDecimal getAcceptanceComplianceScore(){
      return this.acceptanceComplianceScore;
   }
   /**
    * setter for ACCEPTANCE_COMPLIANCE_SCORE
    * @generated
    */
   public void setAcceptanceComplianceScore(BigDecimal acceptanceComplianceScore){
      this.acceptanceComplianceScore = acceptanceComplianceScore;
   }

   /**
    * getter for ACCEPTANCE_COMPLIANCE_REASON
    * @generated
    */
   public String getAcceptanceComplianceReason(){
      return this.acceptanceComplianceReason;
   }
   /**
    * setter for ACCEPTANCE_COMPLIANCE_REASON
    * @generated
    */
   public void setAcceptanceComplianceReason(String acceptanceComplianceReason){
      this.acceptanceComplianceReason = acceptanceComplianceReason;
   }

   /**
    * getter for CHANGE_COMPLIANCE_SCORE
    * @generated
    */
   public BigDecimal getChangeComplianceScore(){
      return this.changeComplianceScore;
   }
   /**
    * setter for CHANGE_COMPLIANCE_SCORE
    * @generated
    */
   public void setChangeComplianceScore(BigDecimal changeComplianceScore){
      this.changeComplianceScore = changeComplianceScore;
   }

   /**
    * getter for CHANGE_COMPLIANCE_REASON
    * @generated
    */
   public String getChangeComplianceReason(){
      return this.changeComplianceReason;
   }
   /**
    * setter for CHANGE_COMPLIANCE_REASON
    * @generated
    */
   public void setChangeComplianceReason(String changeComplianceReason){
      this.changeComplianceReason = changeComplianceReason;
   }

   /**
    * getter for PAYMENT_CERTIFICATE_SCORE
    * @generated
    */
   public BigDecimal getPaymentCertificateScore(){
      return this.paymentCertificateScore;
   }
   /**
    * setter for PAYMENT_CERTIFICATE_SCORE
    * @generated
    */
   public void setPaymentCertificateScore(BigDecimal paymentCertificateScore){
      this.paymentCertificateScore = paymentCertificateScore;
   }

   /**
    * getter for PAYMENT_CERTIFICATE_REASON
    * @generated
    */
   public String getPaymentCertificateReason(){
      return this.paymentCertificateReason;
   }
   /**
    * setter for PAYMENT_CERTIFICATE_REASON
    * @generated
    */
   public void setPaymentCertificateReason(String paymentCertificateReason){
      this.paymentCertificateReason = paymentCertificateReason;
   }

   /**
    * getter for AGENCIES_SCORE
    * @generated
    */
   public BigDecimal getAgenciesScore(){
      return this.agenciesScore;
   }
   /**
    * setter for AGENCIES_SCORE
    * @generated
    */
   public void setAgenciesScore(BigDecimal agenciesScore){
      this.agenciesScore = agenciesScore;
   }

   /**
    * getter for AGENCIES_REASON
    * @generated
    */
   public String getAgenciesReason(){
      return this.agenciesReason;
   }
   /**
    * setter for AGENCIES_REASON
    * @generated
    */
   public void setAgenciesReason(String agenciesReason){
      this.agenciesReason = agenciesReason;
   }

   /**
    * getter for BUSINESS_TRAINING_SCORE
    * @generated
    */
   public BigDecimal getBusinessTrainingScore(){
      return this.businessTrainingScore;
   }
   /**
    * setter for BUSINESS_TRAINING_SCORE
    * @generated
    */
   public void setBusinessTrainingScore(BigDecimal businessTrainingScore){
      this.businessTrainingScore = businessTrainingScore;
   }

   /**
    * getter for BUSINESS_TRAINING_REASON
    * @generated
    */
   public String getBusinessTrainingReason(){
      return this.businessTrainingReason;
   }
   /**
    * setter for BUSINESS_TRAINING_REASON
    * @generated
    */
   public void setBusinessTrainingReason(String businessTrainingReason){
      this.businessTrainingReason = businessTrainingReason;
   }

   /**
    * getter for SYSTEM_SOUND_SCORE
    * @generated
    */
   public BigDecimal getSystemSoundScore(){
      return this.systemSoundScore;
   }
   /**
    * setter for SYSTEM_SOUND_SCORE
    * @generated
    */
   public void setSystemSoundScore(BigDecimal systemSoundScore){
      this.systemSoundScore = systemSoundScore;
   }

   /**
    * getter for SYSTEM_SOUND_REASON
    * @generated
    */
   public String getSystemSoundReason(){
      return this.systemSoundReason;
   }
   /**
    * setter for SYSTEM_SOUND_REASON
    * @generated
    */
   public void setSystemSoundReason(String systemSoundReason){
      this.systemSoundReason = systemSoundReason;
   }

   /**
    * getter for CONTINGENCY_PLANS_SCORE
    * @generated
    */
   public BigDecimal getContingencyPlansScore(){
      return this.contingencyPlansScore;
   }
   /**
    * setter for CONTINGENCY_PLANS_SCORE
    * @generated
    */
   public void setContingencyPlansScore(BigDecimal contingencyPlansScore){
      this.contingencyPlansScore = contingencyPlansScore;
   }

   /**
    * getter for CONTINGENCY_PLANS_REASON
    * @generated
    */
   public String getContingencyPlansReason(){
      return this.contingencyPlansReason;
   }
   /**
    * setter for CONTINGENCY_PLANS_REASON
    * @generated
    */
   public void setContingencyPlansReason(String contingencyPlansReason){
      this.contingencyPlansReason = contingencyPlansReason;
   }

   /**
    * getter for INFORMATION_SCORE
    * @generated
    */
   public BigDecimal getInformationScore(){
      return this.informationScore;
   }
   /**
    * setter for INFORMATION_SCORE
    * @generated
    */
   public void setInformationScore(BigDecimal informationScore){
      this.informationScore = informationScore;
   }

   /**
    * getter for INFORMATION_REASON
    * @generated
    */
   public String getInformationReason(){
      return this.informationReason;
   }
   /**
    * setter for INFORMATION_REASON
    * @generated
    */
   public void setInformationReason(String informationReason){
      this.informationReason = informationReason;
   }
public BigDecimal getTombstoneTwentyNum() {
	return tombstoneTwentyNum;
}
public void setTombstoneTwentyNum(BigDecimal tombstoneTwentyNum) {
	this.tombstoneTwentyNum = tombstoneTwentyNum;
}
public BigDecimal getTombstoneFiftyNum() {
	return tombstoneFiftyNum;
}
public void setTombstoneFiftyNum(BigDecimal tombstoneFiftyNum) {
	this.tombstoneFiftyNum = tombstoneFiftyNum;
}
public BigDecimal getTombstoneoverfiftyNum() {
	return tombstoneoverfiftyNum;
}
public void setTombstoneoverfiftyNum(BigDecimal tombstoneoverfiftyNum) {
	this.tombstoneoverfiftyNum = tombstoneoverfiftyNum;
}
public BigDecimal getOperatingareaNum() {
	return operatingareaNum;
}
public void setOperatingareaNum(BigDecimal operatingareaNum) {
	this.operatingareaNum = operatingareaNum;
}
public BigDecimal getArchivesareaNum() {
	return archivesareaNum;
}
public void setArchivesareaNum(BigDecimal archivesareaNum) {
	this.archivesareaNum = archivesareaNum;
}
public BigDecimal getOfficeareaNum() {
	return officeareaNum;
}
public void setOfficeareaNum(BigDecimal officeareaNum) {
	this.officeareaNum = officeareaNum;
}
public BigDecimal getEcologyNum() {
	return ecologyNum;
}
public void setEcologyNum(BigDecimal ecologyNum) {
	this.ecologyNum = ecologyNum;
}
public BigDecimal getGreenCoverageNum() {
	return greenCoverageNum;
}
public void setGreenCoverageNum(BigDecimal greenCoverageNum) {
	this.greenCoverageNum = greenCoverageNum;
}
public BigDecimal getGreenareaRatioNum() {
	return greenareaRatioNum;
}
public void setGreenareaRatioNum(BigDecimal greenareaRatioNum) {
	this.greenareaRatioNum = greenareaRatioNum;
}

}