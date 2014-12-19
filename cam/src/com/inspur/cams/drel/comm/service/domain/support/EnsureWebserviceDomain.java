package com.inspur.cams.drel.comm.service.domain.support;

import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.comm.service.dao.IEnsureWebserviceDao;
import com.inspur.cams.drel.comm.service.domain.IEnsureWebserviceDomain;


public class EnsureWebserviceDomain implements IEnsureWebserviceDomain{
	
	@Reference
	private IEnsureWebserviceDao ensureWebserviceDao ;

	public String queryExport(ParameterSet pset) {
		// TODO 自动生成的方法存根
		return ensureWebserviceDao.queryExport(pset);
	}
	
}