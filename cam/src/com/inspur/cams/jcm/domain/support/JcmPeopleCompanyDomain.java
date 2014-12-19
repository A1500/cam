package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmPeopleCompanyDao;
import com.inspur.cams.jcm.data.JcmPeopleCompany;
import com.inspur.cams.jcm.domain.IJcmPeopleCompanyDomain;

/**
 * 人员工作单位信息（多条记录过程）domain
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleCompanyDomain implements IJcmPeopleCompanyDomain {

	@Reference
	private IJcmPeopleCompanyDao jcmPeopleCompanyDao;

	/**
	 * 查询 人员工作单位信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmPeopleCompanyDao.query(pset);
	}

	/**
	 * 获取 人员工作单位信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public JcmPeopleCompany get(String peopleCompanyId) {
		return jcmPeopleCompanyDao.get(peopleCompanyId);
	}

	/**
	 * 增加 人员工作单位信息（多条记录过程）
	 * @param jcmPeopleCompany
	 */
	public void insert(JcmPeopleCompany jcmPeopleCompany) {
		jcmPeopleCompanyDao.insert(jcmPeopleCompany);
	}
	
	/**
	 * 修改 人员工作单位信息（多条记录过程）
	 * @param jcmPeopleCompany
	 */
	public void update(JcmPeopleCompany jcmPeopleCompany) {
		jcmPeopleCompanyDao.update(jcmPeopleCompany);
	}
	
	/**
	 * 删除 人员工作单位信息（多条记录过程）
	 * @param peopleCompanyId
	 */
	public void delete(String peopleCompanyId) {
		jcmPeopleCompanyDao.delete(peopleCompanyId);
	}

}