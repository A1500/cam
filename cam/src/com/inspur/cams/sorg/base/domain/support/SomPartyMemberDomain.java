package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomPartyMemberDao;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberDomain;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public class SomPartyMemberDomain implements ISomPartyMemberDomain{
	@Reference
	private ISomPartyMemberDao somPartyMemberDao;
	/**
	 * 查询党员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somPartyMemberDao.query(pset);
	}
	/**
	 * 增加党员信息
	 * @param somParty
	 */
	public void insert(SomPartyMember somPartyMember) {
		somPartyMemberDao.insert(somPartyMember);
	}
	/**
	 * 修改党员信息
	 * @param somParty
	 */
	public void update(SomPartyMember somPartyMember) {
		somPartyMemberDao.update(somPartyMember);
	}
	/**
	 * 删除党员信息
	 * @param memberId
	 */
	public void delete(String memberId) {
		somPartyMemberDao.delete(memberId);		
	}
	public void deleteBySorgId(String sorgId) {
		somPartyMemberDao.deleteBySorgId(sorgId);		
	}
}
