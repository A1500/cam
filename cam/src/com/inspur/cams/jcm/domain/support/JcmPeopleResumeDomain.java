package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmPeopleResumeDao;
import com.inspur.cams.jcm.data.JcmPeopleResume;
import com.inspur.cams.jcm.domain.IJcmPeopleResumeDomain;

/**
 * 人员简历信息(多条记录)domain
 * @author 
 * @date 2014-05-19
 */
public class JcmPeopleResumeDomain implements IJcmPeopleResumeDomain {

	@Reference
	private IJcmPeopleResumeDao jcmPeopleResumeDao;

	/**
	 * 查询 人员简历信息(多条记录)
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmPeopleResumeDao.query(pset);
	}

	/**
	 * 获取 人员简历信息(多条记录)
	 * @param pset
	 * @return
	 */
	public JcmPeopleResume get(String resumeId) {
		return jcmPeopleResumeDao.get(resumeId);
	}

	/**
	 * 增加 人员简历信息(多条记录)
	 * @param jcmPeopleResume
	 */
	public void insert(JcmPeopleResume jcmPeopleResume) {
		jcmPeopleResumeDao.insert(jcmPeopleResume);
	}
	
	/**
	 * 修改 人员简历信息(多条记录)
	 * @param jcmPeopleResume
	 */
	public void update(JcmPeopleResume jcmPeopleResume) {
		jcmPeopleResumeDao.update(jcmPeopleResume);
	}
	
	/**
	 * 删除 人员简历信息(多条记录)
	 * @param resumeId
	 */
	public void delete(String resumeId) {
		jcmPeopleResumeDao.delete(resumeId);
	}

}