package com.inspur.cams.sorg.apply.group.domain;

import org.loushang.sca.transaction.Trans;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;
/**
 * 延期换届选举报批domain接口
 * @author yanliangliang
 * @date 2012年6月25日
 */
public interface IGroupElectionDelayApplyDomain {
	/**
	 * 受理保存
	 * @param somApply
	 * @param somElection
	 */
	@Trans
	public String create(SomApply somApply, SomElection somElection);
	/**
	 * 受理提交
	 * @param somApply
	 * @param somElection
	 */
	@Trans
	public void createAndSend(SomApply somApply, SomElection somElection);
	/**
	 * 受理更新保存
	 * @param somApply
	 * @param somElection
	 */
	@Trans
	public void update(SomApply somApply, SomElection somElection);
	/**
	 * 提交流程
	 * @param somApply
	 */
	@Trans
	public void send(SomApply somApply);
	
	/**
	 * 更新界次信息中的延期相关字段
	 * @param somElection
	 */
	@Trans
	public void updateSomSession(SomElection somElection);
}
