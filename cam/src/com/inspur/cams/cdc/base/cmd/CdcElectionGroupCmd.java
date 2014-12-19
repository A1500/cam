package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionGroup;
import com.inspur.cams.cdc.base.domain.ICdcElectionGroupDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:CdcElectionGroupCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class CdcElectionGroupCmd extends BaseAjaxCommand{
	
	  private ICdcElectionGroupDomain cdcElectionGroupDomain = ScaComponentFactory
			.getService(ICdcElectionGroupDomain.class, "cdcElectionGroupDomain/cdcElectionGroupDomain");
	
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcElectionGroup dataBean=(CdcElectionGroup)record.toBean(CdcElectionGroup.class);
			dataBean.setGroupId(dataBean.getOrganCode()+IdHelp.getUUID32());
			dataBean.setStatus("0");
			dataBean.setCreateTime(DateUtil.getTime());
			cdcElectionGroupDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionGroup dataBean=(CdcElectionGroup)record.toBean(CdcElectionGroup.class);
		cdcElectionGroupDomain.update(dataBean);
	}


}
