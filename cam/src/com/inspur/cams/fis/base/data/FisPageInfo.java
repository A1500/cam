package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 页面信息表databean
 * @author 
 * @date 2012-07-16
 */
@Table(tableName = "FIS_PAGE_INFO", keyFields = "pageId")
public class FisPageInfo extends StatefulDatabean {

	// 页面编号
	private String pageId;

	// 页面名称
	private String pageName;

	/**
	 * 获取 页面编号
	 * @return String
	 */
	public String getPageId() {
		return pageId;
	}

	/**
	 * 设置 页面编号
	 */
	public void setPageId(String pageId) {
		this.pageId = pageId;
	}

	/**
	 * 获取 页面名称
	 * @return String
	 */
	public String getPageName() {
		return pageName;
	}

	/**
	 * 设置 页面名称
	 */
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

}