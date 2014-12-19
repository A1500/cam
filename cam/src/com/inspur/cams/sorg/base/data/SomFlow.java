package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织业务流程历史意见
 * @author shgtch
 * @date 2011-8-9
 */
@Table(tableName = "SOM_FLOW", keyFields = "logId")
public class SomFlow extends StatefulDatabean {
	
	// 流程意见ID
	private String logId;
	
	// 业务编号
	private String taskCode;
	
	// 社会组织ID
	private String sorgId;
	
	// 业务种类
	private String applyType;
	
	// 流程环节
	private String activity;
	
	// 处理意见
	private String opinionId;
	
	// 处理补充意见
	private String opinion;
	
	// 处理单位ID
	private String organId;
	
	// 处理单位名称
	private String organName;
	
	// 处理部门ID
	private String deptId;
	
	// 处理部门名称
	private String deptName;
	
	// 处理人ID
	private String actorId;
	
	// 处理人名称
	private String actorName;
	
	// 处理时间
	private String commitTime;

	public String getLogId() {
		return logId;
	}

	public void setLogId(String logId) {
		this.logId = logId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getOpinionId() {
		return opinionId;
	}

	public void setOpinionId(String opinionId) {
		this.opinionId = opinionId;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getActorId() {
		return actorId;
	}

	public void setActorId(String actorId) {
		this.actorId = actorId;
	}

	public String getActorName() {
		return actorName;
	}

	public void setActorName(String actorName) {
		this.actorName = actorName;
	}

	public String getCommitTime() {
		return commitTime;
	}

	public void setCommitTime(String commitTime) {
		this.commitTime = commitTime;
	}

}