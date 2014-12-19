package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcPeopleInfo;
import com.inspur.cams.cdc.base.data.CdcPeopleReport;
import com.inspur.cams.cdc.base.domain.ICdcPeopleReportDomain;


/**
 * 基础信息两委成员与工作者统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcPeopleReportCmd extends BaseAjaxCommand {

	private ICdcPeopleReportDomain cdcPeopleReportDomain = ScaComponentFactory
			.getService(ICdcPeopleReportDomain.class, "cdcPeopleReportDomain/cdcPeopleReportDomain");
	
	
	// 增加
	public void insert() {
		//cdcPeopleReportDomain.insert(getPeopleReport());
		Record record = (Record) getParameter("record");
		CdcPeopleReport report = (CdcPeopleReport) record.toBean(CdcPeopleReport.class);
		cdcPeopleReportDomain.insert(report);
	}

	// 修改
	public void update() {
		cdcPeopleReportDomain.update(getPeopleReport());
	}
	
	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcPeopleReportDomain.delete(id);
	}
	
	//组装cdcPeopleInfoList
	public CdcPeopleReport getPeopleReport(){
		Record record = (Record) getParameter("record");
		CdcPeopleReport cdcPeopleReport = (CdcPeopleReport) record.toBean(CdcPeopleReport.class);
		
		Record[] cdcPeopleInfoRecord = (Record[]) getParameter("cdcPeopleInfoRecord");
		List<CdcPeopleInfo> cdcPeopleInfoList = new ArrayList<CdcPeopleInfo>();
		if (cdcPeopleInfoRecord != null) {
			for (int i = 0; i < cdcPeopleInfoRecord.length; i++) {
				CdcPeopleInfo cdcPeopleInfo = (CdcPeopleInfo) cdcPeopleInfoRecord[i].toBean(CdcPeopleInfo.class);
				cdcPeopleInfoList.add(cdcPeopleInfo);
			}
		}
		cdcPeopleReport.setCdcPeopleInfoList(cdcPeopleInfoList);
		return cdcPeopleReport;
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcPeopleReport cdcPeopleReport = (CdcPeopleReport) record.toBean(CdcPeopleReport.class);
		cdcPeopleReportDomain.sum(cdcPeopleReport);
	}
}