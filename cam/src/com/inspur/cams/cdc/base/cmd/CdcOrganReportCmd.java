package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcOrganInfo;
import com.inspur.cams.cdc.base.data.CdcOrganReport;
import com.inspur.cams.cdc.base.domain.ICdcOrganReportDomain;

/**
 * 基础信息社区单位组织统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcOrganReportCmd extends BaseAjaxCommand {

	private ICdcOrganReportDomain cdcOrganReportDomain = ScaComponentFactory
			.getService(ICdcOrganReportDomain.class, "cdcOrganReportDomain/cdcOrganReportDomain");
	
	// 增加
	public void insert() {
		cdcOrganReportDomain.insert(getCdcOrganReport());
	}

	// 修改
	public void update() {
		cdcOrganReportDomain.update(getCdcOrganReport());
	}

	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcOrganReportDomain.delete(id);
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcOrganReport cdcOrganReport = (CdcOrganReport) record.toBean(CdcOrganReport.class);
		cdcOrganReportDomain.sum(cdcOrganReport);
	}
	
	// 获取前台数据并组装
	private CdcOrganReport getCdcOrganReport() {
		Record record = (Record) getParameter("record");
		CdcOrganReport cdcOrganReport = (CdcOrganReport) record.toBean(CdcOrganReport.class);
		
		List<CdcOrganInfo> cdcOrganInfoList = new ArrayList<CdcOrganInfo>();
		Record[] cdcOrganInfoRecord = (Record[]) getParameter("cdcOrganInfoRecord");
		if (cdcOrganInfoRecord != null) {
			for (int i = 0; i < cdcOrganInfoRecord.length; i++) {
				CdcOrganInfo cdcOrganInfo = (CdcOrganInfo) cdcOrganInfoRecord[i].toBean(CdcOrganInfo.class);
				cdcOrganInfoList.add(cdcOrganInfo);
			}
		}
		cdcOrganReport.setCdcOrganInfoList(cdcOrganInfoList);
		return cdcOrganReport;
	}
	public  void report(){
		String id = (String) getParameter("id");
		cdcOrganReportDomain.report(id);
	}
}