package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcDecisionInfo;
import com.inspur.cams.cdc.base.domain.ICdcDecisionInfoDomain;

/**
 * 基层民主民主决策信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcDecisionInfoCmd extends BaseAjaxCommand {

	private ICdcDecisionInfoDomain cdcDecisionInfoDomain = ScaComponentFactory
			.getService(ICdcDecisionInfoDomain.class, "cdcDecisionInfoDomain/cdcDecisionInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcDecisionInfo cdcDecisionInfo = (CdcDecisionInfo) record.toBean(CdcDecisionInfo.class);
		cdcDecisionInfoDomain.insert(cdcDecisionInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcDecisionInfo cdcDecisionInfo = (CdcDecisionInfo) record.toBean(CdcDecisionInfo.class);
		cdcDecisionInfoDomain.update(cdcDecisionInfo);
	}

	// 删除
	public void delete() {
		String id = (String) getParameter("id");
		cdcDecisionInfoDomain.delete(id);
	}
	
	// 汇总
	public void sum() {
		Record record = (Record) getParameter("record");
		CdcDecisionInfo cdcDecisionInfo = (CdcDecisionInfo) record.toBean(CdcDecisionInfo.class);
		cdcDecisionInfoDomain.sum(cdcDecisionInfo);
	}
	
}