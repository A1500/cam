package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionInfo;
import com.inspur.cams.cdc.base.domain.ICdcElectionInfoDomain;

/**
 * 民主选举选举信息表cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcElectionInfoCmd extends BaseAjaxCommand {

	private ICdcElectionInfoDomain cdcElectionInfoDomain = ScaComponentFactory
			.getService(ICdcElectionInfoDomain.class, "cdcElectionInfoDomain/cdcElectionInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcElectionInfo cdcElectionInfo = (CdcElectionInfo) record.toBean(CdcElectionInfo.class);
		cdcElectionInfoDomain.insert(cdcElectionInfo);
		setReturn("recordId", cdcElectionInfo.getRecordId());
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionInfo cdcElectionInfo = (CdcElectionInfo) record.toBean(CdcElectionInfo.class);
		cdcElectionInfoDomain.update(cdcElectionInfo);
	}
	
}