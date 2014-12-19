package com.inspur.cams.sorg.check.checkintermeeting.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkintermeeting.data.SomCheckInterMeeting;

/**
 * @title:ISomCheckInterMeetingDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 public interface ISomCheckInterMeetingDao extends BaseCURD<SomCheckInterMeeting>{
	public void save(List<SomCheckInterMeeting> list);
	public void deleteByTaskCode(String taskCode);
}

