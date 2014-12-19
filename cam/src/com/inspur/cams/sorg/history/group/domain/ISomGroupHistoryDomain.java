package com.inspur.cams.sorg.history.group.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomChangeApply;

/**
 * 社会团体历史业务Domain接口
 * 
 * @author yanliangliang
 * @date 2011-11-21
 */
public interface ISomGroupHistoryDomain {

	// ---------------------------筹备---------------------------
	/**
	 * 新增筹备
	 * 
	 * @param somApply
	 */
	@Trans
	public void savePrepare(SomApply somApply);

	/**
	 * 修改筹备
	 * 
	 * @param somApply
	 */
	@Trans
	public void updatePrepare(SomApply somApply);
	/**
	 * 新增成立信息
	 * @param build
	 */
	@Trans
	public void saveBuild(SomApply build);
	/**
	 * 修改成立信息
	 * @param build
	 */
	@Trans
	public void updateBuild(SomApply build);
	/**
	 * 新增分支成立信息
	 * @param branchBuild
	 */
	@Trans
	public void saveBranchBuild(SomApply branchBuild);
	/**
	 * 修改分支成立信息
	 * @param branchBuild
	 */
	@Trans
	public void updateBranchBuild(SomApply branchBuild);
	/**
	 *  保存社会组织变更信息
	 * @param change
	 */
	@Trans
	public void saveChange(SomChangeApply change);
	/**
	 * 更新社会组织变更信息
	 * @param change
	 */
	@Trans
	public void updateChange(SomChangeApply change);
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
	// ---------------------------注销---------------------------
	/**
	 * 新增注销
	 * 
	 * @param somApply
	 */
	@Trans
	public void saveCancel(SomApply somApply);

	/**
	 * 修改注销
	 * 
	 * @param somApply
	 */
	@Trans
	public void updateCancel(SomApply somApply);

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
	 * 异地设立分支审查的保存
	 * @param branchAPCheck
	 */
	@Trans
	public void saveBranchAPCheck(SomApply branchAPCheck);
	/**
	 * 异地设立分支审查的更新
	 * @param branchAPCheck
	 */
	@Trans
	public void updateBranchAPCheck(SomApply branchAPCheck);
	
	/**
	 * 删除社会组织变更信息
	 */
	@Trans
	public void deleteChange(String taskCode);
	
	
	/**
	 * 修订社会组织变更信息，只保存change表
	 * @param somChangeApply
	 */
	@Trans
	public void updateChangeOnly(SomChangeApply somChangeApply);
	
	/**
	 * 修订社会组织分支变更信息，只保存change表
	 * @param somChangeApply
	 */
	@Trans
	public void updateBranchChangeOnly(SomChangeApply somChangeApply);
	
}
