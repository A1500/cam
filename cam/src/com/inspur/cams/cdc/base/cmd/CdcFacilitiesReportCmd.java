package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.cdc.base.data.CdcFacilitiesReport;
import com.inspur.cams.cdc.base.domain.ICdcFacilitiesReportDomain;

/**
 * 社区建设基础设施统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcFacilitiesReportCmd extends BaseAjaxCommand {

	private ICdcFacilitiesReportDomain cdcFacilitiesReportDomain = ScaComponentFactory
			.getService(ICdcFacilitiesReportDomain.class, "cdcFacilitiesReportDomain/cdcFacilitiesReportDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcFacilitiesReport cdcFacilitiesReport = (CdcFacilitiesReport) record.toBean(CdcFacilitiesReport.class);
		cdcFacilitiesReportDomain.insert(cdcFacilitiesReport);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcFacilitiesReport cdcFacilitiesReport = (CdcFacilitiesReport) record.toBean(CdcFacilitiesReport.class);
		cdcFacilitiesReportDomain.update(cdcFacilitiesReport);
	}
	
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcFacilitiesReportDomain.delete(id);
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcFacilitiesReport cdcFacilitiesReport = (CdcFacilitiesReport) record.toBean(CdcFacilitiesReport.class);
		cdcFacilitiesReportDomain.sum(cdcFacilitiesReport);
	}
	
	public void report(){
		String id = (String) getParameter("id");
		cdcFacilitiesReportDomain.report(id);
	}
}