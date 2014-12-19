package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomPartyPraise;

/**
 * 党建党内奖惩dao接口
 */
public interface ISomPartyPraiseDao extends BaseCURD<SomPartyPraise> {	
	public void save(List<SomPartyPraise> list);	
	public void deleteByMemberId(String memberId);
}
