package com.inspur.cams.sorg.apply.fund.domain;

import org.loushang.sca.transaction.Trans;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;
/**
 * 换届审批domain接口
 * @author yanliangliang
 * @date 2012年6月25日
 */
public interface IFundElectionApplyDomain {
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
	
}
