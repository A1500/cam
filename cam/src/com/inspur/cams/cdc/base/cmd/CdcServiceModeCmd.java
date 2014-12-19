package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcServiceMode;
import com.inspur.cams.cdc.base.domain.ICdcServiceModeDomain;

/**
 * 基础信息社区服务方式信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcServiceModeCmd extends BaseAjaxCommand {

	private ICdcServiceModeDomain cdcServiceModeDomain = ScaComponentFactory
			.getService(ICdcServiceModeDomain.class, "cdcServiceModeDomain/cdcServiceModeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcServiceMode cdcServiceMode = (CdcServiceMode) record.toBean(CdcServiceMode.class);
		cdcServiceModeDomain.insert(cdcServiceMode);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcServiceMode cdcServiceMode = (CdcServiceMode) record.toBean(CdcServiceMode.class);
		cdcServiceModeDomain.update(cdcServiceMode);
	}
	
	public void report(){
		String id = (String) getParameter("id");
		cdcServiceModeDomain.report(id);
	}
	
	public void delete(){
		String id = (String) getParameter("id");
		cdcServiceModeDomain.delete(id);
	}
	
	public void audit(){
		String id = (String) getParameter("id");
		cdcServiceModeDomain.audit(id);
	}
	
	public void sum(){
		Record record = (Record) getParameter("record");
		CdcServiceMode cdcServiceMode = (CdcServiceMode) record.toBean(CdcServiceMode.class);
		cdcServiceModeDomain.sum(cdcServiceMode);
	}
	
}