package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcNatureInfo;
import com.inspur.cams.cdc.base.data.CdcNatureReport;
import com.inspur.cams.cdc.base.domain.ICdcNatureReportDomain;

/**
 * 基础信息自然状况统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcNatureReportCmd extends BaseAjaxCommand {

	private ICdcNatureReportDomain cdcNatureReportDomain = ScaComponentFactory
			.getService(ICdcNatureReportDomain.class, "cdcNatureReportDomain/cdcNatureReportDomain");
	
	// 增加
	public void insert() {
		Record reportRrecod = (Record) getParameter("reportRrecod");
		CdcNatureReport cdcNatureReport = (CdcNatureReport) reportRrecod.toBean(CdcNatureReport.class);
		Record record = (Record) getParameter("record");
		CdcNatureInfo cdcNatureInfo = (CdcNatureInfo) record.toBean(CdcNatureInfo.class);
		cdcNatureReportDomain.insert(cdcNatureInfo,cdcNatureReport);
	}

	// 修改
	public void update() {
		Record reportRrecod = (Record) getParameter("reportRrecod");
		CdcNatureReport cdcNatureReport = (CdcNatureReport) reportRrecod.toBean(CdcNatureReport.class);
		Record record = (Record) getParameter("record");
		CdcNatureInfo cdcNatureInfo = (CdcNatureInfo) record.toBean(CdcNatureInfo.class);
		cdcNatureReportDomain.update(cdcNatureInfo,cdcNatureReport);
	}
	//上报或驳回等修改
	public void updatereport(){
		Record record = (Record) getParameter("reportRrecod");
		CdcNatureReport cdcNatureReport = (CdcNatureReport) record.toBean(CdcNatureReport.class);
		cdcNatureReportDomain.update(cdcNatureReport);
	}
	
	public void sum(){
		Record record = (Record) getParameter("record");
		CdcNatureReport cdcNatureReport = (CdcNatureReport) record.toBean(CdcNatureReport.class);
		cdcNatureReportDomain.sum(cdcNatureReport);
	}
	
	public void delete(){
		String reportId = (String) getParameter("id");
		cdcNatureReportDomain.delete(reportId);
	}
	
}