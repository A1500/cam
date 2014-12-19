package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:CdcFacilitiesReport
 * @description:
 * @author:
 * @since:2012-02-09
 * @version:1.0
 */
@Table(tableName = "CDC_FACILITIES_REPORT", keyFields = "recordId")
public class CdcFacilitiesReport extends StatefulDatabean {
	
	// 统计内码
	private String recordId;
	
	// 社区数量
	private BigDecimal communityNum;
	
	// 办公服务用房数量
	private BigDecimal offNum;
	
	// 办公服务用房建筑面积
	private BigDecimal offArea;
	
	// 办公服务用房投入资金
	private BigDecimal offMon;
	
	// 办公服务用房资金来源财政拨款
	private BigDecimal offFinanceMon;
	
	// 办公服务用房资金来源自筹
	private BigDecimal offSelfMon;
	
	// 办公服务用房资金来源社会捐助
	private BigDecimal offEndowMon;
	
	// 办公服务用房资金来源其他
	private BigDecimal offOtherMon;
	
	// 办公服务用房投入使用年份
	private BigDecimal offYear;
	
	// 社区服务站个数
	private BigDecimal serviceNum;
	
	// 社区服务站面积
	private BigDecimal serviceArea;

	// 社区服务站投入资金
	private BigDecimal serviceMon;
	
	// 社区服务站资金来源财政拨款
	private BigDecimal serviceFinanceMon;
	
	// 社区服务站资金来源自筹
	private BigDecimal serviceSelfMon;
	
	// 社区服务站资金来源社会捐助
	private BigDecimal serviceEndowMon;
	
	// 社区服务站资金来源其他
	private BigDecimal serviceOtherMon;
	
	// 社区服务站投入使用年份
	private BigDecimal serviceYear;
	
	
	// 社区警务室个数
	private BigDecimal policeNum;
	
	// 社区警务室面积
	private BigDecimal policeArea;

	// 社区警务室投入资金
	private BigDecimal policeMon;
	
	// 社区警务室资金来源财政拨款
	private BigDecimal policeFinanceMon;
	
	// 社区警务室资金来源自筹
	private BigDecimal policeSelfMon;
	
	// 社区警务室资金来源社会捐助
	private BigDecimal policeEndowMon;
	
	// 社区警务室资金来源其他
	private BigDecimal policeOtherMon;
	
	// 社区警务室投入使用年份
	private BigDecimal policeYear;
	
	
	// 社区卫生室个数
	private BigDecimal clinicNum;
	
	// 社区卫生室面积
	private BigDecimal clinicArea;

	// 社区卫生室投入资金
	private BigDecimal clinicMon;
	
	// 社区卫生室资金来源财政拨款
	private BigDecimal clinicFinanceMon;
	
	// 社区卫生室资金来源自筹
	private BigDecimal clinicSelfMon;
	
	// 社区卫生室资金来源社会捐助
	private BigDecimal clinicEndowMon;
	
	// 社区卫生室资金来源其他
	private BigDecimal clinicOtherMon;
	
	// 社区卫生室投入使用年份
	private BigDecimal clinicYear;
	
	
	// 社区图书室个数
	private BigDecimal libNum;
	
	// 社区图书室面积
	private BigDecimal libArea;

	// 社区图书室投入资金
	private BigDecimal libMon;
	
	// 社区图书室资金来源财政拨款
	private BigDecimal libFinanceMon;
	
	// 社区图书室资金来源自筹
	private BigDecimal libSelfMon;
	
	// 社区图书室资金来源社会捐助
	private BigDecimal libEndowMon;
	
	// 社区图书室资金来源其他
	private BigDecimal libOtherMon;
	
	// 社区图书室投入使用年份
	private BigDecimal libYear;
	
	
	// 社区活动室个数
	private BigDecimal actionNum;
	
	// 社区活动室面积
	private BigDecimal actionArea;

	// 社区活动室投入资金
	private BigDecimal actionMon;
	
	// 社区活动室资金来源财政拨款
	private BigDecimal actionFinanceMon;
	
	// 社区活动室资金来源自筹
	private BigDecimal actionSelfMon;
	
	// 社区活动室资金来源社会捐助
	private BigDecimal actionEndowMon;
	
	// 社区活动室资金来源其他
	private BigDecimal actionOtherMon;
	
	// 社区活动室投入使用年份
	private BigDecimal actionYear;
	
	
	// 残疾人活动室个数
	private BigDecimal handNum;
	
	// 残疾人活动室面积
	private BigDecimal handArea;

	// 残疾人活动室投入资金
	private BigDecimal handMon;
	
	// 残疾人活动室资金来源财政拨款
	private BigDecimal handFinanceMon;
	
	// 残疾人活动室资金来源自筹
	private BigDecimal handSelfMon;
	
	// 残疾人活动室资金来源社会捐助
	private BigDecimal handEndowMon;
	
	// 残疾人活动室资金来源其他
	private BigDecimal handOtherMon;
	
	// 残疾人活动室投入使用年份
	private BigDecimal handYear;
	
	
	// 其他用房个数
	private BigDecimal otherNum;
	
	// 其他用房面积
	private BigDecimal otherArea;

	// 其他用房投入资金
	private BigDecimal otherMon;
	
	// 其他用房资金来源财政拨款
	private BigDecimal otherFinanceMon;
	
	//其他用房资金来源自筹
	private BigDecimal otherSelfMon;
	
	// 其他用房资金来源社会捐助
	private BigDecimal otherEndowMon;
	
	// 其他用房资金来源其他
	private BigDecimal otherOtherMon;
	
	// 室外活动室数量
	private BigDecimal outNum;
	
	// 室外活动室面积
	private BigDecimal outArea;
	
	// 室外活动室投入资金
	private BigDecimal outMon;
	
	// 室外活动室财政拨款
	private BigDecimal outFinanceMon;
	
	// 室外活动室自筹
	private BigDecimal outSelfMon;
	
	// 室外活动室社会捐助
	private BigDecimal outEnbowMon;
	
	// 室外活动室其他
	private BigDecimal outOtherMon;
	
	// 室外活动室投入使用年份
	private String outYear;
	
	// 填报单位行政区划
	private String organCode;
	
	// 填报单位名称
	private String organName;
	
	// 所属上级行政区划
	private String parentCode;
	
	// 填报报表类型
	private String reportType;
	
	// 填报日期
	private String reportDate;
	
	// 上报状态
	private String status;
	
	// 上报日期
	private String submitDate;

	// 创建日期
	private String createTime;
	

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public BigDecimal getCommunityNum() {
		return communityNum;
	}

	public void setCommunityNum(BigDecimal communityNum) {
		this.communityNum = communityNum;
	}

	public BigDecimal getOffNum() {
		return offNum;
	}

	public void setOffNum(BigDecimal offNum) {
		this.offNum = offNum;
	}

	public BigDecimal getOffArea() {
		return offArea;
	}

	public void setOffArea(BigDecimal offArea) {
		this.offArea = offArea;
	}

	public BigDecimal getOffMon() {
		return offMon;
	}

	public void setOffMon(BigDecimal offMon) {
		this.offMon = offMon;
	}

	public BigDecimal getOffFinanceMon() {
		return offFinanceMon;
	}

	public void setOffFinanceMon(BigDecimal offFinanceMon) {
		this.offFinanceMon = offFinanceMon;
	}

	public BigDecimal getOffSelfMon() {
		return offSelfMon;
	}

	public void setOffSelfMon(BigDecimal offSelfMon) {
		this.offSelfMon = offSelfMon;
	}

	public BigDecimal getOffEndowMon() {
		return offEndowMon;
	}

	public void setOffEndowMon(BigDecimal offEndowMon) {
		this.offEndowMon = offEndowMon;
	}

	public BigDecimal getOffOtherMon() {
		return offOtherMon;
	}

	public void setOffOtherMon(BigDecimal offOtherMon) {
		this.offOtherMon = offOtherMon;
	}

	public BigDecimal getOffYear() {
		return offYear;
	}

	public void setOffYear(BigDecimal offYear) {
		this.offYear = offYear;
	}

	public BigDecimal getServiceNum() {
		return serviceNum;
	}

	public void setServiceNum(BigDecimal serviceNum) {
		this.serviceNum = serviceNum;
	}

	public BigDecimal getServiceArea() {
		return serviceArea;
	}

	public void setServiceArea(BigDecimal serviceArea) {
		this.serviceArea = serviceArea;
	}

	public BigDecimal getServiceMon() {
		return serviceMon;
	}

	public void setServiceMon(BigDecimal serviceMon) {
		this.serviceMon = serviceMon;
	}

	public BigDecimal getServiceFinanceMon() {
		return serviceFinanceMon;
	}

	public void setServiceFinanceMon(BigDecimal serviceFinanceMon) {
		this.serviceFinanceMon = serviceFinanceMon;
	}

	public BigDecimal getServiceSelfMon() {
		return serviceSelfMon;
	}

	public void setServiceSelfMon(BigDecimal serviceSelfMon) {
		this.serviceSelfMon = serviceSelfMon;
	}

	public BigDecimal getServiceEndowMon() {
		return serviceEndowMon;
	}

	public void setServiceEndowMon(BigDecimal serviceEndowMon) {
		this.serviceEndowMon = serviceEndowMon;
	}

	public BigDecimal getServiceOtherMon() {
		return serviceOtherMon;
	}

	public void setServiceOtherMon(BigDecimal serviceOtherMon) {
		this.serviceOtherMon = serviceOtherMon;
	}

	public BigDecimal getServiceYear() {
		return serviceYear;
	}

	public void setServiceYear(BigDecimal serviceYear) {
		this.serviceYear = serviceYear;
	}

	public BigDecimal getPoliceNum() {
		return policeNum;
	}

	public void setPoliceNum(BigDecimal policeNum) {
		this.policeNum = policeNum;
	}

	public BigDecimal getPoliceArea() {
		return policeArea;
	}

	public void setPoliceArea(BigDecimal policeArea) {
		this.policeArea = policeArea;
	}

	public BigDecimal getPoliceMon() {
		return policeMon;
	}

	public void setPoliceMon(BigDecimal policeMon) {
		this.policeMon = policeMon;
	}

	public BigDecimal getPoliceFinanceMon() {
		return policeFinanceMon;
	}

	public void setPoliceFinanceMon(BigDecimal policeFinanceMon) {
		this.policeFinanceMon = policeFinanceMon;
	}

	public BigDecimal getPoliceSelfMon() {
		return policeSelfMon;
	}

	public void setPoliceSelfMon(BigDecimal policeSelfMon) {
		this.policeSelfMon = policeSelfMon;
	}

	public BigDecimal getPoliceEndowMon() {
		return policeEndowMon;
	}

	public void setPoliceEndowMon(BigDecimal policeEndowMon) {
		this.policeEndowMon = policeEndowMon;
	}

	public BigDecimal getPoliceOtherMon() {
		return policeOtherMon;
	}

	public void setPoliceOtherMon(BigDecimal policeOtherMon) {
		this.policeOtherMon = policeOtherMon;
	}

	public BigDecimal getPoliceYear() {
		return policeYear;
	}

	public void setPoliceYear(BigDecimal policeYear) {
		this.policeYear = policeYear;
	}

	public BigDecimal getClinicNum() {
		return clinicNum;
	}

	public void setClinicNum(BigDecimal clinicNum) {
		this.clinicNum = clinicNum;
	}

	public BigDecimal getClinicArea() {
		return clinicArea;
	}

	public void setClinicArea(BigDecimal clinicArea) {
		this.clinicArea = clinicArea;
	}

	public BigDecimal getClinicMon() {
		return clinicMon;
	}

	public void setClinicMon(BigDecimal clinicMon) {
		this.clinicMon = clinicMon;
	}

	public BigDecimal getClinicFinanceMon() {
		return clinicFinanceMon;
	}

	public void setClinicFinanceMon(BigDecimal clinicFinanceMon) {
		this.clinicFinanceMon = clinicFinanceMon;
	}

	public BigDecimal getClinicSelfMon() {
		return clinicSelfMon;
	}

	public void setClinicSelfMon(BigDecimal clinicSelfMon) {
		this.clinicSelfMon = clinicSelfMon;
	}

	public BigDecimal getClinicEndowMon() {
		return clinicEndowMon;
	}

	public void setClinicEndowMon(BigDecimal clinicEndowMon) {
		this.clinicEndowMon = clinicEndowMon;
	}

	public BigDecimal getClinicOtherMon() {
		return clinicOtherMon;
	}

	public void setClinicOtherMon(BigDecimal clinicOtherMon) {
		this.clinicOtherMon = clinicOtherMon;
	}

	public BigDecimal getClinicYear() {
		return clinicYear;
	}

	public void setClinicYear(BigDecimal clinicYear) {
		this.clinicYear = clinicYear;
	}

	public BigDecimal getLibNum() {
		return libNum;
	}

	public void setLibNum(BigDecimal libNum) {
		this.libNum = libNum;
	}

	public BigDecimal getLibArea() {
		return libArea;
	}

	public void setLibArea(BigDecimal libArea) {
		this.libArea = libArea;
	}

	public BigDecimal getLibMon() {
		return libMon;
	}

	public void setLibMon(BigDecimal libMon) {
		this.libMon = libMon;
	}

	public BigDecimal getLibFinanceMon() {
		return libFinanceMon;
	}

	public void setLibFinanceMon(BigDecimal libFinanceMon) {
		this.libFinanceMon = libFinanceMon;
	}

	public BigDecimal getLibSelfMon() {
		return libSelfMon;
	}

	public void setLibSelfMon(BigDecimal libSelfMon) {
		this.libSelfMon = libSelfMon;
	}

	public BigDecimal getLibEndowMon() {
		return libEndowMon;
	}

	public void setLibEndowMon(BigDecimal libEndowMon) {
		this.libEndowMon = libEndowMon;
	}

	public BigDecimal getLibOtherMon() {
		return libOtherMon;
	}

	public void setLibOtherMon(BigDecimal libOtherMon) {
		this.libOtherMon = libOtherMon;
	}

	public BigDecimal getLibYear() {
		return libYear;
	}

	public void setLibYear(BigDecimal libYear) {
		this.libYear = libYear;
	}

	public BigDecimal getActionNum() {
		return actionNum;
	}

	public void setActionNum(BigDecimal actionNum) {
		this.actionNum = actionNum;
	}

	public BigDecimal getActionArea() {
		return actionArea;
	}

	public void setActionArea(BigDecimal actionArea) {
		this.actionArea = actionArea;
	}

	public BigDecimal getActionMon() {
		return actionMon;
	}

	public void setActionMon(BigDecimal actionMon) {
		this.actionMon = actionMon;
	}

	public BigDecimal getActionFinanceMon() {
		return actionFinanceMon;
	}

	public void setActionFinanceMon(BigDecimal actionFinanceMon) {
		this.actionFinanceMon = actionFinanceMon;
	}

	public BigDecimal getActionSelfMon() {
		return actionSelfMon;
	}

	public void setActionSelfMon(BigDecimal actionSelfMon) {
		this.actionSelfMon = actionSelfMon;
	}

	public BigDecimal getActionEndowMon() {
		return actionEndowMon;
	}

	public void setActionEndowMon(BigDecimal actionEndowMon) {
		this.actionEndowMon = actionEndowMon;
	}

	public BigDecimal getActionOtherMon() {
		return actionOtherMon;
	}

	public void setActionOtherMon(BigDecimal actionOtherMon) {
		this.actionOtherMon = actionOtherMon;
	}

	public BigDecimal getActionYear() {
		return actionYear;
	}

	public void setActionYear(BigDecimal actionYear) {
		this.actionYear = actionYear;
	}

	public BigDecimal getHandNum() {
		return handNum;
	}

	public void setHandNum(BigDecimal handNum) {
		this.handNum = handNum;
	}

	public BigDecimal getHandArea() {
		return handArea;
	}

	public void setHandArea(BigDecimal handArea) {
		this.handArea = handArea;
	}

	public BigDecimal getHandMon() {
		return handMon;
	}

	public void setHandMon(BigDecimal handMon) {
		this.handMon = handMon;
	}

	public BigDecimal getHandFinanceMon() {
		return handFinanceMon;
	}

	public void setHandFinanceMon(BigDecimal handFinanceMon) {
		this.handFinanceMon = handFinanceMon;
	}

	public BigDecimal getHandSelfMon() {
		return handSelfMon;
	}

	public void setHandSelfMon(BigDecimal handSelfMon) {
		this.handSelfMon = handSelfMon;
	}

	public BigDecimal getHandEndowMon() {
		return handEndowMon;
	}

	public void setHandEndowMon(BigDecimal handEndowMon) {
		this.handEndowMon = handEndowMon;
	}

	public BigDecimal getHandOtherMon() {
		return handOtherMon;
	}

	public void setHandOtherMon(BigDecimal handOtherMon) {
		this.handOtherMon = handOtherMon;
	}

	public BigDecimal getHandYear() {
		return handYear;
	}

	public void setHandYear(BigDecimal handYear) {
		this.handYear = handYear;
	}

	public BigDecimal getOutNum() {
		return outNum;
	}

	public void setOutNum(BigDecimal outNum) {
		this.outNum = outNum;
	}

	public BigDecimal getOutArea() {
		return outArea;
	}

	public void setOutArea(BigDecimal outArea) {
		this.outArea = outArea;
	}

	public BigDecimal getOutMon() {
		return outMon;
	}

	public void setOutMon(BigDecimal outMon) {
		this.outMon = outMon;
	}

	public BigDecimal getOutFinanceMon() {
		return outFinanceMon;
	}

	public void setOutFinanceMon(BigDecimal outFinanceMon) {
		this.outFinanceMon = outFinanceMon;
	}

	public BigDecimal getOutSelfMon() {
		return outSelfMon;
	}

	public void setOutSelfMon(BigDecimal outSelfMon) {
		this.outSelfMon = outSelfMon;
	}

	public BigDecimal getOutEnbowMon() {
		return outEnbowMon;
	}

	public void setOutEnbowMon(BigDecimal outEnbowMon) {
		this.outEnbowMon = outEnbowMon;
	}

	public BigDecimal getOutOtherMon() {
		return outOtherMon;
	}

	public void setOutOtherMon(BigDecimal outOtherMon) {
		this.outOtherMon = outOtherMon;
	}

	public String getOutYear() {
		return outYear;
	}

	public void setOutYear(String outYear) {
		this.outYear = outYear;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getOtherNum() {
		return otherNum;
	}

	public void setOtherNum(BigDecimal otherNum) {
		this.otherNum = otherNum;
	}

	public BigDecimal getOtherArea() {
		return otherArea;
	}

	public void setOtherArea(BigDecimal otherArea) {
		this.otherArea = otherArea;
	}

	public BigDecimal getOtherMon() {
		return otherMon;
	}

	public void setOtherMon(BigDecimal otherMon) {
		this.otherMon = otherMon;
	}

	public BigDecimal getOtherFinanceMon() {
		return otherFinanceMon;
	}

	public void setOtherFinanceMon(BigDecimal otherFinanceMon) {
		this.otherFinanceMon = otherFinanceMon;
	}

	public BigDecimal getOtherSelfMon() {
		return otherSelfMon;
	}

	public void setOtherSelfMon(BigDecimal otherSelfMon) {
		this.otherSelfMon = otherSelfMon;
	}

	public BigDecimal getOtherEndowMon() {
		return otherEndowMon;
	}

	public void setOtherEndowMon(BigDecimal otherEndowMon) {
		this.otherEndowMon = otherEndowMon;
	}

	public BigDecimal getOtherOtherMon() {
		return otherOtherMon;
	}

	public void setOtherOtherMon(BigDecimal otherOtherMon) {
		this.otherOtherMon = otherOtherMon;
	}


}