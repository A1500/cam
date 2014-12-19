package com.inspur.cams.sorg.manage.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomParty;
import com.inspur.cams.sorg.base.data.SomPartyChange;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberStatusChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyPraiseDomain;
import com.inspur.cams.sorg.manage.domain.ISomPartyOrganDomain;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public class SomPartyOrganDomain implements ISomPartyOrganDomain {
	@Reference
	private ISomPartyDomain somPartyDomain;
	@Reference 
	private ISomPartyMemberDomain somPartyMemberDomain;
	@Reference 
	private ISomPartyPraiseDomain somPartyPraiseDomain;
	@Reference 
	private ISomPartyChangeDomain somPartyChangeDomain;
	@Reference
	private ISomOrganDomain  somOrganDomain;
	@Reference
	private ISomPartyMemberStatusChangeDomain  somPartyMemberStatusChangeDomain;
	/**
	 * 查询党建信息
	 * @param pset
	 * @return
	 */
	public DataSet queryParty(ParameterSet pset) {
		
		return somPartyDomain.query(pset);
	}
	/**
	 * 增加党建信息
	 * @param somParty
	 */
	@Trans
	public void insertParty(SomParty somParty) {
		//String currentId =IdHelp.getUUID30();	
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		//ParameterSet pset=new ParameterSet();
		//pset.setParameter("SORG_ID@=", somParty.getSorgId());
		//SomOrgan somOrgan=(SomOrgan)somOrganDomain.query(pset).getRecord(0).toBean(SomOrgan.class);
		//somParty.setPartyId(currentId);
		somParty.setMorgName(morgName);
		somParty.setMorgArea(morgArea);
		somParty.setPartyStatus("0");
		somPartyDomain.insert(somParty);
//		String sorgId=somParty.getSorgId();
//		somOrganDomain.updateRegPartyById(sorgId,"1");

		List<SomPartyPraise> somPartyPraiseList=somParty.getSomPartyPraiseList();
		dealPartyPraise(somPartyPraiseList);
	}
	/**
	 * 更新党建信息
	 * @param somParty
	 */
	@Trans
	public void updateParty(SomParty somParty) {		
		somPartyDomain.update(somParty);
		List<SomPartyPraise> somPartyPraiseList=somParty.getSomPartyPraiseList();
		dealPartyPraise(somPartyPraiseList);
		List<SomPartyChange> somPartyChangeList=somParty.getSomPartyChangeList();
		dealPartyChange(somPartyChangeList);
	}
	/**
	 * 注销党建信息
	 * @param somParty
	 */
	@Trans
	public void cancelParty(SomParty somParty) {
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", somParty.getSorgId());
		SomOrgan somOrgan=(SomOrgan)somOrganDomain.query(pset).getRecord(0).toBean(SomOrgan.class);
		somPartyDomain.update(somParty);
//		String sorgId=somParty.getSorgId();
//		somOrganDomain.updateRegPartyById(sorgId,"0");
	}

	/**
	 * 查询党员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPartyMember(ParameterSet pset) {
		return somPartyMemberDomain.query(pset);
	}

	/**
	 * 增加党员信息
	 * @param somPartyMember
	 */
	@Trans
	public void insertPartyMember(SomPartyMember somPartyMember) {
		String morgName = BspUtil.getCorpOrgan().getOrganName();
		String morgArea = BspUtil.getCorpOrgan().getOrganCode();
		String regPeopleOrganId = BspUtil.getEmpOrganId();
		String regPeople = BspUtil.getEmpOrgan().getOrganName();
		String regDate = DateUtil.getDay();
		somPartyMember.setMorgArea(morgArea);
		somPartyMember.setMorgName(morgName);
		somPartyMember.setRegPeopleOrganId(regPeopleOrganId);
		somPartyMember.setRegPeople(regPeople);
		somPartyMember.setRegDate(regDate);
		//处理党员状态，判断是转入的时候，党员状态为4，写入状态历史表
		if(somPartyMember.getInType()!=""){
			somPartyMember.setMemberStatus("4");
			somPartyMember.setStatusChangeDate(regDate);
			SomPartyMemberStatusChange somPartyMemberStatusChange = new SomPartyMemberStatusChange();
			somPartyMemberStatusChange.setChangeId(IdHelp.getUUID32());
			somPartyMemberStatusChange.setMemberId(somPartyMember.getMemberId());
			somPartyMemberStatusChange.setChangeType(somPartyMember.getMemberStatus());
			somPartyMemberStatusChange.setChangeTime(somPartyMember.getStatusChangeDate());
			somPartyMemberStatusChange.setRegPeople(regPeople);
			somPartyMemberStatusChange.setRegDate(regDate);
			somPartyMemberStatusChangeDomain.insert(somPartyMemberStatusChange);
		}
		somPartyMemberDomain.insert(somPartyMember);
		List<SomPartyPraise> somPartyPraiseList=somPartyMember.getSomPartyPraiseList();
		dealPartyPraise(somPartyPraiseList);
		
	}

	/**
	 * 更新党员信息
	 * @param somPartyMember
	 */
	@Trans
	public void updatePartyMember(SomPartyMember somPartyMember) {
		somPartyMemberDomain.update(somPartyMember);
		List<SomPartyPraise> somPartyPraiseList=somPartyMember.getSomPartyPraiseList();
		dealPartyPraise(somPartyPraiseList);
	}
	@Trans
	public void delPartyMember(String memberId) {
		somPartyPraiseDomain.deleteByMemberId(memberId);
		somPartyMemberDomain.delete(memberId);
	}
	@Trans
	public void update_member(SomPartyMember somPartyMember) {
		somPartyMemberDomain.update(somPartyMember);
	}
	
	/**
	 * 查询党内奖励
	 * @param pset
	 * @return
	 */
	public DataSet queryPartyPraise(ParameterSet pset) {
		return somPartyPraiseDomain.query(pset);
	}
	
	/**
	 * 查询党建变更
	 * @param pset
	 * @return
	 */
	public DataSet queryPartyChange(ParameterSet pset) {
		return somPartyChangeDomain.query(pset);
	}
	
	@Trans
	public void dealPartyPraise(List<SomPartyPraise> somPartyPraiseList){
		for (int i = 0; i < somPartyPraiseList.size(); i++) {
			SomPartyPraise somPartyPraise = somPartyPraiseList.get(i);
			if (somPartyPraise.getState() == Record.STATE_NEW) {
				if(somPartyPraise.getPraiseId()==null ||"".equals(somPartyPraise.getPraiseId())){
					somPartyPraise.setPraiseId(IdHelp.getUUID32());
					somPartyPraiseDomain.insert(somPartyPraise);
				}else{
					somPartyPraiseDomain.update(somPartyPraise);
				}
			} else if (somPartyPraise.getState() == Record.STATE_MODIFIED) {
				somPartyPraiseDomain.update(somPartyPraise);
			} else if (somPartyPraise.getState() == Record.STATE_DELETED) {
				somPartyPraiseDomain.delete(somPartyPraise.getPraiseId());
			}
		}
	}
	
	@Trans
	public void dealPartyChange(List<SomPartyChange> somPartyChangeList){
		for (int i = 0; i < somPartyChangeList.size(); i++) {
			SomPartyChange somPartyChange = somPartyChangeList.get(i);
			if (somPartyChange.getState() == Record.STATE_NEW) {
				if(somPartyChange.getChangeId()==null ||"".equals(somPartyChange.getChangeId())){
					somPartyChange.setChangeId(IdHelp.getUUID32());
					somPartyChangeDomain.insert(somPartyChange);
				}else{
					somPartyChangeDomain.update(somPartyChange);
				}
			} else if (somPartyChange.getState() == Record.STATE_MODIFIED) {
				somPartyChangeDomain.update(somPartyChange);
			} else if (somPartyChange.getState() == Record.STATE_DELETED) {
				somPartyChangeDomain.delete(somPartyChange.getChangeId());
			}
		}
	}
	
	@Trans
	public String uploadSave_praise(SomPartyPraise somPartyPraise){
		String praiseId=somPartyPraise.getPraiseId();
		if(praiseId==null||"".equals(praiseId)){
			somPartyPraise.setPraiseId(IdHelp.getUUID30());
			somPartyPraiseDomain.insert(somPartyPraise);
		}
		somPartyPraiseDomain.uploadSave_praise(somPartyPraise);
		return somPartyPraise.getPraiseId();
	}
	
	@Trans
	public String uploadSave_change(SomPartyChange somPartyChange){
		String changeId=somPartyChange.getChangeId();
		if (changeId==null||"".equals(changeId)) {
			somPartyChange.setChangeId(IdHelp.getUUID30());
			somPartyChangeDomain.insert(somPartyChange);
		}
		somPartyChangeDomain.uploadSave_change(somPartyChange);
		return somPartyChange.getChangeId();
	}
	
	/**
	 * 维护党员转出信息
	 * @param somPartyMember
	 */
	@Trans
	public void saveFullPartyOut(SomParty somParty) {
		somPartyDomain.update(somParty);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", somParty.getSorgId());
		DataSet partyMemberDs = somPartyMemberDomain.query(pset);
		for(int i = 0; i < partyMemberDs.getCount(); i++){
			SomPartyMember somPartyMember = (SomPartyMember)partyMemberDs.getRecord(i).toBean(SomPartyMember.class);
			somPartyMember.setOutTime(somParty.getOutTime());
			somPartyMember.setOutType(somParty.getOutType());
			somPartyMember.setOutToOrgan(somParty.getOutToOrgan());
			somPartyMember.setMemberStatus("3");
			somPartyMember.setStatusChangeDate(DateUtil.getDay());
			somPartyMemberDomain.update(somPartyMember);
			SomPartyMemberStatusChange somPartyMemberStatusChange = new SomPartyMemberStatusChange();
			somPartyMemberStatusChange.setChangeId(IdHelp.getUUID32());
			somPartyMemberStatusChange.setMemberId(somPartyMember.getMemberId());
			somPartyMemberStatusChange.setChangeType(somPartyMember.getMemberStatus());
			somPartyMemberStatusChange.setChangeTime(somPartyMember.getStatusChangeDate());
			somPartyMemberStatusChange.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
			somPartyMemberStatusChange.setRegDate(DateUtil.getDay());
			somPartyMemberStatusChangeDomain.insert(somPartyMemberStatusChange);
		}
	}
	
	/**
	 * 维护党员状态
	 * @param somParty
	 */
	@Trans
	public void saveMemberStatusChangeInfo(SomPartyMember somPartyMember) {
		somPartyMemberDomain.update(somPartyMember);
		SomPartyMemberStatusChange somPartyMemberStatusChange = new SomPartyMemberStatusChange();
		somPartyMemberStatusChange.setChangeId(IdHelp.getUUID32());
		somPartyMemberStatusChange.setMemberId(somPartyMember.getMemberId());
		somPartyMemberStatusChange.setChangeType(somPartyMember.getMemberStatus());
		somPartyMemberStatusChange.setChangeTime(somPartyMember.getStatusChangeDate());
		somPartyMemberStatusChange.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		somPartyMemberStatusChange.setRegDate(DateUtil.getDay());
		somPartyMemberStatusChangeDomain.insert(somPartyMemberStatusChange);
	}
	
	/**
	 * 维护党员转出状态
	 * @param somParty
	 */
	@Trans
	public void saveMemberOutInfo(SomPartyMember somPartyMember) {
		somPartyMember.setMemberStatus("3");
		somPartyMember.setStatusChangeDate(DateUtil.getDay());
		somPartyMemberDomain.update(somPartyMember);
		SomPartyMemberStatusChange somPartyMemberStatusChange = new SomPartyMemberStatusChange();
		somPartyMemberStatusChange.setChangeId(IdHelp.getUUID32());
		somPartyMemberStatusChange.setMemberId(somPartyMember.getMemberId());
		somPartyMemberStatusChange.setChangeType(somPartyMember.getMemberStatus());
		somPartyMemberStatusChange.setChangeTime(somPartyMember.getStatusChangeDate());
		somPartyMemberStatusChange.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		somPartyMemberStatusChange.setRegDate(DateUtil.getDay());
		somPartyMemberStatusChangeDomain.insert(somPartyMemberStatusChange);
	}
}
