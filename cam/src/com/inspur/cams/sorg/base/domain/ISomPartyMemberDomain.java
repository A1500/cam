package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomParty;
import com.inspur.cams.sorg.base.data.SomPartyMember;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public interface ISomPartyMemberDomain {
	/**
	 * 查询党员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加党员信息
	 * @param somPartyMember
	 */
	@Trans
	public void insert(SomPartyMember somPartyMember);
	
	/**
	 * 更新党员信息
	 * @param somPartyMember
	 */
	@Trans
	public void update(SomPartyMember somPartyMember);
	
	/**
	 * 删除党员信息
	 * @param memberId
	 */
	@Trans
	public void delete(String memberId);
	@Trans
	public void deleteBySorgId(String sorgId);
}
