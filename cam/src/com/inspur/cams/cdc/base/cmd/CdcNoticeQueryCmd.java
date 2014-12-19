package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcNoticeDomain;

public class CdcNoticeQueryCmd extends BaseQueryCommand {
	private ICdcNoticeDomain service = ScaComponentFactory
	.getService(ICdcNoticeDomain.class, "cdcNoticeDomain/cdcNoticeDomain");
	
	public DataSet query(){
		ParameterSet pset = getParameterSet();
		return service.getUnReport(pset);
	}
}
