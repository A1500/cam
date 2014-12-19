package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcTenementInfoDomain;

/**
 * @title:CdcTenementInfoQueryCommand
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
public class CdcTenementInfoQueryCmd extends BaseQueryCommand{
	
	private ICdcTenementInfoDomain cdcTenementInfoDomain = ScaComponentFactory
	.getService(ICdcTenementInfoDomain.class, "cdcTenementInfoDomain/cdcTenementInfoDomain");
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		return cdcTenementInfoDomain.query(pset);
	}
}
