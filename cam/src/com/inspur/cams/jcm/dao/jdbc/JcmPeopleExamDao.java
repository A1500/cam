package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IJcmPeopleExamDao;
import com.inspur.cams.jcm.data.JcmPeopleExam;

/**
 * 人员培训信息（多条记录过程）dao
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleExamDao extends EntityDao<JcmPeopleExam> implements IJcmPeopleExamDao {
	
	@Override
	public Class<JcmPeopleExam> getEntityClass() {
		return JcmPeopleExam.class;
	}

}