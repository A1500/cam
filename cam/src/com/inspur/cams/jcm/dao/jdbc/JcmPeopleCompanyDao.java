package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmPeopleCompanyDao;
import com.inspur.cams.jcm.data.JcmPeopleCompany;

/**
 * 人员工作单位信息（多条记录过程）dao
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleCompanyDao extends EntityDao<JcmPeopleCompany> implements IJcmPeopleCompanyDao {
	
	@Override
	public Class<JcmPeopleCompany> getEntityClass() {
		return JcmPeopleCompany.class;
	}

}