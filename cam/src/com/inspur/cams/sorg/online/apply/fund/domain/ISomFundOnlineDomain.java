package com.inspur.cams.sorg.online.apply.fund.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomOrgan;

/**
 * 基金会外网业务Domain接口
 * 
 * @author yanliangliang
 * @date 2012年11月28日
 */
public interface ISomFundOnlineDomain {
	/**
	 * @title 保存申请名称核准 
	 * @param approvalInfo
	 */
	@Trans
	public void saveNameApproval(SomApply approvalInfo);
	/**
	 * @title 保存设立登记
	 * @param approvalInfo
	 */
	@Trans
	public void saveBuild(SomApply buildInfo);
	// ---------------------------分支设立---------------------------
	/**
	 * 新增分支设立信息
	 * @param branchBuild
	 */
	@Trans
	public void saveBranchBuild(SomApply branchBuild);
	/**
	 * 修改分支设立信息
	 * @param branchBuild
	 */
	@Trans
	public void updateBranchBuild(SomApply branchBuild);
	/**
	 * @title 保存变更登记
	 * @param changeInfo
	 */
	@Trans
	public void saveChange(SomChangeApply changeInfo);
	// ---------------------------分支变更---------------------------
	/**
	 * 保存社会组织分支变更信息
	 * @param somChangeApply
	 */
	@Trans
	public void saveBranchChange(SomChangeApply change);
	/**
	 * 更新社会组织分支变更信息
	 * @param somChangeApply
	 */
	@Trans
	public void updateBranchChange(SomChangeApply change);
	/**
	 * @title 保存注销登记
	 */
	@Trans
	public void saveCancel(SomApply cancel);
	// ---------------------------分支注销---------------------------
	/**
	 * 新增分支注销
	 * 
	 * @param somApply
	 */
	@Trans
	public void saveBranchCancel(SomApply somApply);

	/**
	 * 修改分支注销
	 * 
	 * @param somApply
	 */
	@Trans
	public void updateBranchCancel(SomApply somApply);
	/**
	 * 保存章程信息
	 */
	@Trans
	public void saveRule(SomApply ruleInfo);
	/**
	 * 保存换届事先报批
	 */
	@Trans
	public void saveElection(SomApply somApply, SomOrgan somOrgan, SomElection election);
	
	/**
	 * 保存延期换届选举报批
	 */
	@Trans
	public void saveElectionDelay(SomApply somApply, SomOrgan somOrgan, SomElection electionDelay);
	public void saveManPeople(SomApply somSession);
	
}
