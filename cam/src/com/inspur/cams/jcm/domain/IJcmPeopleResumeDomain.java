package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmPeopleResume;

/**
 * 人员简历信息(多条记录)domain
 * @author 
 * @date 2014-05-19
 */
public interface IJcmPeopleResumeDomain {

	/**
	 * 查询 人员简历信息(多条记录)
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 人员简历信息(多条记录)
	 * @param pset
	 * @return
	 */
	public JcmPeopleResume get(String resumeId);

	/**
	 * 增加 人员简历信息(多条记录)
	 * @param jcmPeopleResume
	 */
	@Trans
	public void insert(JcmPeopleResume jcmPeopleResume);
	
	/**
	 * 修改 人员简历信息(多条记录)
	 * @param jcmPeopleResume
	 */
	@Trans
	public void update(JcmPeopleResume jcmPeopleResume);
	
	/**
	 * 删除 人员简历信息(多条记录)
	 * @param resumeId
	 */
	@Trans
	public void delete(String resumeId);

}