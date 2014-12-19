package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcFinanceInfo;
import com.inspur.cams.cdc.base.domain.ICdcFinanceInfoDomain;

/**
 * @title:CdcFinanceInfoCommand
 * @description:
 * @author:
 * @since:2012-02-29
 * @version:1.0
*/
public class CdcFinanceInfoCmd extends BaseAjaxCommand{

	private ICdcFinanceInfoDomain cdcFinanceInfoDomain = ScaComponentFactory
	.getService(ICdcFinanceInfoDomain.class, "cdcFinanceInfoDomain/cdcFinanceInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		CdcFinanceInfo dataBean=(CdcFinanceInfo)record.toBean(CdcFinanceInfo.class);
		cdcFinanceInfoDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		CdcFinanceInfo dataBean=(CdcFinanceInfo)record.toBean(CdcFinanceInfo.class);
		cdcFinanceInfoDomain.update(dataBean);
	}
	
	public void report(){
		String id = (String) getParameter("id");
		cdcFinanceInfoDomain.report(id);
	}

	
	public void audit() {
		String id = (String) getParameter("id");
		cdcFinanceInfoDomain.audit(id);
	}
	public void sum(){
		Record record = (Record) getParameter("record");
		CdcFinanceInfo dataBean=(CdcFinanceInfo)record.toBean(CdcFinanceInfo.class);
		cdcFinanceInfoDomain.sum(dataBean);
	}
	public void delete(){
		String id = (String) getParameter("id");
		cdcFinanceInfoDomain.delete(id);
		
	}
	
}
