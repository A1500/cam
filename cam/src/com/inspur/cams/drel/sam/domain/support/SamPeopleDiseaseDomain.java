package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.dao.ISamPeopleDiseaseDao;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.domain.ISamPeopleDiseaseDomain;
/**
 * @title:患病Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamPeopleDiseaseDomain implements ISamPeopleDiseaseDomain {
	@Reference
	private ISamPeopleDiseaseDao samPeopleDiseaseDao;

	/**
	 * 增加患病
	 * @param samPeopleDisease
	 */
	public void insert(SamPeopleDisease samPeopleDisease) {
		samPeopleDiseaseDao.insert(samPeopleDisease);
	}
	/**
	 * 查询患病
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleDiseaseDao.query(pset);
	}

	/**
	 * 更新患病
	 * @param samPeopleDisease
	 */
	public void update(SamPeopleDisease samPeopleDisease) {
		samPeopleDiseaseDao.update(samPeopleDisease);
	}
	
	/**
	 * 删除患病
	 * @param peopleId
	 */
	public void delete(String peopleId){
		samPeopleDiseaseDao.delete(peopleId);
	}
}
