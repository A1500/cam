package com.inspur.cams.drel.application.cityLow.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.application.cityLow.dao.ISamLowSupportPeopleDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowSupportPeopleDomain;

/**
 * 低收入家庭赡养、扶养、义务人情况domain
 * @author 
 * @date 2014-03-11
 */
public class SamLowSupportPeopleDomain implements ISamLowSupportPeopleDomain {

	@Reference
	private ISamLowSupportPeopleDao samLowSupportPeopleDao;

	/**
	 * 查询 低收入家庭赡养、扶养、义务人情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samLowSupportPeopleDao.query(pset);
	}

	/**
	 * 获取 低收入家庭赡养、扶养、义务人情况
	 * @param pset
	 * @return
	 */
	public SamLowSupportPeople get(String supportId) {
		return samLowSupportPeopleDao.get(supportId);
	}

	/**
	 * 增加 低收入家庭赡养、扶养、义务人情况
	 * @param samLowSupportPeople
	 */
	public void insert(SamLowSupportPeople samLowSupportPeople) {
		samLowSupportPeopleDao.insert(samLowSupportPeople);
	}
	
	/**
	 * 修改 低收入家庭赡养、扶养、义务人情况
	 * @param samLowSupportPeople
	 */
	public void update(SamLowSupportPeople samLowSupportPeople) {
		samLowSupportPeopleDao.update(samLowSupportPeople);
	}
	
	/**
	 * 删除 低收入家庭赡养、扶养、义务人情况
	 * @param supportId
	 */
	public void delete(String supportId) {
		samLowSupportPeopleDao.delete(supportId);
	}

}