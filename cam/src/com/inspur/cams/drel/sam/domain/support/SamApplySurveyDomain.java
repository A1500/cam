package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamApplySurveyDao;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.domain.ISamApplySurveyDomain;
/**
 * @title 入户调查信息Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamApplySurveyDomain implements ISamApplySurveyDomain {
	@Reference
	private ISamApplySurveyDao samApplySurveyDao;
	
	public void insert(SamApplySurvey samApplySurvey) {
		samApplySurveyDao.insert(samApplySurvey);
	}

	public DataSet query(ParameterSet pset) {
		return samApplySurveyDao.query(pset);
	}

	public void update(SamApplySurvey samApplySurvey) {
		samApplySurveyDao.update(samApplySurvey);
	}	
	
	public void delete(String surveyId){
		samApplySurveyDao.delete(surveyId);
	}
}
