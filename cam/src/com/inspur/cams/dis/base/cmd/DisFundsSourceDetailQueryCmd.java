package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisFundsSourceDetailDomain;

/**
 * 资金拨付明细表查询cmd
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceDetailQueryCmd extends BaseQueryCommand {

	private IDisFundsSourceDetailDomain disFundsSourceDetailDomain = ScaComponentFactory
			.getService(IDisFundsSourceDetailDomain.class, "disFundsSourceDetailDomain/disFundsSourceDetailDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDetailDomain.query(pset);
	}
	
	/**
	 * @Description: 查询物资明细
	 * @author xuexzh
	 */
	public DataSet queryFundsDetails() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDetailDomain.queryFundsDetails(pset);
	}
	
}