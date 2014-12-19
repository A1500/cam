package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmPeopleInfoDao;
import com.inspur.cams.jcm.data.JcmPeopleInfo;

/**
 * 人员基本信息dao
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleInfoDao extends EntityDao<JcmPeopleInfo> implements IJcmPeopleInfoDao {
	
	@Override
	public Class<JcmPeopleInfo> getEntityClass() {
		return JcmPeopleInfo.class;
	}

}