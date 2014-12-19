package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcFinanceInfoDomain;

/**
 * @title:CdcFinanceInfoQueryCommand
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
public class CdcFinanceInfoQueryCmd extends BaseQueryCommand{
	
	private ICdcFinanceInfoDomain cdcFinanceInfoDomain = ScaComponentFactory
	.getService(ICdcFinanceInfoDomain.class, "cdcFinanceInfoDomain/cdcFinanceInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcFinanceInfoDomain.query(pset);
	}
	
	public DataSet queryList(){
		ParameterSet pset = getParameterSet();
		return cdcFinanceInfoDomain.queryList(pset);
	}
	
}
