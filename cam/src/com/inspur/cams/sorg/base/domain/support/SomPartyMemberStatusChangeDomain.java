package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomPartyMemberStatusChangeDao;
import com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberStatusChangeDomain;
/**
 * 
 * @title SOM_PARTY_MEMBER_STATUS_CHANGEdomain
 *
 */
public class SomPartyMemberStatusChangeDomain implements ISomPartyMemberStatusChangeDomain{
	@Reference
	private ISomPartyMemberStatusChangeDao somPartyMemberStatusChangeDao;
	
	public DataSet query(ParameterSet pset) {
		return somPartyMemberStatusChangeDao.query(pset);
	}
	public void insert(SomPartyMemberStatusChange somPartyMemberStatusChange) {
		somPartyMemberStatusChangeDao.insert(somPartyMemberStatusChange);
	}
	public void update(SomPartyMemberStatusChange somPartyMemberStatusChange) {
		somPartyMemberStatusChangeDao.update(somPartyMemberStatusChange);
	}
}
