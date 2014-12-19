package com.inspur.cams.drel.surey.comm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfHisDao;
import com.inspur.cams.drel.surey.comm.domain.ISamSureyWfHisDomain;

public class SamSureyWfHisDomain implements ISamSureyWfHisDomain {
	@Reference
	ISamSureyWfHisDao samSureyWfHisDao;
	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samSureyWfHisDao.query(pset);
	}

}
