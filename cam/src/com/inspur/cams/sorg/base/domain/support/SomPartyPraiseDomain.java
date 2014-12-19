package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomPartyPraiseDao;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.domain.ISomPartyPraiseDomain;
/**
 * 
 * @title 党建党内奖惩domain
 *
 */
public class SomPartyPraiseDomain implements ISomPartyPraiseDomain{
	@Reference
	private ISomPartyPraiseDao somPartyPraiseDao;
	public DataSet query(ParameterSet pset) {
		return somPartyPraiseDao.query(pset);
	}
	public void insert(SomPartyPraise somPartyPraise) {
		somPartyPraiseDao.insert(somPartyPraise);
	}
	public void update(SomPartyPraise somPartyPraise) {
		somPartyPraiseDao.update(somPartyPraise);
	}
	public void delete(String praiseId) {
		somPartyPraiseDao.delete(praiseId);		
	}
	public void deleteByMemberId(String memberId) {
		somPartyPraiseDao.deleteByMemberId(memberId);		
	}
	public void uploadSave_praise(SomPartyPraise somPartyPraise){
		somPartyPraiseDao.updateWithFile(somPartyPraise);
	}
}
