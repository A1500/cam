package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomPartyPraise;
/**
 * 
 * @title 党建党内奖惩domain接口
 *
 */
public interface ISomPartyPraiseDomain {
	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(SomPartyPraise somPartyPraise);
	
	@Trans
	public void update(SomPartyPraise somPartyPraise);
	
	@Trans
	public void delete(String praiseId);
	
	@Trans
	public void deleteByMemberId(String memberId);
	
	@Trans
	public void uploadSave_praise(SomPartyPraise somPartyPraise);
}
