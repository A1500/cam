package com.inspur.cams.sorg.penalty.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.penalty.base.dao.ISomPenaltyApplyDao;
import com.inspur.cams.sorg.penalty.base.domain.ISomPenaltyApplyBaseDomain;

/**
 * 行政执法审批domain
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
public class SomPenaltyApplyBaseDomain implements ISomPenaltyApplyBaseDomain {
	@Reference
	private ISomPenaltyApplyDao somPenaltyApplyDao;


	public DataSet query(ParameterSet pset) {
		return somPenaltyApplyDao.query(pset);
	}

}
