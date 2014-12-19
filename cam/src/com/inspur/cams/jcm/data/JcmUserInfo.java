package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 用户表databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_USER_INFO", keyFields = "userInfoId")
public class JcmUserInfo extends StatefulDatabean {

	// 用户表主键
	private String userInfoId;

	// 单位主键
	private String companyId;

	// 用户名ID
	private String userId;

	/**
	 * 获取 用户表主键
	 * @return String
	 */
	public String getUserInfoId() {
		return userInfoId;
	}

	/**
	 * 设置 用户表主键
	 */
	public void setUserInfoId(String userInfoId) {
		this.userInfoId = userInfoId;
	}

	/**
	 * 获取 单位主键
	 * @return String
	 */
	public String getCompanyId() {
		return companyId;
	}

	/**
	 * 设置 单位主键
	 */
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	/**
	 * 获取 用户名ID
	 * @return String
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * 设置 用户名ID
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

}