package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomLiqpeopleOnline;

/**
 * @title:ISomLiqpeopleOnlineDao
 * @description:
 * @author:
 * @since:2012-11-14
 * @version:1.0
*/
 public interface ISomLiqpeopleOnlineDao extends BaseCURD<SomLiqpeopleOnline>{
	public void save(List<SomLiqpeopleOnline> list);
}

