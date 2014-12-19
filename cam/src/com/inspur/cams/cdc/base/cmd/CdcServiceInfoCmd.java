package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcServiceInfo;
import com.inspur.cams.cdc.base.domain.ICdcServiceInfoDomain;

/**
 * 基础信息社区服务信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcServiceInfoCmd extends BaseAjaxCommand {

	private ICdcServiceInfoDomain cdcServiceInfoDomain = ScaComponentFactory
			.getService(ICdcServiceInfoDomain.class, "cdcServiceInfoDomain/cdcServiceInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcServiceInfo cdcServiceInfo = (CdcServiceInfo) record.toBean(CdcServiceInfo.class);
		cdcServiceInfoDomain.insert(cdcServiceInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcServiceInfo cdcServiceInfo = (CdcServiceInfo) record.toBean(CdcServiceInfo.class);
		cdcServiceInfoDomain.update(cdcServiceInfo);
	}
	
	//删除
	public void delete() {
		String delIds = (String) getParameter("delIds");
		cdcServiceInfoDomain.delete(delIds);
	}
	
}