package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmPeopleExam;

/**
 * 人员培训信息（多条记录过程）domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmPeopleExamDomain {

	/**
	 * 查询 人员培训信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 人员培训信息（多条记录过程）
	 * @param pset
	 * @return
	 */
	public JcmPeopleExam get(String peopleExamId);

	/**
	 * 增加 人员培训信息（多条记录过程）
	 * @param jcmPeopleExam
	 */
	@Trans
	public void insert(JcmPeopleExam jcmPeopleExam);
	
	/**
	 * 修改 人员培训信息（多条记录过程）
	 * @param jcmPeopleExam
	 */
	@Trans
	public void update(JcmPeopleExam jcmPeopleExam);
	
	/**
	 * 删除 人员培训信息（多条记录过程）
	 * @param peopleExamId
	 */
	@Trans
	public void delete(String peopleExamId);

}