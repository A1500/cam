package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.sorg.base.dao.ISomMeetingDao;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;

/**
 * 社会组织会议domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public class SomMeetingDomain implements ISomMeetingDomain {
	
	@Reference
	private ISomMeetingDao somMeetingDao;

	public DataSet query(ParameterSet pset) {
		return somMeetingDao.query(pset);
	}

	public SomMeeting get(String meetingId) {
		return somMeetingDao.get(meetingId);
	}
	
	public void insert(SomMeeting somMeeting) {
		somMeetingDao.insert(somMeeting);
	}

	public void update(SomMeeting somMeeting) {
		somMeetingDao.update(somMeeting);
	}

	public void batchInsert(List<SomMeeting> lists) {
		somMeetingDao.batchInsert(lists);
	}

	public void batchUpdate(List<SomMeeting> lists) {
		somMeetingDao.batchUpdate(lists);
	}
	
	/**
	 * 通过会议关联章程、会费、负责人换届是否进行过，需要查询换届备案已经完成的
	 * @param pset
	 * @return
	 */
	public DataSet qurtyWithBeianInfo(ParameterSet pset) {
		return somMeetingDao.qurtyWithBeianInfo(pset);
	}

}
