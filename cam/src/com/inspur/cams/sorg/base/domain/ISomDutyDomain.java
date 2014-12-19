package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomSession;

/**
 * 社会组织任职信息表domain接口
 * @author yanliangliang
 * @date 2011-9-20
 */
public interface ISomDutyDomain {
	
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
	 * 社会组织成立备案
	 * somSession需填写社会组织编号、业务编号、顺序号
	 * @param somSession
	 */
	@Trans
	public void regPeople(SomSession somSession);
	
	/**
	 * 民非成立备案
	 * somSession需填写社会组织编号、业务编号、顺序号
	 * @param somSession
	 */
	@Trans
	public void regUngovPeople(SomSession somSession);
	/**
	 * 修改负责人备案信息
	 * @param somSession
	 */
	@Trans
	public void updateRegPeople(SomSession somSession);
	
	/**
	 * 社会组织换届负责人备案
	 * @param somSession
	 */
	@Trans
	public void changeRegPeople(SomSession somSession);
	
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
	 * 获取法定代表人姓名
	 * @param taskCode
	 * @return
	 */
	@Trans
	public String  getLegalPeopleName(String taskCode);
	
	/**
	 * 分支代表机构根据taskCode获取法定代表人姓名
	 * @param mainSorgId
	 * @return
	 */
	@Trans
	public String  getBranchChargePeopleName(String taskCode);
	/**
	 * 通过社会组织ID获取法定代表人姓名
	 * @param sorgId
	 * @return
	 */
	@Trans
	public String getLegalPeopleNameBySorgId(String sorgId);
	/**
	 * 通过社会组织ID分支负责人姓名
	 * @param sorgId
	 * @return
	 */
	@Trans
	public String getBranchPeopleNameBySorgId(String sorgId);
	/**
	 * 通过人员Id和社会组织类型查询此人是否已经是该类型下的法定代表人
	 * @param peopleId
	 * @param sorgType
	 * @return 0:否  1：是
	 */
	@Trans
	public String checkLegalPeopleRepeat(String peopleId, String sorgType,String sorgId);
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
	 * 外网用
	 * somSession需填写社会组织编号、业务编号、顺序号
	 * @param somSession
	 */
	@Trans
	public void regPeopleOnline(SomSession somSession);
	/**
	 * 民非外网用
	 * somSession需填写社会组织编号、业务编号、顺序号
	 * @param somSession
	 */
	@Trans
	public void regUngovPeopleOnline(SomSession somSession);
	/**
	 * 根据人员姓名和sorgid查出duty信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleByName(ParameterSet pset);
	/**
	 * 插入一条简历
	 * @param somResume
	 */
	@Trans
	public void insertSomPeopleResume(SomPeopleResume somResume);
	@Trans
	public void deletePeopleResumeByTaskCode(String taskCode);
	
	/**
	 * 换届备案外网申请受理
	 */ 
	@Trans
	public void changeRegPeopleOnline(SomApply somApply, SomSession somSession);
	
	/**
	 * 根据条形码删除负责人备案的一届备案的所有信息
	 * 负责人备案中删除功能用到
	 * @param taskCode
	 */
	@Trans
	public void deleteSessionAllByTaskCode(String taskCode);

}
