package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleDisability;

/**
 * @title:IBptPeopleDisabilityDao
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public interface IBptPeopleDisabilityDao extends BaseCURD<BptPeopleDisability>{
	public void save(List<BptPeopleDisability> list);
	
	public void batchDeleteByBaseinfoPeople(String[] peopleId);
	
	/**
	 * 查询伤残人员信息及其相应的优抚信息（优抚对象类型）
	 * @param pset
	 * @return
	 */
	public DataSet queryDisabilityBPTPeople(ParameterSet pset);
	
	/**
	 * 查询人员、类别【伤残】、优抚信息-----------或替代queryDisabilityBPTPeople
	 */
	public DataSet queryDisabilityBptPeople(ParameterSet pset);
	
	/**
	 * 查询未提交的伤残人员信息【审批中】
	 */
	public DataSet queryUnCommitDisPeo(ParameterSet pset);
	
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
	
}

