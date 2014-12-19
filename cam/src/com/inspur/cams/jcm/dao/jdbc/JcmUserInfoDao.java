package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmUserInfoDao;
import com.inspur.cams.jcm.data.JcmUserInfo;

/**
 * 用户表dao
 * @author 
 * @date 2014-05-16
 */
public class JcmUserInfoDao extends EntityDao<JcmUserInfo> implements IJcmUserInfoDao {
	
	@Override
	public Class<JcmUserInfo> getEntityClass() {
		return JcmUserInfo.class;
	}

}