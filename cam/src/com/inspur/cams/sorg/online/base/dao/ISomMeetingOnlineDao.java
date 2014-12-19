package com.inspur.cams.sorg.online.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.online.base.data.SomMeetingOnline;

/**
 * @title:ISomMeetingOnlineDao
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public interface ISomMeetingOnlineDao extends BaseCURD<SomMeetingOnline>{
	public void save(List<SomMeetingOnline> list);
}

