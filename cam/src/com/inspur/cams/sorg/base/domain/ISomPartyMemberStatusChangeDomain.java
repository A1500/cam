package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public interface ISomPartyMemberStatusChangeDomain {
	/**
	 * 查询党建信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加党建信息
	 * @param somParty
	 */
	@Trans
	public void insert(SomPartyMemberStatusChange somPartyMemberStatusChange);
	
	/**
	 * 更新党建信息
	 * @param somParty
	 */
	@Trans
	public void update(SomPartyMemberStatusChange somPartyMemberStatusChange);
	
}
