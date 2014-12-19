package com.inspur.cams.marry.base.data; 

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:MrmResourcesInfo
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
*/
 @Table(tableName = "MRM_RESOURCES_INFO" , keyFields = "resourceId")
public class MrmResourcesInfo extends StatefulDatabean {	
   //资源ID
	@Column(name = "RESOURCE_ID")
   private String resourceId;   
   //登记机关ID
   	@Rule(value="require")   
	@Column(name = "DEPT_ID")
   private String deptId;   
   	
  //区域ID
	@Column(name = "FUNCTION_ID")
   private String functionId;   
   	
  //登记机关名称
   	@Rule(value="require")   
	@Column(name = "DEPT_NAME")
   private String deptName;   
   //资源名称
   	@Rule(value="require")   
	@Column(name = "RESOURCE_NAME")
   private String resourceName;   
   //数量
   	@Rule(value="require|number")   
	@Column(name = "RESOURCE_NUM")
   private BigDecimal resourceNum ;
   	
	public String getResourceId() {
		return resourceId;
	}
	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}
	
	public String getResourceName() {
		return resourceName;
	}
	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	public BigDecimal getResourceNum() {
		return resourceNum;
	}
	public void setResourceNum(BigDecimal resourceNum) {
		this.resourceNum = resourceNum;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getFunctionId() {
		return functionId;
	}
	public void setFunctionId(String functionId) {
		this.functionId = functionId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
 }
  