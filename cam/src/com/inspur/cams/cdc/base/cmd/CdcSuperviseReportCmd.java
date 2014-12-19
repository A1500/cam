package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcSuperviseInfo;
import com.inspur.cams.cdc.base.data.CdcSuperviseReport;
import com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo;
import com.inspur.cams.cdc.base.domain.ICdcSuperviseReportDomain;

/**
 * 基层民主民主监督统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcSuperviseReportCmd extends BaseAjaxCommand {

	private ICdcSuperviseReportDomain cdcSuperviseReportDomain = ScaComponentFactory
			.getService(ICdcSuperviseReportDomain.class, "cdcSuperviseReportDomain/cdcSuperviseReportDomain");
	
	// 增加
	public void insert() {
		cdcSuperviseReportDomain.insert(toBean());
	}
	
	// 修改
	public void update() {
		cdcSuperviseReportDomain.update(toBean());
	}
	
	// 上报
	public void appear() {
		Record record = (Record) getParameter("record");
		CdcSuperviseReport cdcSuperviseReport = (CdcSuperviseReport) record.toBean(CdcSuperviseReport.class);
		cdcSuperviseReportDomain.update(cdcSuperviseReport);
	}
	
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcSuperviseReportDomain.delete(id);
	}
	
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcSuperviseReport cdcSuperviseReport = (CdcSuperviseReport) record.toBean(CdcSuperviseReport.class);
		cdcSuperviseReportDomain.sum(cdcSuperviseReport);
	}
	
	private CdcSuperviseReport toBean() {
		Record record = (Record) getParameter("record");
		CdcSuperviseReport cdcSuperviseReport = (CdcSuperviseReport) record.toBean(CdcSuperviseReport.class);
		
		Record record2 = (Record) getParameter("record2");
		CdcSuperviseInfo cdcSuperviseInfo = (CdcSuperviseInfo) record2.toBean(CdcSuperviseInfo.class);
		cdcSuperviseReport.setCdcSuperviseInfo(cdcSuperviseInfo);
		
		Record[] records = (Record[]) getParameter("list");
		if (records != null) {
			List<CdcSuperviseReviewInfo> list = new ArrayList<CdcSuperviseReviewInfo>();
			for (int i = 0; i < records.length; i++) {
				CdcSuperviseReviewInfo cdcSuperviseReviewInfo = (CdcSuperviseReviewInfo) records[i].toBean(CdcSuperviseReviewInfo.class);
				list.add(cdcSuperviseReviewInfo);
			}
			cdcSuperviseReport.setCdcSuperviseReviewInfoList(list);
		}
		return cdcSuperviseReport;
	}
}