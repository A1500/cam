package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义统计报表模型表databean
 * @author shgtch
 * @date 2012-03-16
 */
@Table(tableName = "CQM_MODULE", keyFields = "moduleId")
public class CqmModule extends StatefulDatabean {

	// 模型内码
	private String moduleId;

	// 模型名称
	private String moduleName;
	
	//角色
	private String moduleRole;

	/**
	 * 获取 模型内码
	 * @return String
	 */
	public String getModuleId() {
		return moduleId;
	}

	/**
	 * 设置 模型内码
	 */
	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	/**
	 * 获取 模型名称
	 * @return String
	 */
	public String getModuleName() {
		return moduleName;
	}

	/**
	 * 设置 模型名称
	 */
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getModuleRole() {
		return moduleRole;
	}

	public void setModuleRole(String moduleRole) {
		this.moduleRole = moduleRole;
	}

}