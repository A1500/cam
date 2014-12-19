package com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckInterMeetingDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckInterMeetingDao extends BaseCURD<SomJxCheckInterMeeting>{
	public void save(List<SomJxCheckInterMeeting> list);
}

