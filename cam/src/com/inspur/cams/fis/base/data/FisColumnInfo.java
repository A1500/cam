package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 页面列描述databean
 * @author 
 * @date 2012-07-16
 */
@Table(tableName = "FIS_COLUMN_INFO", keyFields = "columnId")
public class FisColumnInfo extends StatefulDatabean {

	// 列编号
	private String columnId;

	// 页面编号
	private String pageId;

	// 列名称
	private String columnName;

	// 列sql
	private String sqls;

	// 参数
	private String para;

	// 顺序
	private int seq;

	// 是否可用
	private String inUse;

	/**
	 * 获取 列编号
	 * @return String
	 */
	public String getColumnId() {
		return columnId;
	}

	/**
	 * 设置 列编号
	 */
	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

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
	 * 获取 列名称
	 * @return String
	 */
	public String getColumnName() {
		return columnName;
	}

	/**
	 * 设置 列名称
	 */
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	/**
	 * 获取 列sql
	 * @return String
	 */
	public String getSqls() {
		return sqls;
	}

	/**
	 * 设置 列sql
	 */
	public void setSqls(String sqls) {
		this.sqls = sqls;
	}

	/**
	 * 获取 参数
	 * @return String
	 */
	public String getPara() {
		return para;
	}

	/**
	 * 设置 参数
	 */
	public void setPara(String para) {
		this.para = para;
	}

	/**
	 * 获取 顺序
	 * @return int
	 */
	public int getSeq() {
		return seq;
	}

	/**
	 * 设置 顺序
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}

	/**
	 * 获取 是否可用
	 * @return String
	 */
	public String getInUse() {
		return inUse;
	}

	/**
	 * 设置 是否可用
	 */
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}

}