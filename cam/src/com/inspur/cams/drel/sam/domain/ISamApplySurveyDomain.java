package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
/**
 * @title 入户调查信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamApplySurveyDomain {
	/**
	 * 查询入户调查
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加入户调查
	 * @param samFamilyTreatment
	 */
	@Trans
	public void insert(SamApplySurvey samApplySurvey);
	
	/**
	 * 更新入户调查
	 * @param samFamilyTreatment
	 */
	@Trans
	public void update(SamApplySurvey samApplySurvey);
	
	/**
	 * 删除入户调查
	 */
	@Trans
	public void delete(String surveyId);
}
