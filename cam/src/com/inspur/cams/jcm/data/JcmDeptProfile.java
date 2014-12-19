package com.inspur.cams.jcm.data;

import java.io.Serializable;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
@Table(tableName = "JCM_DEPT_PROFILE", keyFields = "id")
public class JcmDeptProfile extends StatefulDatabean implements Serializable{
	private static final long serialVersionUID = -7767724181191483733L;
	/*主键**/
	private String id;
	/*部门名称**/
	private String deptName;
	/*单位id**/
	private String companyId;
	/*部门级别**/
	private String level;
	/*编制人数**/
	private String authorizedCount;
	/*从业人数**/
	private Integer officerCount;
	/*业务范围**/
	private String businessSize;
	/*序号**/
	private String orderNumber;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getAuthorizedCount() {
		return authorizedCount;
	}
	public void setAuthorizedCount(String authorizedCount) {
		this.authorizedCount = authorizedCount;
	}
	public Integer getOfficerCount() {
		return officerCount;
	}
	public void setOfficerCount(Integer officerCount) {
		this.officerCount = officerCount;
	}
	public String getBusinessSize() {
		return businessSize;
	}
	public void setBusinessSize(String businessSize) {
		this.businessSize = businessSize;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	
	

}
