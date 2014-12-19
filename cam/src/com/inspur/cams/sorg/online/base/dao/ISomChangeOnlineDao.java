package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomChangeOnline;

/**
 * @title:ISomChangeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-12
 * @version:1.0
*/
 public interface ISomChangeOnlineDao extends BaseCURD<SomChangeOnline>{
	public void save(List<SomChangeOnline> list);
}

