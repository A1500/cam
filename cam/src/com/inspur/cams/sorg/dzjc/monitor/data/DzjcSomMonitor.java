package com.inspur.cams.sorg.dzjc.monitor.data;

import org.loushang.next.data.StatefulDatabean;

public class DzjcSomMonitor extends StatefulDatabean {

	private String sorgName;

	/**
	 * 超时到期时间
	 */
	private String toDate;
	
	/**
	 * 规定超时时限
	 */
	private String GDBLSX;
	
	private String curActivity;
	
	private String curPerson;
	
	private String processType;
	
	private String task_code;
	
	private String acceptTime;
	
	/**
	 * 距离超时天数
	 */
	private String toDateDays;
	
	private String commit_time;

	public String getSorgName() {
		return sorgName;
	}

	public void setSorgName(String sorgName) {
		this.sorgName = sorgName;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getGDBLSX() {
		return GDBLSX;
	}

	public void setGDBLSX(String gdblsx) {
		GDBLSX = gdblsx;
	}

	public String getCurActivity() {
		return curActivity;
	}

	public void setCurActivity(String curActivity) {
		this.curActivity = curActivity;
	}

	public String getCurPerson() {
		return curPerson;
	}

	public void setCurPerson(String curPerson) {
		this.curPerson = curPerson;
	}

	public String getProcessType() {
		return processType;
	}

	public void setProcessType(String processType) {
		this.processType = processType;
	}

	public String getTask_code() {
		return task_code;
	}

	public void setTask_code(String task_code) {
		this.task_code = task_code;
	}

	public String getToDateDays() {
		return toDateDays;
	}

	public void setToDateDays(String toDateDays) {
		this.toDateDays = toDateDays;
	}

	public String getCommit_time() {
		return commit_time;
	}

	public void setCommit_time(String commit_time) {
		this.commit_time = commit_time;
	}

	public String getAcceptTime() {
		return acceptTime;
	}

	public void setAcceptTime(String acceptTime) {
		this.acceptTime = acceptTime;
	}


}
