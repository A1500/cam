package com.inspur.comm.cqm.base.cmd;

import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.permit.bean.RoleView;
import org.loushang.bsp.share.permit.security.provider.SecurityProviderImp;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.domain.ICqmReportDomain;

/**
 * 自定义统计报表查询cmd
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmReportQueryCmd extends BaseQueryCommand {

	private ICqmReportDomain cqmReportDomain = ScaComponentFactory
			.getService(ICqmReportDomain.class, "cqmReportDomain/cqmReportDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cqmReportDomain.query(pset);
		
	}
	public DataSet queryReport(){
		ParameterSet pset = getParameterSet();
		SecurityProviderImp securityProvider = new SecurityProviderImp();
		RoleView[] roleViews = securityProvider.getAssignedRole(GetBspInfo.getBspInfo().getUserId());
		pset.setParameter("roles",roleViews);
		return cqmReportDomain.queryReport(pset);
	}

	public DataSet getReportRow() {
		Record rowIndexRecord = (Record) getParameter("rowIndex");
		String organCode = (String) getParameter("organCode");
		CqmIndex cqmIndex = (CqmIndex) rowIndexRecord.toBean(CqmIndex.class);
		return cqmReportDomain.getReportRow(organCode,cqmIndex);
	}
	
	public DataSet getReportData() {
		Record useColRecord = (Record) getParameter("useCol");
		CqmUseCol cqmUseCol = (CqmUseCol) useColRecord.toBean(CqmUseCol.class);
		Record rowIndexRecord = (Record) getParameter("rowIndex");
		CqmIndex cqmIndex = (CqmIndex) rowIndexRecord.toBean(CqmIndex.class);
		List cqmUseSearchList = (List) getParameter("searchList");
		String organCode = (String) getParameter("organCode");
		return cqmReportDomain.getReportData(organCode,cqmUseCol, cqmIndex, cqmUseSearchList);
	}
	
	public DataSet getReportSum() {
		Record useColRecord = (Record) getParameter("useCol");
		CqmUseCol cqmUseCol = (CqmUseCol) useColRecord.toBean(CqmUseCol.class);
		Record rowIndexRecord = (Record) getParameter("rowIndex");
		CqmIndex cqmIndex = (CqmIndex) rowIndexRecord.toBean(CqmIndex.class);
		List cqmUseSearchList = (List) getParameter("searchList");
		String organCode = (String) getParameter("organCode");
		return cqmReportDomain.getReportSum(organCode,cqmUseCol, cqmIndex, cqmUseSearchList);
	}
	
}