package com.inspur.cams.drel.surey.assistance.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.surey.assistance.dao.ISamSureyWfAssistanceHisDao;
import com.inspur.cams.drel.surey.assistance.domain.ISamSureyWfAssistanceHisDomain;

public class SamSureyWfAssistanceHisDomain implements
		ISamSureyWfAssistanceHisDomain {
	@Reference
	ISamSureyWfAssistanceHisDao samSureyWfAssistanceHisDao;

	public DataSet query(ParameterSet pset) {

		return samSureyWfAssistanceHisDao.query(pset);
	}

	public DataSet queryByFlowId(ParameterSet pset) {
		return samSureyWfAssistanceHisDao.queryByFlowId(pset);
	}
}
