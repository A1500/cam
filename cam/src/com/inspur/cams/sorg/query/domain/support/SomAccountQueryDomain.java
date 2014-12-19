package com.inspur.cams.sorg.query.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.query.dao.ISomAccountQueryDao;
import com.inspur.cams.sorg.query.domain.ISomAccountQueryDomain;

public class SomAccountQueryDomain implements ISomAccountQueryDomain {
	@Reference
	private ISomAccountQueryDao somAccountQueryDao;

	public DataSet queryGroupAccount(ParameterSet pset) {
		return somAccountQueryDao.queryGroupAccount(pset);
	}

	public DataSet queryUngovAccount(ParameterSet pset) {
		return somAccountQueryDao.queryUngovAccount(pset);
	}

	public DataSet queryFundAccount(ParameterSet pset) {
		return somAccountQueryDao.queryFundAccount(pset);
	}
}
