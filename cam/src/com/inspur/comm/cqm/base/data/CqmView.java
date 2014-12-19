package com.inspur.comm.cqm.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义统计报表视图表databean
 * @author shgtch
 * @date 2012-03-16
 */
@Table(tableName = "CQM_VIEW", keyFields = "viewId")
public class CqmView extends StatefulDatabean {

	// 视图属性
	@Transient
	List<CqmCol> cqmColList = new ArrayList<CqmCol>();
	
	// 视图内码
	private String viewId;

	// 视图名称
	private String viewName;

	// 视图逻辑
	private String viewLogic;

	/**
	 * 获取 视图属性
	 * @return
	 */
	public List<CqmCol> getCqmColList() {
		return cqmColList;
	}

	/**
	 * 设置 视图属性
	 * @param cqmColList
	 */
	public void setCqmColList(List<CqmCol> cqmColList) {
		this.cqmColList = cqmColList;
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

}