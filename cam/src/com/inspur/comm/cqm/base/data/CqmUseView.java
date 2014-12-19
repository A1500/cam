package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义报表使用视图databean
 * @author shgtch
 * @date 2012-03-22
 */
@Table(tableName = "CQM_USE_VIEW", keyFields = "useViewId")
public class CqmUseView extends StatefulDatabean {

	// 使用视图内码
	private String useViewId;

	// 报表内码
	private String reportId;

	// 视图内码
	private String viewId;

	// 视图名称
	private String viewName;

	// 视图逻辑
	private String viewLogic;

	// 视图对应字段名称
	private String viewCode;
	
	// 视图权限字段
	private String privilegeCode;
	
	// 是否显示下级
	private String ifUndering;

	/**
	 * 获取 使用视图内码
	 * @return String
	 */
	public String getUseViewId() {
		return useViewId;
	}

	/**
	 * 设置 使用视图内码
	 */
	public void setUseViewId(String useViewId) {
		this.useViewId = useViewId;
	}

	/**
	 * 获取 报表内码
	 * @return String
	 */
	public String getReportId() {
		return reportId;
	}

	/**
	 * 设置 报表内码
	 */
	public void setReportId(String reportId) {
		this.reportId = reportId;
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

	/**
	 * 获取 视图名称
	 * @return String
	 */
	public String getViewName() {
		return viewName;
	}

	/**
	 * 设置 视图名称
	 */
	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	/**
	 * 获取 视图逻辑
	 * @return String
	 */
	public String getViewLogic() {
		return viewLogic;
	}

	/**
	 * 设置 视图逻辑
	 */
	public void setViewLogic(String viewLogic) {
		this.viewLogic = viewLogic;
	}

	/**
	 * 获取 视图对应字段名称
	 * @return String
	 */
	public String getViewCode() {
		return viewCode;
	}

	/**
	 * 设置 视图对应字段名称
	 */
	public void setViewCode(String viewCode) {
		this.viewCode = viewCode;
	}

	public String getPrivilegeCode() {
		return privilegeCode;
	}

	public void setPrivilegeCode(String privilegeCode) {
		this.privilegeCode = privilegeCode;
	}

	public String getIfUndering() {
		return ifUndering;
	}

	public void setIfUndering(String ifUndering) {
		this.ifUndering = ifUndering;
	}

}