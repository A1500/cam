package com.inspur.cams.sorg.check.checkmeetingelection.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkmeetingelection.data.SomCheckMeetingElection;

/**
 * @title:ISomCheckMeetingElectionDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckMeetingElectionDao extends BaseCURD<SomCheckMeetingElection>{
	public void save(List<SomCheckMeetingElection> list);
}

