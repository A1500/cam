package com.inspur.cams.marry.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:等级评定标准
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
@Table(tableName = "MRM_ORGAN_STANDARD_COMPARE", keyFields = "COMPARE_ID")
public class MrmOrganStandardCompare extends StatefulDatabean {
	// 内码
	private String compareId;
	// 业务编号
	private String applyId;
	// 章节号
	private String chapter;
	// 要求
	private String require;
	// 实际完成情况
	private String actural;
	// 序号
	private String seq;
	public String getCompareId() {
		return compareId;
	}
	public void setCompareId(String compareId) {
		this.compareId = compareId;
	}
	public String getApplyId() {
		return applyId;
	}
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}
	public String getChapter() {
		return chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public String getRequire() {
		return require;
	}
	public void setRequire(String require) {
		this.require = require;
	}
	public String getActural() {
		return actural;
	}
	public void setActural(String actural) {
		this.actural = actural;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}

	

}