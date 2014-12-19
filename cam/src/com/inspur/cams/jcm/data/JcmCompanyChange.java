package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 单位信息调整（多条记录过程）databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_COMPANY_CHANGE", keyFields = "companyChangeId")
public class JcmCompanyChange extends StatefulDatabean {

	// 变更ID
	private String companyChangeId;

	// 单位主键
	private String companyId;

	// 时间
	private String companyChangeTime;

	// 内容
	private String companyChangeContext;

	// 文号
	private String companyChangeNum;

	/**
	 * 获取 变更ID
	 * @return String
	 */
	public String getCompanyChangeId() {
		return companyChangeId;
	}

	/**
	 * 设置 变更ID
	 */
	public void setCompanyChangeId(String companyChangeId) {
		this.companyChangeId = companyChangeId;
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
	 * 获取 时间
	 * @return String
	 */
	public String getCompanyChangeTime() {
		return companyChangeTime;
	}

	/**
	 * 设置 时间
	 */
	public void setCompanyChangeTime(String companyChangeTime) {
		this.companyChangeTime = companyChangeTime;
	}

	/**
	 * 获取 内容
	 * @return String
	 */
	public String getCompanyChangeContext() {
		return companyChangeContext;
	}

	/**
	 * 设置 内容
	 */
	public void setCompanyChangeContext(String companyChangeContext) {
		this.companyChangeContext = companyChangeContext;
	}

	/**
	 * 获取 文号
	 * @return String
	 */
	public String getCompanyChangeNum() {
		return companyChangeNum;
	}

	/**
	 * 设置 文号
	 */
	public void setCompanyChangeNum(String companyChangeNum) {
		this.companyChangeNum = companyChangeNum;
	}

}