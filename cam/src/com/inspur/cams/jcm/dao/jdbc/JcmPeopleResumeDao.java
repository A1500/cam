package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmPeopleResumeDao;
import com.inspur.cams.jcm.data.JcmPeopleResume;

/**
 * 人员简历信息(多条记录)dao
 * @author 
 * @date 2014-05-19
 */
public class JcmPeopleResumeDao extends EntityDao<JcmPeopleResume> implements IJcmPeopleResumeDao {
	
	@Override
	public Class<JcmPeopleResume> getEntityClass() {
		return JcmPeopleResume.class;
	}

}