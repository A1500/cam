package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomOfficeOnline;

/**
 * @title:ISomOfficeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-26
 * @version:1.0
*/
 public interface ISomOfficeOnlineDao extends BaseCURD<SomOfficeOnline>{
	public void save(List<SomOfficeOnline> list);
}

