package com.inspur.cams.welfare.prosthesis.apply.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.welfare.base.domain.IWealWorkerDomain;
import com.inspur.cams.welfare.prosthesis.apply.domain.IFitWorkerQueryDomain;

public class FitWorkerQueryDomain implements IFitWorkerQueryDomain{
	
	@Reference
	private IWealWorkerDomain wealWorkerDomain;
	public DataSet queryFitWorkerSum(ParameterSet pset) {
		// TODO Auto-generated method stub
		return wealWorkerDomain.queryFitWorkerSum(pset);
	}

}
