package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomPartyPraiseOnline;

/**
 * @title:ISomPartyPraiseOnlineDao
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public interface ISomPartyPraiseOnlineDao extends BaseCURD<SomPartyPraiseOnline>{
	public void save(List<SomPartyPraiseOnline> list);
}

