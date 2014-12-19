package com.inspur.cams.sorg.history.ungov.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomChangeApply;

public interface ISomUngovHistoryDomain {

	//---------------------------成立---------------------------
	/**
	 * 保存业务信息
	 */
	@Trans
	public void insertBuildInfo(SomApply somApply);
	/**
	 * 更新业务信息
	 */
	@Trans
	public void updateBuildInfo(SomApply somApply);
	//---------------------------变更---------------------------
	/**
	 *  保存变更信息
	 * @param change
	 */
	@Trans
	public void saveChange(SomChangeApply change);
	/**
	 * 更新变更信息
	 * @param change
	 */
	@Trans
	public void updateChange(SomChangeApply change);
	//---------------------------注销---------------------------
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
	
	/**
	 * 修订社会组织变更信息，只保存change表
	 * @param somChangeApply
	 */
	@Trans
	public void updateChangeOnly(SomChangeApply somChangeApply);
	
}
