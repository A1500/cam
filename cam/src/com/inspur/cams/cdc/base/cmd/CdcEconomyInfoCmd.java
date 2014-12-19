package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcEconomyInfo;
import com.inspur.cams.cdc.base.domain.ICdcEconomyInfoDomain;

/**
 * 基础信息社区资产状况信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcEconomyInfoCmd extends BaseAjaxCommand {

	private ICdcEconomyInfoDomain cdcEconomyInfoDomain = ScaComponentFactory
			.getService(ICdcEconomyInfoDomain.class, "cdcEconomyInfoDomain/cdcEconomyInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcEconomyInfo cdcEconomyInfo = (CdcEconomyInfo) record.toBean(CdcEconomyInfo.class);
		cdcEconomyInfoDomain.insert(cdcEconomyInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcEconomyInfo cdcEconomyInfo = (CdcEconomyInfo) record.toBean(CdcEconomyInfo.class);
		cdcEconomyInfoDomain.update(cdcEconomyInfo);
	}

	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcEconomyInfoDomain.delete(id);
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcEconomyInfo cdcEconomyInfo = (CdcEconomyInfo) record.toBean(CdcEconomyInfo.class);
		cdcEconomyInfoDomain.sum(cdcEconomyInfo);
	}
	
}