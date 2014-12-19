package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主与社区建设通讯录databean
 * @author shgtch
 * @date 2012-3-1
 */
@Table(tableName = "CDC_MAIL_LIST", keyFields = "listId")
public class CdcMailList extends StatefulDatabean {

	// 通讯录内码
	private String listId;

	// 姓名
	private String name;

	// 性别
	private String sex;

	// 单位
	private String organ;

	// 部门
	private String dept;

	// 职务
	private String duty;

	// 分工
	private String workContent;

	// 手机
	private String moblePhone;

	// 办公电话
	private String phone;

	// 传真
	private String fax;

	// 电子邮箱
	private String email;

	// 邮政编码
	private String postCode;

	// 通讯地址
	private String postAdds;

	// 创建单位行政区划
	private String organCode;

	// 创建单位名称
	private String organName;

	// 创建日期
	private String createTime;

	/**
	 * 获取 通讯录内码
	 * @return
	 */
	public String getListId() {
		return listId;
	}

	/**
	 * 设置 通讯录内码
	 * @param listId
	 */
	public void setListId(String listId) {
		this.listId = listId;
	}

	/**
	 * 获取 姓名
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 姓名
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 性别
	 * @return
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * 设置 性别
	 * @param sex
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * 获取 单位
	 * @return
	 */
	public String getOrgan() {
		return organ;
	}

	/**
	 * 设置 单位
	 * @param organ
	 */
	public void setOrgan(String organ) {
		this.organ = organ;
	}

	/**
	 * 获取 部门
	 * @return
	 */
	public String getDept() {
		return dept;
	}

	/**
	 * 设置 部门
	 * @param dept
	 */
	public void setDept(String dept) {
		this.dept = dept;
	}

	/**
	 * 获取 职务
	 * @return
	 */
	public String getDuty() {
		return duty;
	}

	/**
	 * 设置 职务
	 * @param duty
	 */
	public void setDuty(String duty) {
		this.duty = duty;
	}

	/**
	 * 获取 工作内容
	 * @return
	 */
	public String getWorkContent() {
		return workContent;
	}

	/**
	 * 设置 工作内容
	 * @param workContent
	 */
	public void setWorkContent(String workContent) {
		this.workContent = workContent;
	}

	/**
	 * 获取 手机
	 * @return
	 */
	public String getMoblePhone() {
		return moblePhone;
	}

	/**
	 * 设置 手机
	 * @param moblePhone
	 */
	public void setMoblePhone(String moblePhone) {
		this.moblePhone = moblePhone;
	}

	/**
	 * 获取 办公电话
	 * @return
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置 办公电话
	 * @param phone
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取 传真
	 * @return
	 */
	public String getFax() {
		return fax;
	}

	/**
	 * 设置 传真
	 * @param fax
	 */
	public void setFax(String fax) {
		this.fax = fax;
	}

	/**
	 * 获取 电子邮箱
	 * @return
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * 设置 电子邮箱
	 * @param email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 获取 邮政编码
	 * @return
	 */
	public String getPostCode() {
		return postCode;
	}

	/**
	 * 设置 邮政编码
	 * @param postCode
	 */
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	/**
	 * 获取 通讯地址
	 * @return
	 */
	public String getPostAdds() {
		return postAdds;
	}

	/**
	 * 设置 通讯地址
	 * @param postAdds
	 */
	public void setPostAdds(String postAdds) {
		this.postAdds = postAdds;
	}

	/**
	 * 获取 创建单位行政区划
	 * @return
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 创建单位行政区划
	 * @param organCode
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 创建单位名称
	 * @return
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 创建单位名称
	 * @param organName
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 创建时间
	 * @return
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建时间
	 * @param createTime
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}