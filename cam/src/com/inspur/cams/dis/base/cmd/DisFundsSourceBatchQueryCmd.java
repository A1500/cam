package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisFundsSourceBatchDomain;

/**
 * 资金拨付批次表查询cmd
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceBatchQueryCmd extends BaseQueryCommand {

	private IDisFundsSourceBatchDomain disFundsSourceBatchDomain = ScaComponentFactory
			.getService(IDisFundsSourceBatchDomain.class, "disFundsSourceBatchDomain/disFundsSourceBatchDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceBatchDomain.query(pset);
	}
	
}