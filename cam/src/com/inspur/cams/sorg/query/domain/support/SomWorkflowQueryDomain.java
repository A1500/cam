package com.inspur.cams.sorg.query.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.query.dao.ISomWorkflowQueryDao;
import com.inspur.cams.sorg.query.domain.ISomWorkflowQueryDomain;

public class SomWorkflowQueryDomain implements ISomWorkflowQueryDomain{
	@Reference
	private ISomWorkflowQueryDao somWorkflowQueryDao;

	public DataSet queryNum(ParameterSet pset) {
		return somWorkflowQueryDao.queryNum(pset);
	}

	public DataSet queryList(ParameterSet pset) {
		return somWorkflowQueryDao.queryList(pset);
	}
	
	public DataSet queryDetail(ParameterSet pset) {
		return somWorkflowQueryDao.queryDetail(pset);
	}
}
