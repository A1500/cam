package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmDicDao;
import com.inspur.cams.jcm.data.JcmDic;

/**
 * 字典管理表dao
 * @author 
 * @date 2014-12-15
 */
public class JcmDicDao extends EntityDao<JcmDic> implements IJcmDicDao {
	
	@Override
	public Class<JcmDic> getEntityClass() {
		return JcmDic.class;
	}

}