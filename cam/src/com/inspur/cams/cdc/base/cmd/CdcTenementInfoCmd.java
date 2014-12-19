package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcTenementInfo;
import com.inspur.cams.cdc.base.domain.ICdcTenementInfoDomain;

/**
 * @title:CdcTenementInfoCommand
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
public class CdcTenementInfoCmd extends BaseAjaxCommand{
	
	private ICdcTenementInfoDomain cdcTenementInfoDomain = ScaComponentFactory
	.getService(ICdcTenementInfoDomain.class, "cdcTenementInfoDomain/cdcTenementInfoDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcTenementInfo dataBean=(CdcTenementInfo)record.toBean(CdcTenementInfo.class);
		cdcTenementInfoDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		CdcTenementInfo dataBean=(CdcTenementInfo)record.toBean(CdcTenementInfo.class);
		cdcTenementInfoDomain.update(dataBean);
	}

	public void delete() {
		String id =(String) getParameter("recordId");
		if(id!=null){
			cdcTenementInfoDomain.delete(id);
		}
	}
	
	public void sum(){
		Record record = (Record) getParameter("record");
		CdcTenementInfo dataBean=(CdcTenementInfo)record.toBean(CdcTenementInfo.class);
		cdcTenementInfoDomain.sum(dataBean);
	}
}
