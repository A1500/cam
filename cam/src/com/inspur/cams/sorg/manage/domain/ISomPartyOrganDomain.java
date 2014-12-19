package com.inspur.cams.sorg.manage.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomParty;
import com.inspur.cams.sorg.base.data.SomPartyChange;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;

/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public interface ISomPartyOrganDomain {

	/**
	 * 查询党建信息
	 * @param pset
	 * @return
	 */
	public DataSet queryParty(ParameterSet pset);

	/**
	 * 增加党建信息
	 * @param somParty
	 */
	@Trans
	public void insertParty(SomParty somParty);
	
	/**
	 * 更新党建信息
	 * @param somParty
	 */
	@Trans
	public void updateParty(SomParty somParty);
	/**
	 *注销党建信息
	 * @param somParty
	 */
	@Trans
	public void cancelParty(SomParty somParty);
	/**
	 * 查询党员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPartyMember(ParameterSet pset);

	/**
	 * 增加党员信息
	 * @param somPartyMember
	 */
	@Trans
	public void insertPartyMember(SomPartyMember somPartyMember);
	
	/**
	 * 更新党员信息
	 * @param somPartyMember
	 */
	@Trans
	public void updatePartyMember(SomPartyMember somPartyMember);
	@Trans
	public void update_member(SomPartyMember somPartyMember);
	@Trans
	public void delPartyMember(String memberId);
	/**
	 * 查询党内奖惩
	 * @param pset
	 * @return
	 */
	public DataSet queryPartyPraise(ParameterSet pset);
	/**
	 * 查询党建变更
	 * @param pset
	 * @return
	 */
	public DataSet queryPartyChange(ParameterSet pset);
	
	public String uploadSave_praise(SomPartyPraise somPartyPraise);
	public String uploadSave_change(SomPartyChange somPartyChange);
	
	/**
	 * 维护党员转出信息
	 * @param somPartyMember
	 */
	public void saveFullPartyOut(SomParty somParty) ;
	
	/**
	 * 维护党员状态
	 * @param somPartyMember
	 */
	public void saveMemberStatusChangeInfo(SomPartyMember somPartyMember) ;
	
	/**
	 * 维护党员转出状态
	 * @param somPartyMember
	 */
	public void saveMemberOutInfo(SomPartyMember somPartyMember) ;
}
