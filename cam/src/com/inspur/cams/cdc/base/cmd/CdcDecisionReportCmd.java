package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcDecisionInfo;
import com.inspur.cams.cdc.base.data.CdcDecisionReport;
import com.inspur.cams.cdc.base.domain.ICdcDecisionReportDomain;

/**
 * 民主决策
 * @author shgtch
 * @date 2012-12-12
 */
public class CdcDecisionReportCmd extends BaseAjaxCommand {

	private ICdcDecisionReportDomain cdcDecisionReportDomain = ScaComponentFactory
			.getService(ICdcDecisionReportDomain.class, "cdcDecisionReportDomain/cdcDecisionReportDomain");
	
	// 增加
	public void insert() {
		cdcDecisionReportDomain.insert(getDecisionReport());
	}

	// 修改
	public void update() {
		cdcDecisionReportDomain.update(getDecisionReport());
	}
	//上报
	public void report(){
		Record record = (Record) getParameter("record");
		CdcDecisionReport cdcDecisionReport = (CdcDecisionReport) record.toBean(CdcDecisionReport.class);
		cdcDecisionReportDomain.updateFlag(cdcDecisionReport);
	}
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcDecisionReportDomain.delete(id);
	}
	
	//组装cdcPeopleInfoList
	public CdcDecisionReport getDecisionReport(){
		Record record = (Record) getParameter("record");
		CdcDecisionReport cdcDecisionReport = (CdcDecisionReport) record.toBean(CdcDecisionReport.class);
		
		Record[] cdcDecisionInfoRecord = (Record[]) getParameter("cdcDecisionInfoRecord");
		List<CdcDecisionInfo> cdcDecisionInfoList = new ArrayList<CdcDecisionInfo>();
		if (cdcDecisionInfoRecord != null) {
			for (int i = 0; i < cdcDecisionInfoRecord.length; i++) {
				CdcDecisionInfo cdcDecisionInfo = (CdcDecisionInfo) cdcDecisionInfoRecord[i].toBean(CdcDecisionInfo.class);
				cdcDecisionInfoList.add(cdcDecisionInfo);
			}
		}
		cdcDecisionReport.setCdcDecisionInfoList(cdcDecisionInfoList);
		return cdcDecisionReport;
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcDecisionReport cdcDecisionReport = (CdcDecisionReport) record.toBean(CdcDecisionReport.class);
		cdcDecisionReportDomain.sum(cdcDecisionReport);
	}
}