package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcNoticeCheck;


public interface ICdcNoticeCheckDomain {

	DataSet query(ParameterSet pset);
	@Trans
	void insert(CdcNoticeCheck cdcNoticeCheck);
	
}
