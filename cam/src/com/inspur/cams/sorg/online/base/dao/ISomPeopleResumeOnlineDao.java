package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomPeopleResumeOnline;

/**
 * @title:ISomPeopleResumeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public interface ISomPeopleResumeOnlineDao extends BaseCURD<SomPeopleResumeOnline>{
	public void save(List<SomPeopleResumeOnline> list);
}

