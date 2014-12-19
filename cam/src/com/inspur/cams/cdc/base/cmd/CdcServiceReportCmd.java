package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcServiceInfo;
import com.inspur.cams.cdc.base.data.CdcServiceReport;
import com.inspur.cams.cdc.base.domain.ICdcServiceReportDomain;

/**
 * 基础信息社区服务统计表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcServiceReportCmd extends BaseAjaxCommand {

	private ICdcServiceReportDomain cdcServiceReportDomain = ScaComponentFactory
			.getService(ICdcServiceReportDomain.class, "cdcServiceReportDomain/cdcServiceReportDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcServiceReport cdcServiceReport = (CdcServiceReport) record.toBean(CdcServiceReport.class);
		Record[] serviceInfos = (Record[]) getParameter("serviceInfos");
		List<CdcServiceInfo> infos = new ArrayList<CdcServiceInfo>();
		if(serviceInfos!=null){
			for(Record reocrd : serviceInfos){
				CdcServiceInfo info = (CdcServiceInfo) reocrd.toBean(CdcServiceInfo.class);
				infos.add(info);
			}
		}
		cdcServiceReportDomain.insert(infos,cdcServiceReport);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcServiceReport cdcServiceReport = (CdcServiceReport) record.toBean(CdcServiceReport.class);
		Record[] serviceInfos = (Record[]) getParameter("serviceInfos");
		List<CdcServiceInfo> infos = new ArrayList<CdcServiceInfo>();
		if(serviceInfos!=null){
			for(Record reocrd : serviceInfos){
				CdcServiceInfo info = (CdcServiceInfo) reocrd.toBean(CdcServiceInfo.class);
				infos.add(info);
			}
		}
		cdcServiceReportDomain.update(infos,cdcServiceReport);
	}
	
	public void updateReport(){
		Record record = (Record) getParameter("record");
		CdcServiceReport cdcServiceReport = (CdcServiceReport) record.toBean(CdcServiceReport.class);
		cdcServiceReportDomain.update(cdcServiceReport);
	}
	
	public void sum(){
		Record record = (Record) getParameter("record");
		CdcServiceReport cdcServiceReport = (CdcServiceReport) record.toBean(CdcServiceReport.class);
		cdcServiceReportDomain.sum(cdcServiceReport);
	}
	
	public void delete (){
		String reportId = (String) getParameter("id");
		cdcServiceReportDomain.delete(reportId);
	}
	
}