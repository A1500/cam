package com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCouncilMeetingDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public interface ISomJxCouncilMeetingDao extends BaseCURD<SomJxCouncilMeeting>{
	public void save(List<SomJxCouncilMeeting> list);
}

