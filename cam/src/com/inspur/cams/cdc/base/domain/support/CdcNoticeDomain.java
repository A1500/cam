package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcNoticeDao;
import com.inspur.cams.cdc.base.domain.ICdcNoticeDomain;

public class CdcNoticeDomain implements ICdcNoticeDomain {
	
	@Reference
	private ICdcNoticeDao cdcNoticeDao;

	public DataSet getUnReport(ParameterSet pset) {
		return cdcNoticeDao.getUnReport(pset);
	}

}
