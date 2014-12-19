package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomPeopleOnline;

/**
 * @title:ISomPeopleOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public interface ISomPeopleOnlineDao extends BaseCURD<SomPeopleOnline>{
	public void save(List<SomPeopleOnline> list);
}

