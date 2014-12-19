package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcNoticeCheck;
import com.inspur.cams.cdc.base.domain.ICdcNoticeCheckDomain;

/**
 * @title:CdcNoticeCheckCommand
 * @description:
 * @author:
 * @since:2012-03-29
 * @version:1.0
*/
public class CdcNoticeCheckCommand extends BaseAjaxCommand{
	private ICdcNoticeCheckDomain service = ScaComponentFactory
	.getService(ICdcNoticeCheckDomain.class, "cdcNoticeCheckDomain/cdcNoticeCheckDomain");
	
	public void save(){
		Record record = (Record) getParameter("record");
		CdcNoticeCheck cdcNoticeCheck = (CdcNoticeCheck) record.toBean(CdcNoticeCheck.class);
		service.insert(cdcNoticeCheck);
	}
	
}
