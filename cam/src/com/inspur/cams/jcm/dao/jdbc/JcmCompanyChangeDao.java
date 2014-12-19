package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmCompanyChangeDao;
import com.inspur.cams.jcm.data.JcmCompanyChange;

/**
 * 单位信息调整（多条记录过程）dao
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyChangeDao extends EntityDao<JcmCompanyChange> implements IJcmCompanyChangeDao {
	
	@Override
	public Class<JcmCompanyChange> getEntityClass() {
		return JcmCompanyChange.class;
	}

}