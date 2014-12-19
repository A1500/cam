package com.inspur.cams.sorg.query.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.query.dao.ISomBranchStaticDao;
import com.inspur.cams.sorg.query.domain.ISomBranchStaticDomain;

public class SomBranchStaticDomain implements ISomBranchStaticDomain {
	@Reference
	private ISomBranchStaticDao somBranchStaticDao;

	public DataSet groupBranchStatic(ParameterSet pset) {
		return somBranchStaticDao.groupBranchStatic(pset);
	}
}
