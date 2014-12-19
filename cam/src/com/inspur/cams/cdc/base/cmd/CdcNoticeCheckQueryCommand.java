package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcNoticeCheckDomain;

/**
 * @title:CdcNoticeCheckQueryCommand
 * @description:
 * @author:
 * @since:2012-03-29
 * @version:1.0
*/
public class CdcNoticeCheckQueryCommand extends BaseQueryCommand{
	private ICdcNoticeCheckDomain service = ScaComponentFactory
	.getService(ICdcNoticeCheckDomain.class, "cdcNoticeCheckDomain/cdcNoticeCheckDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.query(pset);
		return ds;
	}
}
