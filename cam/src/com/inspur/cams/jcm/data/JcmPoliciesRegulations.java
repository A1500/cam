package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 政策法规表databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_POLICIES_REGULATIONS", keyFields = "prId")
public class JcmPoliciesRegulations extends StatefulDatabean {

	// 主键
	private String prId;

	// 单位主键
	private String companyId;

	// 文号
	private String referenceNum;

	// 标题
	private String prTitle;

	// 类别
	private String prType;

	// 内容
	private String prContent;

	// 备注
	private String prNote;

	// 政策法律生效日期
	private String prDate;

	// 创建时间
	private String prCreateTime;

	/**
	 * 获取 主键
	 * @return String
	 */
	public String getPrId() {
		return prId;
	}

	/**
	 * 设置 主键
	 */
	public void setPrId(String prId) {
		this.prId = prId;
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
	 * 获取 文号
	 * @return String
	 */
	public String getReferenceNum() {
		return referenceNum;
	}

	/**
	 * 设置 文号
	 */
	public void setReferenceNum(String referenceNum) {
		this.referenceNum = referenceNum;
	}

	/**
	 * 获取 标题
	 * @return String
	 */
	public String getPrTitle() {
		return prTitle;
	}

	/**
	 * 设置 标题
	 */
	public void setPrTitle(String prTitle) {
		this.prTitle = prTitle;
	}

	/**
	 * 获取 类别
	 * @return String
	 */
	public String getPrType() {
		return prType;
	}

	/**
	 * 设置 类别
	 */
	public void setPrType(String prType) {
		this.prType = prType;
	}

	/**
	 * 获取 内容
	 * @return String
	 */
	public String getPrContent() {
		return prContent;
	}

	/**
	 * 设置 内容
	 */
	public void setPrContent(String prContent) {
		this.prContent = prContent;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getPrNote() {
		return prNote;
	}

	/**
	 * 设置 备注
	 */
	public void setPrNote(String prNote) {
		this.prNote = prNote;
	}

	/**
	 * 获取 政策法律生效日期
	 * @return String
	 */
	public String getPrDate() {
		return prDate;
	}

	/**
	 * 设置 政策法律生效日期
	 */
	public void setPrDate(String prDate) {
		this.prDate = prDate;
	}

	/**
	 * 获取 创建时间
	 * @return String
	 */
	public String getPrCreateTime() {
		return prCreateTime;
	}

	/**
	 * 设置 创建时间
	 */
	public void setPrCreateTime(String prCreateTime) {
		this.prCreateTime = prCreateTime;
	}

}