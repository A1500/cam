package com.inspur.comm.cqm.base.cmd;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.domain.ICqmReportDomain;

/**
 * 自定义统计报表查询cmd
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmReportLayeredQueryCmd extends BaseQueryCommand {

	private ICqmReportDomain cqmReportDomain = ScaComponentFactory
			.getService(ICqmReportDomain.class, "cqmReportDomain/cqmReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmReportDomain.query(pset);
		
	}
	
	public DataSet getReportLayeredRow() {
		boolean ifUnder = (Boolean) getParameter("ifUnder");
		String organCode = (String) getParameter("organCode");
		DataSet ds = cqmReportDomain.getReportLayeredRow(organCode,ifUnder);
		return ds;
	}
	
	public DataSet getReportLayeredData() {
		Record useColRecord = (Record) getParameter("useCol");
		CqmUseCol cqmUseCol = (CqmUseCol) useColRecord.toBean(CqmUseCol.class);
		List cqmUseSearchList = (List) getParameter("searchList");
		String organCode = (String) getParameter("organCode");
		DataSet ds = cqmReportDomain.getReportLayeredData(organCode,cqmUseCol, cqmUseSearchList);
		return ds;
	}
}