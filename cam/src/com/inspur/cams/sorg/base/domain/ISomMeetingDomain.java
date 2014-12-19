package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomMeeting;

/**
 * 社会组织会议domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomMeetingDomain {

	/**
	 * 查询社会组织会议
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 获取一条会议信息
	 * @param meetingId
	 * @return
	 */
	public SomMeeting get(String meetingId);
	
	/**
	 * 增加社会组织会议
	 * @param somMeeting
	 */
	@Trans
	public void insert(SomMeeting somMeeting);
	
	/**
	 * 更新社会组织会议
	 * @param somMeeting
	 */
	@Trans
	public void update(SomMeeting somMeeting);
	
	/**
	 * 批量增加人员信息
	 * @param lists
	 */
	@Trans
	public void batchInsert(List<SomMeeting> lists);
	
	/**
	 * 批量更新人员信息
	 * @param lists
	 */
	@Trans
	public void batchUpdate(List<SomMeeting> lists);
	
	/**
	 * 通过会议关联章程、会费、负责人换届是否进行过，需要查询换届备案已经完成的
	 * @param pset
	 * @return
	 */
	public DataSet qurtyWithBeianInfo(ParameterSet pset);
}
