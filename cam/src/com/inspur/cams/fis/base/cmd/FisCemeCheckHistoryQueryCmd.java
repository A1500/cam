package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeCheckHistoryDomain;

/**
 * 公墓年检整改历史记录表查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckHistoryQueryCmd extends BaseQueryCommand {

	private IFisCemeCheckHistoryDomain fisCemeCheckHistoryDomain = ScaComponentFactory
			.getService(IFisCemeCheckHistoryDomain.class, "fisCemeCheckHistoryDomain/fisCemeCheckHistoryDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeCheckHistoryDomain.query(pset);
	}

	public DataSet queryOrder() {
		ParameterSet pset = getParameterSet();
		return fisCemeCheckHistoryDomain.queryOrder(pset);
	}
	public DataSet queryByCreateTime() {
		ParameterSet pset = getParameterSet();
		return fisCemeCheckHistoryDomain.queryByCreateTime(pset);
	}	
	
	
}