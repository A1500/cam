package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionCommittee;
import com.inspur.cams.cdc.base.domain.ICdcElectionCommitteeDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:CdcElectionCommitteeCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class CdcElectionCommitteeCmd extends BaseAjaxCommand{
	
	
	 private ICdcElectionCommitteeDomain cdcElectionCommitteeDomain = ScaComponentFactory
			.getService(ICdcElectionCommitteeDomain.class, "cdcElectionCommitteeDomain/cdcElectionCommitteeDomain");
	

	public void save() {
		Record record = (Record) getParameter("record");
		CdcElectionCommittee dataBean=(CdcElectionCommittee)record.toBean(CdcElectionCommittee.class);
		if(dataBean.getCommitteeId()==null||"".equals(dataBean.getCommitteeId())){
			dataBean.setCommitteeId(dataBean.getOrganCode()+IdHelp.getUUID32());
			dataBean.setStatus("0");
			dataBean.setCreateTime(DateUtil.getTime());
			cdcElectionCommitteeDomain.insert(dataBean);
		}else if(dataBean.getState()==Record.STATE_MODIFIED){
			cdcElectionCommitteeDomain.update(dataBean);
		}
	}

	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionCommittee dataBean=(CdcElectionCommittee)record.toBean(CdcElectionCommittee.class);
		cdcElectionCommitteeDomain.update(dataBean);
	}
	
}
