package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcConstructInfo;
import com.inspur.cams.cdc.base.data.CdcConstructReport;
import com.inspur.cams.cdc.base.domain.ICdcConstructReportDomain;

/**
 * 基础信息农村社区规划统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcConstructReportCmd extends BaseAjaxCommand {

	private ICdcConstructReportDomain cdcConstructReportDomain = ScaComponentFactory
			.getService(ICdcConstructReportDomain.class, "cdcConstructReportDomain/cdcConstructReportDomain");
	
	// 增加
	public void insert() {
		Record reportRrecod = (Record) getParameter("reportRrecod");
		CdcConstructReport cdcConstructReport = (CdcConstructReport) reportRrecod.toBean(CdcConstructReport.class);
		Record record = (Record) getParameter("record");
		CdcConstructInfo cdcConstructinfo = (CdcConstructInfo) record.toBean(CdcConstructInfo.class);
		cdcConstructReportDomain.insert(cdcConstructReport,cdcConstructinfo);
	}

	// 修改
	public void update() {
		Record reportRrecod = (Record) getParameter("reportRrecod");
		CdcConstructReport cdcConstructReport = (CdcConstructReport) reportRrecod.toBean(CdcConstructReport.class);
		Record record = (Record) getParameter("record");
		CdcConstructInfo cdcConstructinfo = (CdcConstructInfo) record.toBean(CdcConstructInfo.class);
		cdcConstructReportDomain.update(cdcConstructReport,cdcConstructinfo);
	}
	
	public void updatereport(){
		Record reportRrecod = (Record) getParameter("record");
		CdcConstructReport cdcConstructReport = (CdcConstructReport) reportRrecod.toBean(CdcConstructReport.class);
		cdcConstructReportDomain.update(cdcConstructReport);
	}
	
	public void sum(){
		Record reportRrecod = (Record) getParameter("record");
		CdcConstructReport cdcConstructReport = (CdcConstructReport) reportRrecod.toBean(CdcConstructReport.class);
		cdcConstructReportDomain.sum(cdcConstructReport);
	}
	
	public void delete(){
		String id = (String) getParameter("id");
		cdcConstructReportDomain.delete(id);
	}
}