package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionPrepare;
import com.inspur.cams.cdc.base.domain.ICdcElectionPrepareDomain;

/**
 * 民主选举选举准备信息表cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPrepareCmd extends BaseAjaxCommand {

	private ICdcElectionPrepareDomain cdcElectionPrepareDomain = ScaComponentFactory
			.getService(ICdcElectionPrepareDomain.class, "cdcElectionPrepareDomain/cdcElectionPrepareDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcElectionPrepare cdcElectionPrepare = (CdcElectionPrepare) record.toBean(CdcElectionPrepare.class);
		cdcElectionPrepareDomain.insert(cdcElectionPrepare);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionPrepare cdcElectionPrepare = (CdcElectionPrepare) record.toBean(CdcElectionPrepare.class);
		cdcElectionPrepareDomain.update(cdcElectionPrepare);
	}
	
	// 删除
	public void delete() {
		String prepareId = (String) getParameter("prepareId");
		cdcElectionPrepareDomain.delete(prepareId);
	}
	
}