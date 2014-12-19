package com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckCouncilMeetingDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckCouncilMeetingDao extends BaseCURD<SomCheckCouncilMeeting>{
	public void save(List<SomCheckCouncilMeeting> list);
}

