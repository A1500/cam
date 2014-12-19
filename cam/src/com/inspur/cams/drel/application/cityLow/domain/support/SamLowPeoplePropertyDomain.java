package com.inspur.cams.drel.application.cityLow.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.application.cityLow.dao.ISamLowPeoplePropertyDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleProperty;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeoplePropertyDomain;

/**
 * 低收入家庭成员财产表domain
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeoplePropertyDomain implements ISamLowPeoplePropertyDomain {

	@Reference
	private ISamLowPeoplePropertyDao samLowPeoplePropertyDao;

	/**
	 * 查询 低收入家庭成员财产表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samLowPeoplePropertyDao.query(pset);
	}

	/**
	 * 获取 低收入家庭成员财产表
	 * @param pset
	 * @return
	 */
	public SamLowPeopleProperty get(String propertyId) {
		return samLowPeoplePropertyDao.get(propertyId);
	}

	/**
	 * 增加 低收入家庭成员财产表
	 * @param samLowPeopleProperty
	 */
	public void insert(SamLowPeopleProperty samLowPeopleProperty) {
		samLowPeoplePropertyDao.insert(samLowPeopleProperty);
	}
	
	/**
	 * 修改 低收入家庭成员财产表
	 * @param samLowPeopleProperty
	 */
	public void update(SamLowPeopleProperty samLowPeopleProperty) {
		samLowPeoplePropertyDao.update(samLowPeopleProperty);
	}
	
	/**
	 * 删除 低收入家庭成员财产表
	 * @param propertyId
	 */
	public void delete(String propertyId) {
		samLowPeoplePropertyDao.delete(propertyId);
	}

}