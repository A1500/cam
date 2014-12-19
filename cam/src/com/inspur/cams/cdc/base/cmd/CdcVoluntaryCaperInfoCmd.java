package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcVoluntaryCaperInfo;
import com.inspur.cams.cdc.base.domain.ICdcVoluntaryCaperInfoDomain;

/**
 * 志愿者参加活动信息cmd
 * @author 
 * @date 2013-02-26
 */
public class CdcVoluntaryCaperInfoCmd extends BaseAjaxCommand {

	private ICdcVoluntaryCaperInfoDomain cdcVoluntaryCaperInfoDomain = ScaComponentFactory
			.getService(ICdcVoluntaryCaperInfoDomain.class, "cdcVoluntaryCaperInfoDomain/cdcVoluntaryCaperInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = (CdcVoluntaryCaperInfo) record.toBean(CdcVoluntaryCaperInfo.class);
		cdcVoluntaryCaperInfoDomain.insert(cdcVoluntaryCaperInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = (CdcVoluntaryCaperInfo) record.toBean(CdcVoluntaryCaperInfo.class);
		cdcVoluntaryCaperInfoDomain.update(cdcVoluntaryCaperInfo);
	}
	
	// 删除
	public void delete() {
		String recordId = (String) getParameter("recordId");
		cdcVoluntaryCaperInfoDomain.delete(recordId);
	}
	
}