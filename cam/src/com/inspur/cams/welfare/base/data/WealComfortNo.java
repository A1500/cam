package com.inspur.cams.welfare.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * WealComfortNo
 * @description:最大
 * @author zhanghui
 * 
 */
@Table(tableName = "WEAL_COMFORT_NO", keyFields = {"domicileCode","corporationType"})
public class WealComfortNo extends StatefulDatabean {

	// 区划代码
	@Rule(value = "require")
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;

	
	@Column(name = "QUALIFICATION_NO")
	private String qualificationNo;
	
	// 企业类型
	@Rule(value = "require")
	@Column(name = "CORPORATION_TYPE")
	private String corporationType;
	
	public String getCorporationType() {
		return corporationType;
	}

	public void setCorporationType(String corporationType) {
		this.corporationType = corporationType;
	}

	public String getDomicileCode() {
		return domicileCode;
	}

	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	public String getQualificationNo() {
		return qualificationNo;
	}

	public void setQualificationNo(String qualificationNo) {
		this.qualificationNo = qualificationNo;
	}


}