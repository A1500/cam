package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomHeldOrganOnline;

/**
 * @title:ISomHeldOrganOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public interface ISomHeldOrganOnlineDao extends BaseCURD<SomHeldOrganOnline>{
	public void save(List<SomHeldOrganOnline> list);
}

