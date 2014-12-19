package com.inspur.cams.sorg.apply.fund.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;

public interface IFundBranchCancelDomain {

	/**
	 * 新增注销
	 * 
	 * @param somApply
	 * @return
	 */
	@Trans
	public String create(SomApply somApply);

	/**
	 * 新增注销并提交流程
	 * 
	 * @param somApply
	 */
	@Trans
	public void createAndSend(SomApply somApply);

	/**
	 * 修改注销
	 * 
	 * @param somApply
	 */
	@Trans
	public void update(SomApply somApply);

	/**
	 * 修改注销并提交流程
	 * 
	 * @param somApply
	 */
	@Trans
	public void updateAndSend(SomApply somApply);

	/**
	 * 发送流程
	 * 
	 * @param taskCode
	 */
	@Trans
	public void send(SomApply somApply);

	/**
	 * 查询社会组织状态
	 * 
	 * @param sorgId
	 * @param ifBranch
	 * @return
	 */
	public SomOrgan querySorgStatus(String sorgId, String ifBranch);
}
