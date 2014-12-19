package com.inspur.cams.sorg.penalty.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.penalty.base.dao.ISomPenaltyDao;
import com.inspur.cams.sorg.penalty.base.data.SomPenalty;
import com.inspur.cams.sorg.penalty.base.domain.ISomPenaltyBaseDomain;

/**
 * 行政执法基本信息domain
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public class SomPenaltyBaseDomain implements ISomPenaltyBaseDomain {
	@Reference
	private ISomPenaltyDao somPenaltyDao;

	public DataSet query(ParameterSet pset) {
		return somPenaltyDao.query(pset);
	}

	public void insert(SomPenalty somPenalty) {
		somPenaltyDao.insert(somPenalty);
	}
	
	public void update(SomPenalty somPenalty) {
		somPenaltyDao.update(somPenalty);
	}
}
