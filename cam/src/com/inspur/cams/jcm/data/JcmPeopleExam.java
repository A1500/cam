package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 人员培训信息（多条记录过程）databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_PEOPLE_EXAM", keyFields = "peopleExamId")
public class JcmPeopleExam extends StatefulDatabean {

	// 培训主键
	private String peopleExamId;

	// 人员主键
	private String peopleId;

	// 培训年度
	private String examYear;

	// 培训内容
	private String examContent;

	// 培训时间
	private String examTime;

	// 培训地点
	private String examPlace;

	// 是否考试
	private String isExam;

	// 考试结果
	private String examRuslut;

	/**
	 * 获取 培训主键
	 * @return String
	 */
	public String getPeopleExamId() {
		return peopleExamId;
	}

	/**
	 * 设置 培训主键
	 */
	public void setPeopleExamId(String peopleExamId) {
		this.peopleExamId = peopleExamId;
	}

	/**
	 * 获取 人员主键
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员主键
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 培训年度
	 * @return String
	 */
	public String getExamYear() {
		return examYear;
	}

	/**
	 * 设置 培训年度
	 */
	public void setExamYear(String examYear) {
		this.examYear = examYear;
	}

	/**
	 * 获取 培训内容
	 * @return String
	 */
	public String getExamContent() {
		return examContent;
	}

	/**
	 * 设置 培训内容
	 */
	public void setExamContent(String examContent) {
		this.examContent = examContent;
	}

	/**
	 * 获取 培训时间
	 * @return String
	 */
	public String getExamTime() {
		return examTime;
	}

	/**
	 * 设置 培训时间
	 */
	public void setExamTime(String examTime) {
		this.examTime = examTime;
	}

	/**
	 * 获取 培训地点
	 * @return String
	 */
	public String getExamPlace() {
		return examPlace;
	}

	/**
	 * 设置 培训地点
	 */
	public void setExamPlace(String examPlace) {
		this.examPlace = examPlace;
	}

	/**
	 * 获取 是否考试
	 * @return String
	 */
	public String getIsExam() {
		return isExam;
	}

	/**
	 * 设置 是否考试
	 */
	public void setIsExam(String isExam) {
		this.isExam = isExam;
	}

	/**
	 * 获取 考试结果
	 * @return String
	 */
	public String getExamRuslut() {
		return examRuslut;
	}

	/**
	 * 设置 考试结果
	 */
	public void setExamRuslut(String examRuslut) {
		this.examRuslut = examRuslut;
	}

}