package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.dao.ISamPeopleDisabilityDao;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.domain.ISamPeopleDisabilityDomain;
/**
 * @title:残疾Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamPeopleDisabilityDomain implements ISamPeopleDisabilityDomain {
	@Reference
	private ISamPeopleDisabilityDao samPeopleDisabilityDao;

	/**
	 * 增加残疾
	 * @param samPeopleDisability
	 */
	public void insert(SamPeopleDisability samPeopleDisability) {
		samPeopleDisabilityDao.insert(samPeopleDisability);
	}
	/**
	 * 查询残疾
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleDisabilityDao.query(pset);
	}

	/**
	 * 更新残疾
	 * @param samPeopleDisability
	 */
	public void update(SamPeopleDisability samPeopleDisability) {
		samPeopleDisabilityDao.update(samPeopleDisability);
	}

	/**
	 * 删除残疾
	 * @param peopleId
	 */
	public void delete(String peopleId){
		samPeopleDisabilityDao.delete(peopleId);
	}
}
