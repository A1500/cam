package com.inspur.cams.prs.prsproblemhistory.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.prs.prsproblemhistory.dao.IPrsProblemHistoryDao;
import com.inspur.cams.prs.prsproblemhistory.dao.PrsProblemHistory;

public class PrsProblemHistoryDomain implements IPrsProblemHistoryDomain{
	@Reference
	private IPrsProblemHistoryDao prsProblemHistoryDao;

	public void insert(PrsProblemHistory bean) {
		prsProblemHistoryDao.insert(bean);
	}

	public DataSet query(ParameterSet pset) {
		return prsProblemHistoryDao.query(pset);
	}

	public void update(PrsProblemHistory bean) {
		prsProblemHistoryDao.update(bean);
	}
	
	
}
