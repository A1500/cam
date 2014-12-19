package com.inspur.cams.sorg.online.apply.delayElection.domain;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;
/**
 * 延期换届选举报批domain接口
 * @author 
 * @date 
 */
public interface ISomElectionDelayOnlineDomain {
	/**
	 * 受理保存
	 * @param somApply
	 * @param somElection
	 */
	@Trans
	public void insert(SomApply somApply, SomElection somElection);
	/**
	 * 受理更新保存
	 * @param somApply
	 * @param somElection
	 */
	@Trans
	public void update(SomApply somApply, SomElection somElection);
}
