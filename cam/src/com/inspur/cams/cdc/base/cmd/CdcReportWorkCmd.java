package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcReportWork;
import com.inspur.cams.cdc.base.domain.ICdcReportWorkDomain;

/**
 * 基层民主填报工作信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcReportWorkCmd extends BaseAjaxCommand {

	private ICdcReportWorkDomain cdcReportWorkDomain = ScaComponentFactory
			.getService(ICdcReportWorkDomain.class, "cdcReportWorkDomain/cdcReportWorkDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcReportWork cdcReportWork = (CdcReportWork) record.toBean(CdcReportWork.class);
		cdcReportWorkDomain.insert(cdcReportWork);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcReportWork cdcReportWork = (CdcReportWork) record.toBean(CdcReportWork.class);
		cdcReportWorkDomain.update(cdcReportWork);
	}
	
}