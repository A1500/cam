package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.dao.ISamPeopleTypeDao;
import com.inspur.cams.drel.sam.data.SamPeopleType;
import com.inspur.cams.drel.sam.domain.ISamPeopleTypeDomain;

/**
 * @title:人员类型Domain接口
 * @description:
 * @author: zhangjian
 * @date:2012年5月28日
 * @version:1.0
 */
public class SamPeopleTypeDomain implements ISamPeopleTypeDomain {
	@Reference
	private ISamPeopleTypeDao samPeopleTypeDao;

	/**
	 * 增加
	 * 
	 * @param samPeopleType
	 */
	public void insert(SamPeopleType samPeopleType) {
		samPeopleTypeDao.insert(samPeopleType);
	}

	/**
	 * 查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleTypeDao.query(pset);
	}

	/**
	 * 更新
	 * 
	 * @param samPeopleType
	 */
	public void update(SamPeopleType samPeopleType) {
		samPeopleTypeDao.update(samPeopleType);
	}

	/**
	 * 根据人员id删除
	 * 
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId) {
		samPeopleTypeDao.deleteByPeopleId(peopleId);
	}

}
