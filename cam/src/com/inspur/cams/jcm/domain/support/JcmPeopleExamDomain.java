package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmPeopleExamDao;
import com.inspur.cams.jcm.data.JcmPeopleExam;
import com.inspur.cams.jcm.domain.IJcmPeopleExamDomain;

/**
 * 人员培训信息（多条记录过程）domain
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleExamDomain implements IJcmPeopleExamDomain {

	@Reference
	private IJcmPeopleExamDao jcmPeopleExamDao;

	/**
	 * 查询 人员培训信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmPeopleExamDao.query(pset);
	}

	/**
	 * 获取 人员培训信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public JcmPeopleExam get(String peopleExamId) {
		return jcmPeopleExamDao.get(peopleExamId);
	}

	/**
	 * 增加 人员培训信息（多条记录过程）
	 * @param jcmPeopleExam
	 */
	public void insert(JcmPeopleExam jcmPeopleExam) {
		jcmPeopleExamDao.insert(jcmPeopleExam);
	}
	
	/**
	 * 修改 人员培训信息（多条记录过程）
	 * @param jcmPeopleExam
	 */
	public void update(JcmPeopleExam jcmPeopleExam) {
		jcmPeopleExamDao.update(jcmPeopleExam);
	}
	
	/**
	 * 删除 人员培训信息（多条记录过程）
	 * @param peopleExamId
	 */
	public void delete(String peopleExamId) {
		jcmPeopleExamDao.delete(peopleExamId);
	}

}