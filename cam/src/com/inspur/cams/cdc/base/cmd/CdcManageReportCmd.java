package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcManageInfo;
import com.inspur.cams.cdc.base.data.CdcManageReport;
import com.inspur.cams.cdc.base.domain.ICdcManageReportDomain;

/**
 * 基层民主民主管理统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcManageReportCmd extends BaseAjaxCommand {

	private ICdcManageReportDomain cdcManageReportDomain = ScaComponentFactory
			.getService(ICdcManageReportDomain.class, "cdcManageReportDomain/cdcManageReportDomain");
	
	// 增加
	public void insert() {
		Record reportRrecod = (Record) getParameter("reportRrecod");
		CdcManageReport cdcManageReport = (CdcManageReport) reportRrecod.toBean(CdcManageReport.class);
		Record record = (Record) getParameter("record");
		CdcManageInfo cdcManageInfo = (CdcManageInfo) record.toBean(CdcManageInfo.class);
		cdcManageReportDomain.insert(cdcManageInfo,cdcManageReport);
	}

	// 修改
	public void update() {
		Record reportRrecod = (Record) getParameter("reportRrecod");
		CdcManageReport cdcManageReport = (CdcManageReport) reportRrecod.toBean(CdcManageReport.class);
		Record record = (Record) getParameter("record");
		CdcManageInfo cdcManageInfo = (CdcManageInfo) record.toBean(CdcManageInfo.class);
		cdcManageReportDomain.update(cdcManageInfo,cdcManageReport);
	}
	//上报
	public void updatereport() {
		Record reportRrecod = (Record) getParameter("record");
		CdcManageReport cdcManageReport = (CdcManageReport) reportRrecod.toBean(CdcManageReport.class);
		cdcManageReportDomain.update(cdcManageReport);
	}
	public void sum(){
		Record record = (Record) getParameter("record");
		CdcManageReport cdcManageReport = (CdcManageReport) record.toBean(CdcManageReport.class);
		cdcManageReportDomain.sum(cdcManageReport);
		
	}
	
	public void delete(){
		String reportId = (String) getParameter("id");
		cdcManageReportDomain.delete(reportId);
	}
	
}