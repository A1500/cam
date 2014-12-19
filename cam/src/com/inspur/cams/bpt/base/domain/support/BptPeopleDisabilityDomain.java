package com.inspur.cams.bpt.base.domain.support;

import java.util.*;

import org.loushang.next.data.*;
import org.osoa.sca.annotations.*;
import com.inspur.cams.bpt.base.dao.IBptPeopleDisabilityDao;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;

/**
 * @title:
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public class BptPeopleDisabilityDomain implements IBptPeopleDisabilityDomain{
	@Reference
	private IBptPeopleDisabilityDao bptPeopleDisabilityDao;
	
	
	public void setBptPeopleDisabilityDao(IBptPeopleDisabilityDao bptpeopledisabilityDao) {
		this.bptPeopleDisabilityDao = bptpeopledisabilityDao;
	}


	public void saveBptPeopleDisability(List<BptPeopleDisability> list) {
		if (list != null && !list.isEmpty()) {
			this.bptPeopleDisabilityDao.save(list);
		}
	}
	
	/**
	 * 查询人员伤残信息
	 */
	public DataSet queryBptPeopleDisability(ParameterSet pset) {
		return bptPeopleDisabilityDao.query(pset);
	}
	
	/**
	 * 保存人员伤残信息
	 */
	
	public void saveBptPeopleDisabilityList(BptPeopleDisability bptpeopledisability) {
		List<BptPeopleDisability> bptpeopledisabilityList = new ArrayList<BptPeopleDisability>();
		bptpeopledisabilityList.add(bptpeopledisability);
		this.bptPeopleDisabilityDao.save(bptpeopledisabilityList);
	}
	/**
	 * 插入人员伤残信息
	 */
	
	public void insertBptPeopleDisability(BptPeopleDisability bptpeopledisability) {
		this.bptPeopleDisabilityDao.insert(bptpeopledisability);
	}
	/**
	 * 查询伤残人员信息及其相应的优抚信息（优抚对象类型）
	 */
	public DataSet queryDisabilityBPTPeople(ParameterSet pset){
		return bptPeopleDisabilityDao.queryDisabilityBPTPeople(pset);
	}
	
	/**
	 * 查询人员、类别【伤残】、优抚信息-----------或替代queryDisabilityBPTPeople
	 */
	public DataSet queryDisabilityBptPeople(ParameterSet pset){
		return bptPeopleDisabilityDao.queryDisabilityBptPeople(pset);
	}
	
	/**
	 * 查询未提交的伤残优抚对象信息
	 */
	public DataSet queryUnCommitDisPeo(ParameterSet pset){
		return bptPeopleDisabilityDao.queryUnCommitDisPeo(pset);
	}
	
	/**
	 * 更新人员伤残信息
	 */
	public void updatePeopleDisability(BptPeopleDisability bptpeopledisability){
		bptPeopleDisabilityDao.update(bptpeopledisability);
	}
	
	/**
	 * 查询评定、调整伤残等级审批表[表头信息]
	 */
	public DataSet queryDisabilityApproveHeader(String peopleId){
		 return bptPeopleDisabilityDao.queryDisabilityApproveHeader(peopleId);
	}
	
	/**
	 * 根据身份证查询伤残人员信息
	 * @param pset
	 * @return
	 */
	public List queryDisabilityByIdCard(ParameterSet pset) {
		return bptPeopleDisabilityDao.queryDisabilityByIdCard(pset);
	}
}