package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcNoticeCheckDao;
import com.inspur.cams.cdc.base.data.CdcNoticeCheck;
import com.inspur.cams.cdc.base.domain.ICdcNoticeCheckDomain;
import com.inspur.cams.comm.util.IdHelp;

public class CdcNoticeCheckDomain implements ICdcNoticeCheckDomain {
	@Reference
	private ICdcNoticeCheckDao cdcNoticeCheckDao;

	public DataSet query(ParameterSet pset) {
		return cdcNoticeCheckDao.query(pset);
	}

	public void insert(CdcNoticeCheck cdcNoticeCheck) {
		cdcNoticeCheck.setCheckId(cdcNoticeCheck.getOrganCode()+IdHelp.getUUID32());
		cdcNoticeCheckDao.insert(cdcNoticeCheck);
	}

	
}
