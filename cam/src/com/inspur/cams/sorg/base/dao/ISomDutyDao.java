package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomDuty;

/**
 * 社会组织任职信息Dao接口
 * @author yanliangliang
 * @date 2011-9-22
 */
public interface ISomDutyDao extends BaseCURD<SomDuty> {
	
	/**
	 * 查询人员的任职信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeople(ParameterSet pset);
	
	/**
	 * 综合查询人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryTogether(ParameterSet pset);
	
	/**
	 * 查询任职信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDutyInfo(ParameterSet pset);

	/**
	 * 换届将当前任职人员在任状态修改为离任，并且维护任职结束时间
	 * @param sessionId
	 * @param endDate
	 */
	public void changeSession(String sessionId, String endDate);
	/**
	 * 根据taskCode删除一组记录
	 * @param dutyId
	 */
	public void deleteDuty(String taskCode);
	/**
	 * 根据SessionId删除一组记录
	 */
	public void deleteDutyBySessionId(String sessionId);
	/**
	 * 根据taskcode更新备案人员的备案状态
	 * @param regStatus
	 * @param taskCode
	 */
	public void updateRegStatus(String regStatus, String taskCode) ;
	
	/**
	 * 通过任职状态删除任职信息
	 * @param regStatus
	 * @param sorgId
	 */
	public void deleteByRegStatus(String sorgId, String regStatus);
	
	/**
	 * 根据人员姓名和SORGID查出duty信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleByName(ParameterSet pset);
	
	public void deleteSessionByTaskCode(String taskCode);
	
	public void deleteResumeByTaskCode(String taskCode);
	
	public void deleteElectronicByTaskCode(String taskCode);
	
}
