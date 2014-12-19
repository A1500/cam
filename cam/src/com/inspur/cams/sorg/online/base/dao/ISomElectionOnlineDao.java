package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomElectionOnline;

/**
 * @title:ISomElectionOnlineDao
 * @description:
 * @author:
 * @since:2012-11-22
 * @version:1.0
*/
 public interface ISomElectionOnlineDao extends BaseCURD<SomElectionOnline>{
	public void save(List<SomElectionOnline> list);
}

