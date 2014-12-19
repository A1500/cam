package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义统计报表模型视图关系databean
 * @author shgtch
 * @date 2012-03-16
 */
@Table(tableName = "CQM_VIEW_REL", keyFields = "relId")
public class CqmViewRel extends StatefulDatabean {

	// 模型视图关系内码
	private String relId;
	
	// 模型内码
	private String moduleId;

	// 视图内码
	private String viewId;

	/**
	 * 获取 模型视图关系内码
	 * @return String
	 */
	public String getRelId() {
		return relId;
	}

	/**
	 * 设置 模型视图关系内码
	 */
	public void setRelId(String relId) {
		this.relId = relId;
	}

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
	 * 获取 视图内码
	 * @return String
	 */
	public String getViewId() {
		return viewId;
	}

	/**
	 * 设置 视图内码
	 */
	public void setViewId(String viewId) {
		this.viewId = viewId;
	}

}