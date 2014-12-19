package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息社区单位组织信息表databean
 * @author 
 * @date 2012-05-31
 */
@Table(tableName = "CDC_ORGAN_INFO", keyFields = "organId")
public class CdcOrganInfo extends StatefulDatabean {

	// 单位组织内码
	private String organId;

	// 组织机构代码
	private String organizationCode;

	// 单位组织名称
	private String corpName;

	// 单位组织类型
	private String organType;

	// 成员/职工数量
	private BigDecimal memberNum;

	// 进驻时间
	private String enterDate;

	// 负责人姓名
	private String legalPeople;

	// 主管部门
	private String morgName;

	// 单位组织性质
	private String organKind;

	// 地址
	private String organAdds;
	
	private String postCode;

	// 电话
	private String organPhone;

	// 办公场所数量
	private BigDecimal officialNum;

	// 占地面积
	private BigDecimal floorArea;

	// 所属区、街道、社区
	private String organCode;

	// 所属区、街道、社区名称
	private String organName;
	
	//业务范围
	private String businessScope;

	public String getBusinessScope() {
		return businessScope;
	}

	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
	}

	/**
	 * 获取 单位组织内码
	 * @return String
	 */
	public String getOrganId() {
		return organId;
	}

	/**
	 * 设置 单位组织内码
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * 获取 组织机构代码
	 * @return String
	 */
	public String getOrganizationCode() {
		return organizationCode;
	}

	/**
	 * 设置 组织机构代码
	 */
	public void setOrganizationCode(String organizationCode) {
		this.organizationCode = organizationCode;
	}

	/**
	 * 获取 单位组织名称
	 * @return String
	 */
	public String getCorpName() {
		return corpName;
	}

	/**
	 * 设置 单位组织名称
	 */
	public void setCorpName(String corpName) {
		this.corpName = corpName;
	}

	/**
	 * 获取 单位组织类型
	 * @return String
	 */
	public String getOrganType() {
		return organType;
	}

	/**
	 * 设置 单位组织类型
	 */
	public void setOrganType(String organType) {
		this.organType = organType;
	}

	/**
	 * 获取 成员/职工数量
	 * @return BigDecimal
	 */
	public BigDecimal getMemberNum() {
		return memberNum;
	}

	/**
	 * 设置 成员/职工数量
	 */
	public void setMemberNum(BigDecimal memberNum) {
		this.memberNum = memberNum;
	}

	/**
	 * 获取 进驻时间
	 * @return String
	 */
	public String getEnterDate() {
		return enterDate;
	}

	/**
	 * 设置 进驻时间
	 */
	public void setEnterDate(String enterDate) {
		this.enterDate = enterDate;
	}

	/**
	 * 获取 负责人姓名
	 * @return String
	 */
	public String getLegalPeople() {
		return legalPeople;
	}

	/**
	 * 设置 负责人姓名
	 */
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	/**
	 * 获取 主管部门
	 * @return String
	 */
	public String getMorgName() {
		return morgName;
	}

	/**
	 * 设置 主管部门
	 */
	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	/**
	 * 获取 单位组织性质
	 * @return String
	 */
	public String getOrganKind() {
		return organKind;
	}

	/**
	 * 设置 单位组织性质
	 */
	public void setOrganKind(String organKind) {
		this.organKind = organKind;
	}

	/**
	 * 获取 地址
	 * @return String
	 */
	public String getOrganAdds() {
		return organAdds;
	}

	/**
	 * 设置 地址
	 */
	public void setOrganAdds(String organAdds) {
		this.organAdds = organAdds;
	}

	/**
	 * 获取 电话
	 * @return String
	 */
	public String getOrganPhone() {
		return organPhone;
	}

	/**
	 * 设置 电话
	 */
	public void setOrganPhone(String organPhone) {
		this.organPhone = organPhone;
	}

	/**
	 * 获取 办公场所数量
	 * @return BigDecimal
	 */
	public BigDecimal getOfficialNum() {
		return officialNum;
	}

	/**
	 * 设置 办公场所数量
	 */
	public void setOfficialNum(BigDecimal officialNum) {
		this.officialNum = officialNum;
	}

	/**
	 * 获取 占地面积
	 * @return BigDecimal
	 */
	public BigDecimal getFloorArea() {
		return floorArea;
	}

	/**
	 * 设置 占地面积
	 */
	public void setFloorArea(BigDecimal floorArea) {
		this.floorArea = floorArea;
	}

	/**
	 * 获取 所属区、街道、社区
	 * @return BigDecimal
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 所属区、街道、社区
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 所属区、街道、社区名称
	 * @return BigDecimal
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 所属区、街道、社区名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 邮编
	 * @return BigDecimal
	 */
	public String getPostCode() {
		return postCode;
	}
	
	/**
	 * 设置 邮编
	 */
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

}