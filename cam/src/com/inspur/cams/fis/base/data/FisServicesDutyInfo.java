package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 殡葬服务机构人员岗位信息表databean
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
@Table(tableName = "FIS_SERVICES_DUTY_INFO", keyFields = "dutyId")
public class FisServicesDutyInfo extends StatefulDatabean {

	// 人员岗位内码
	private String dutyId;

	// 人员编号
	private String peopleId;

	// 工种
	private String workType;

	// 上岗证书编号
	private String certNo;

	// 专业技术等级
	private String professionLevel;

	// 备注
	private String note;

	// 登记单位
	private String createOrgan;

	// 登记单位名称
	private String createOrganName;

	// 登记人
	private String createPeople;

	// 登记人姓名
	private String createPeopleName;

	// 登记时间
	private String createTime;

	/**
	 * 获取 人员岗位内码
	 * @return String
	 */
	public String getDutyId() {
		return dutyId;
	}

	/**
	 * 设置 人员岗位内码
	 */
	public void setDutyId(String dutyId) {
		this.dutyId = dutyId;
	}

	/**
	 * 获取 人员编号
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员编号
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 工种
	 * @return String
	 */
	public String getWorkType() {
		return workType;
	}

	/**
	 * 设置 工种
	 */
	public void setWorkType(String workType) {
		this.workType = workType;
	}

	/**
	 * 获取 上岗证书编号
	 * @return String
	 */
	public String getCertNo() {
		return certNo;
	}

	/**
	 * 设置 上岗证书编号
	 */
	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}

	/**
	 * 获取 专业技术等级
	 * @return String
	 */
	public String getProfessionLevel() {
		return professionLevel;
	}

	/**
	 * 设置 专业技术等级
	 */
	public void setProfessionLevel(String professionLevel) {
		this.professionLevel = professionLevel;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取 登记单位
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 登记单位
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 登记单位名称
	 * @return String
	 */
	public String getCreateOrganName() {
		return createOrganName;
	}

	/**
	 * 设置 登记单位名称
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * 获取 登记人
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置 登记人
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取 登记人姓名
	 * @return String
	 */
	public String getCreatePeopleName() {
		return createPeopleName;
	}

	/**
	 * 设置 登记人姓名
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * 获取 登记时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 登记时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}