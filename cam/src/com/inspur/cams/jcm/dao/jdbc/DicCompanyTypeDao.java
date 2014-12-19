package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IDicCompanyTypeDao;
import com.inspur.cams.jcm.data.DicCompanyType;

/**
 * 单位所属类别dao
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyTypeDao extends EntityDao<DicCompanyType> implements IDicCompanyTypeDao {
	
	@Override
	public Class<DicCompanyType> getEntityClass() {
		return DicCompanyType.class;
	}

}