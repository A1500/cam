package com.inspur.cams.jcm.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 
 * @author 陈寿业  
 *@date 2014-12-15
 */
@Table(tableName = "JCM_COMPANY_PROFILE", keyFields = "companyId")
public class JcmAllUnitQuery extends StatefulDatabean{
    //主键
	private String companyId;
	// 组织机构代码
	private String companyCode;
	 //单位名称
	private String companyName;
	 //单位性质
	private String companyNature;
	 //法人
	private String companyPeopleName;
	 //批准文号
	private String companyNo;
	 //住所
	private String companyAdress;
	//邮编
	private String companyPostCode;
	//从业人数
	private Integer companyJobNum;
	//编制人数
	private Integer companyEstNum;
	//联系电话
	private String companyPhone;
	//主管部门名称
	private String companyBorgName;
	//单位所属业务类别
	private String companyType;
	//固定总资产
	private Integer companyMon;
	//状态
	private String companyStatus;
	//建筑面积
	private Integer grossArea;
	//办公地址
	private String officeAdress;
	//房间间数
	private Integer roomNum;
	//负责人姓名
	private String principalName;
	//负责人职务
	private String principalDuty;
	//负责人移动电话
	private String principalMobile;
	//负责人办公电话
	private String principalPhone;
	//所属行政规划
	private String organName;
	//所属行政规划代码
	private String organCode;
	
	
	
	/**
	 * 获取 主键
	 * @return String
	 */
	public String getCompanyId() {
		return companyId;
	}
	/**
	 * 设置 主键
	 */
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	/**
	 * 获取 组织机构代码
	 * @return String
	 */
	public String getCompanyCode() {
		return companyCode;
	}
	/**
	 * 设置 组织机构代码
	 */
	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	/**
	 * 获取 单位名称
	 * @return String
	 */
	
	public String getCompanyName() {
		return companyName;
	}
	/**
	 * 设置 单位名称
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	/**
	 * 获取 单位性质
	 * @return String
	 */
	public String getCompanyNature() {
		return companyNature;
	}
	/**
	 * 设置 单位性质
	 */
	public void setCompanyNature(String companyNature) {
		this.companyNature = companyNature;
	}
	/**
	 * 获取 法人
	 * @return String
	 */
	public String getCompanyPeopleName() {
		return companyPeopleName;
	}
	/**
	 * 设置 法人
	 */
	public void setCompanyPeopleName(String companyPeopleName) {
		this.companyPeopleName = companyPeopleName;
	}
	/**
	 * 获取 批准文号
	 * @return String
	 */
	public String getCompanyNo() {
		return companyNo;
	}
	/**
	 *设置 批准文号
	 */
	public void setCompanyNo(String companyNo) {
		this.companyNo = companyNo;
	}
	/**
	 * 获取 住所
	 * @return String
	 */
	public String getCompanyAdress() {
		return companyAdress;
	}
	/**
	 * 设置 住所
	 */
	public void setCompanyAdress(String companyAdress) {
		this.companyAdress = companyAdress;
	}
	/**
	 * 获取 邮编
	 * @return String
	 */
	public String getCompanyPostCode() {
		return companyPostCode;
	}
	/**
	 *设置 邮编
	 */
	public void setCompanyPostCode(String companyPostCode) {
		this.companyPostCode = companyPostCode;
	}
	/**
	 * 获取 从业人数
	 * @return Integer
	 */
	public Integer getCompanyJobNum() {
		return companyJobNum;
	}
	/**
	 * 设置从业人数 
	 */
	public void setCompanyJobNum(Integer companyJobNum) {
		this.companyJobNum = companyJobNum;
	}
	/**
	 * 获取 编制人数
	 * @return Integer
	 */
	public Integer getCompanyEstNum() {
		return companyEstNum;
	}
	/**
	 * 设置 编制人数
	 */
	public void setCompanyEstNum(Integer companyEstNum) {
		this.companyEstNum = companyEstNum;
	}
	/**
	 * 获取 联系电话
	 * @return String
	 */
	public String getCompanyPhone() {
		return companyPhone;
	}
	/**
	 * 设置 联系电话
	 */
	public void setCompanyPhone(String companyPhone) {
		this.companyPhone = companyPhone;
	}
	/**
	 * 获取 主管部门名称
	 * @return String
	 */
	public String getCompanyBorgName() {
		return companyBorgName;
	}
	/**
	 * 设置 主管部门名称
	 */
	public void setCompanyBorgName(String companyBorgName) {
		this.companyBorgName = companyBorgName;
	}
	/**
	 * 获取 单位所属业务类别
	 * @return String
	 */
	public String getCompanyType() {
		return companyType;
	}
	/**
	 * 设置 单位所属业务类别
	 */
	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}
	/**
	 * 获取 固定总资产
	 * @return Integer
	 */
	public Integer getCompanyMon() {
		return companyMon;
	}
	/**
	 * 设置 固定总资产
	 */
	public void setCompanyMon(Integer companyMon) {
		this.companyMon = companyMon;
	}
	/**
	 * 获取 状态
	 * @return String
	 */
	public String getCompanyStatus() {
		return companyStatus;
	}
	/**
	 * 设置 状态
	 */
	public void setCompanyStatus(String companyStatus) {
		this.companyStatus = companyStatus;
	}
	/**
	 * 获取 建筑面积
	 * @return Integer
	 */
	public Integer getGrossArea() {
		return grossArea;
	}
	/**
	 * 设置 建筑面积
	 */
	public void setGrossArea(Integer grossArea) {
		this.grossArea = grossArea;
	}
	/**
	 * 获取 办公地址
	 * @return String
	 */
	public String getOfficeAdress() {
		return officeAdress;
	}
	/**
	 * 设置 办公地址
	 */
	public void setOfficeAdress(String officeAdress) {
		this.officeAdress = officeAdress;
	}
	/**
	 * 获取 房间间数
	 * @return Integer
	 */
	public Integer getRoomNum() {
		return roomNum;
	}
	/**
	 * 设置 房间间数
	 */
	public void setRoomNum(Integer roomNum) {
		this.roomNum = roomNum;
	}
	/**
	 * 获取 负责人姓名
	 * @return String
	 */
	public String getPrincipalName() {
		return principalName;
	}
	/**
	 * 设置 负责人姓名
	 */
	public void setPrincipalName(String principalName) {
		this.principalName = principalName;
	}
	/**
	 * 获取 负责人职务
	 * @return String
	 */
	public String getPrincipalDuty() {
		return principalDuty;
	}
	/**
	 * 设置 负责人职务
	 */
	public void setPrincipalDuty(String principalDuty) {
		this.principalDuty = principalDuty;
	}
	/**
	 * 获取 负责人移动电话
	 * @return String
	 */
	public String getPrincipalMobile() {
		return principalMobile;
	}
	/**
	 * 设置 负责人移动电话
	 */
	public void setPrincipalMobile(String principalMobile) {
		this.principalMobile = principalMobile;
	}
	/**
	 * 获取 负责人电话
	 * @return String
	 */
	public String getPrincipalPhone() {
		return principalPhone;
	}
	/**
	 *设置 负责人电话
	 */
	public void setPrincipalPhone(String principalPhone) {
		this.principalPhone = principalPhone;
	}
	/**
	 * 获取 所属行政规划
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}
	/**
	 * 设置 所属行政规划
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	/**
	 * 获取 所属行政规划代码
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}
	/**
	 * 设置 所属行政规划代码
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}
	
	
	
	
	
	
}
