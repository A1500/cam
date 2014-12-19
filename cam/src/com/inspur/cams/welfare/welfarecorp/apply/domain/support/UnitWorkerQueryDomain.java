package com.inspur.cams.welfare.welfarecorp.apply.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.welfare.base.domain.IWealWorkerDomain;
import com.inspur.cams.welfare.welfarecorp.apply.domain.IUnitWorkerQueryDomain;

/**
 * 社会福利企业资格认定
 * 
 * @author liuxin
 * @date 2013-06-08
 */
public class UnitWorkerQueryDomain implements IUnitWorkerQueryDomain {

	@Reference
	private IWealWorkerDomain wealWorkerDomain;

	public DataSet queryUnitWorkerSum(ParameterSet pset) {
		return wealWorkerDomain.queryUnitWorkerSum(pset);
	}

	public DataSet queryUnitWorkerDisability(ParameterSet pset) {
		return wealWorkerDomain.queryUnitWorkerDisability(pset);
	}

}
