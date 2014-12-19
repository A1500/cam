package com.inspur.cams.sorg.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomMeeting;

/**
 * 社会组织会议dao接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomMeetingDao extends BaseCURD<SomMeeting> {
	
	public void save(List<SomMeeting> list);
	
	/**
	 * 通过会议关联章程、会费、负责人换届是否进行过，需要查询换届备案已经完成的
	 * @param pset
	 * @return
	 */
	public DataSet qurtyWithBeianInfo(ParameterSet pset);
	
}

