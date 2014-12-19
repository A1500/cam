package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcConstructInfo;
import com.inspur.cams.cdc.base.domain.ICdcConstructInfoDomain;

/**
 * 基础信息农村社区规划信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcConstructInfoCmd extends BaseAjaxCommand {

	private ICdcConstructInfoDomain cdcConstructInfoDomain = ScaComponentFactory
			.getService(ICdcConstructInfoDomain.class, "cdcConstructInfoDomain/cdcConstructInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcConstructInfo cdcConstructInfo = (CdcConstructInfo) record.toBean(CdcConstructInfo.class);
		cdcConstructInfoDomain.insert(cdcConstructInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcConstructInfo cdcConstructInfo = (CdcConstructInfo) record.toBean(CdcConstructInfo.class);
		cdcConstructInfoDomain.update(cdcConstructInfo);
	}
	
}