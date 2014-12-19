package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmPeopleCompany;

/**
 * 人员工作单位信息（多条记录过程）domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmPeopleCompanyDomain {

	/**
	 * 查询 人员工作单位信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 人员工作单位信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public JcmPeopleCompany get(String peopleCompanyId);

	/**
	 * 增加 人员工作单位信息（多条记录过程）
	 * @param jcmPeopleCompany
	 */
	@Trans
	public void insert(JcmPeopleCompany jcmPeopleCompany);
	
	/**
	 * 修改 人员工作单位信息（多条记录过程）
	 * @param jcmPeopleCompany
	 */
	@Trans
	public void update(JcmPeopleCompany jcmPeopleCompany);
	
	/**
	 * 删除 人员工作单位信息（多条记录过程）
	 * @param peopleCompanyId
	 */
	@Trans
	public void delete(String peopleCompanyId);

}