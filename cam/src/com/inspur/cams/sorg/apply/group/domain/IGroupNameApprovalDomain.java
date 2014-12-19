package com.inspur.cams.sorg.apply.group.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;

/**
 * 社会团体名称核准domain接口
 * @author yanliangliang
 * 2012年3月19日
 *
 */
public interface IGroupNameApprovalDomain {
	/**
	 * 保存业务数据
	 * @param somPrepare
	 */
	@Trans
	public String create(SomApply somApply);

	/**
	 * 新增筹备业务并提交流程
	 * @param somPrepare
	 */
	@Trans
	public void createAndSend(SomApply somApply);
	
	/**
	 * 修改业务数据
	 * @param somPrepare
	 */
	@Trans
	public void update(SomApply somApply);

	/**
	 * 修改保存业务并提交流程
	 * @param somPrepare
	 */
	@Trans
	public void updateAndSend(SomApply somApply);
	
	/**
	 * 提交流程
	 * @param somPrepare
	 */
	@Trans
	public void send(SomApply somApply);
}
