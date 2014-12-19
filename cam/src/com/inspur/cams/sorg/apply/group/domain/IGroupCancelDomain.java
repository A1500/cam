package com.inspur.cams.sorg.apply.group.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;

public interface IGroupCancelDomain {

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
	 */
	public String querySorgStatus(String sorgId);

	/**
	 * 根据sorgId，删除社会组织清算组织人员
	 * 
	 * @param sorgId
	 */
	@Trans
	public void delLiqpeopleBySorgId(String sorgId);

	/**
	 * 获取最后环节processId
	 */
	public String queryProcessId(String id);
}
