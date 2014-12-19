package com.inspur.cams.bpt.base.domain;


import java.util.List;
import org.loushang.next.data.*;

import com.inspur.cams.bpt.base.data.BptPeopleDisability;

/**
 * @title:
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public interface IBptPeopleDisabilityDomain {

	public void saveBptPeopleDisability(List<BptPeopleDisability> list);
	
	/**
	 * 查询人员伤残信息
	 * @param pset
	 * @return
	 */
	public DataSet queryBptPeopleDisability(ParameterSet pset);
	
	/**
	 * 查询伤残人员信息及其相应的优抚信息（优抚对象类型）
	 */
	public DataSet queryDisabilityBPTPeople(ParameterSet pset);
	
	/**
	 * 查询人员、类别【伤残】、优抚信息-----------或替代queryDisabilityBPTPeople
	 */
	public DataSet queryDisabilityBptPeople(ParameterSet pset);
	
	/**
	 * /**
	 * 查询未提交的伤残优抚对象信息
	 */
	public DataSet queryUnCommitDisPeo(ParameterSet pset);
	
	/**
	 * 更新人员伤残信息
	 */
	public void updatePeopleDisability(BptPeopleDisability bptpeopledisability);

	public void saveBptPeopleDisabilityList(BptPeopleDisability bptpeopledisability);
	
	/**
	 * 查询评定、调整伤残等级审批表[表头信息]
	 */
	public DataSet queryDisabilityApproveHeader(String peopleId);
	
	/**
	 * 根据身份证查询伤残人员信息
	 * @param pset
	 * @return
	 */
	public List queryDisabilityByIdCard(ParameterSet pset);
	
	
	/**
	 * 插入人员伤残信息
	 */
	
	public void insertBptPeopleDisability(BptPeopleDisability bptpeopledisability);

 }