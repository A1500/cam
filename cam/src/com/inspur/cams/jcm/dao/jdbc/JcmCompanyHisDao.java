package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmCompanyHisDao;
import com.inspur.cams.jcm.data.JcmCompanyHis;

/**
 * 单位历史信息dao
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyHisDao extends EntityDao<JcmCompanyHis> implements IJcmCompanyHisDao {
	
	@Override
	public Class<JcmCompanyHis> getEntityClass() {
		return JcmCompanyHis.class;
	}

}