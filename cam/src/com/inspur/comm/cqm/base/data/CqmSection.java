package com.inspur.comm.cqm.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 自定义统计报表区间类型指标databean
 * @author douyn
 * @date 2012-07-20
 */
@Table(tableName = "DIC_SECTION", keyFields = "sectionId")
public class CqmSection extends StatefulDatabean {

	// 指标内码
	private String sectionId;

	// 指标名称
	private String sectionType;

	// 指标代码字段
	private String sectionBefore;

	// 指标名称字段
	private String sectionAfter;

	// 指标逻辑
	private String sectionIndex;
	
	// 作为行是否一次性加载
	private String sectionName;

	public String getSectionId() {
		return sectionId;
	}

	public void setSectionId(String sectionId) {
		this.sectionId = sectionId;
	}

	public String getSectionType() {
		return sectionType;
	}

	public void setSectionType(String sectionType) {
		this.sectionType = sectionType;
	}

	public String getSectionBefore() {
		return sectionBefore;
	}

	public void setSectionBefore(String sectionBefore) {
		this.sectionBefore = sectionBefore;
	}

	public String getSectionAfter() {
		return sectionAfter;
	}

	public void setSectionAfter(String sectionAfter) {
		this.sectionAfter = sectionAfter;
	}

	public String getSectionIndex() {
		return sectionIndex;
	}

	public void setSectionIndex(String sectionIndex) {
		this.sectionIndex = sectionIndex;
	}

	public String getSectionName() {
		return sectionName;
	}

	public void setSectionName(String sectionName) {
		this.sectionName = sectionName;
	}

}