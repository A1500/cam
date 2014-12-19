package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomRuleOnline;

/**
 * @title:ISomRuleOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public interface ISomRuleOnlineDao extends BaseCURD<SomRuleOnline>{
	public void save(List<SomRuleOnline> list);
}

