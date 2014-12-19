package com.inspur.cams.sorg.online.apply.managePeople.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.base.data.SomSession;

/**
 * 社会组织任职信息表domain接口
 * @author 
 * @date 
 */
public interface IManagePeopleDomain {
	
	/**
	 * 查询社会组织任职信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 查询社会组织任职信息
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
	 * 增加社会组织任职信息
	 * @param somDuty
	 */
	@Trans
	public void insert(SomDuty somDuty);
	
	/**
	 * 更新社会组织任职信息
	 * @param somDuty
	 */
	@Trans
	public void update(SomDuty somDuty);
	
	/**
	 * 增加人员
	 * 
	 * @param somDuty
	 */
	public void createPeople(SomDuty somDuty) ;
	
	
	/**
	 * 修改负责人备案信息
	 * @param somSession
	 */
	@Trans
	public void updateRegPeople(SomApply somApply);
	
	/**
	 * 社会组织换届负责人备案
	 * @param somSession
	 */
	@Trans
	public void changeRegPeople(SomApply somApply);
	
	/**
	 * 根据业务编号删除此业务的任职信息
	 * @param taskCode
	 */
	@Trans
	public void deleteByTaskCode(String taskCode);
	
	/**
	 * 根据taskcode更新备案人员的备案状态
	 * @param regStatus
	 * @param taskCode
	 */
	@Trans
	public void updateRegStatus(String regStatus, String taskCode) ;
	
	/**
	 * 变更业务中更新法定代表人的信息(在update中更换的情况)
	 * @param taskCode
	 */
	@Trans
	public void reNewPeopleInfo(String taskCode);
	/**
	 * 查询社会组织是否为分支
	 * @param sorgId
	 * @return
	 */
	public String queryOrganIfBranch(String sorgId);
	/**
	 * 查询拟任负责人信息
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet queryAspchief(ParameterSet pset);
	@Trans
	public String createPeople(SomPeople somPeople) ;
	/**
	 *  基金会分支负责人备案时的保存
	 * @param somDuty
	 */
	@Trans
	public void saveBranchPeople(SomDuty somDuty);
	/**
	 * 通过任职状态删除任职信息
	 * @param regStatus
	 * @param sorgId
	 */
	@Trans
	public void deleteByRegStatus(String sorgId,String regStatus);
	/**
	 * 更新somDutyElectronic表中人员的dutyId
	 * @param somDuty
	 */
	@Trans
	public void changeOldDutyIdToNew(SomDuty somDuty);
	/**
	 * 获取当前届次任职信息
	 * @param sorgId
	 * @return
	 */
	public DataSet queryCurDuty(String sorgId);
	
	/**
	 * 根据人员姓名和sorgid查出duty信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleByName(ParameterSet pset);
}
