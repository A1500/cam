package com.inspur.cams.sorg.apply.fund.domain;

import java.util.Map;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;

/**
 * 基金会分支domain接口
 * @author zhaojin
 * @date 2011-8-9
 */
public interface IFundBranchBuildDomain {

	/**
	 * 保存业务数据
	 * @param somPrepare
	 */
	@Trans
	public Map create(SomApply somApply);

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
	 * 更新业务意见信息
	 * @param applyBean
	 */
	@Trans
	public void updateApply(SomApply applyBean);
	
	/**
	 * 保存并发送
	 * @param sorgId
	 * @param actDefUniqueId
	 * @param flowBean
	 */
	@Trans
	public void send(SomApply applyBean);
	
	/**
	 * 打印环节发送
	 * @param applyBean
	 */
	@Trans
	public void printForSend(SomApply applyBean);
	
}
