package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionCityMember;
import com.inspur.cams.cdc.base.domain.ICdcElectionCityMemberDomain;

/**
 * @title:CdcElectionCityMemberCommand
 * @description:
 * @author:
 * @since:2013-02-17
 * @version:1.0
*/
public class CdcElectionCityMemberCommand extends BaseAjaxCommand{
	private ICdcElectionCityMemberDomain cdcElectionMemberDomain = ScaComponentFactory
	.getService(ICdcElectionCityMemberDomain.class, "cdcElectionCityMemberDomain/cdcElectionCityMemberDomain");


	public void insert() {
		Record record = (Record) getParameter("record");
		CdcElectionCityMember dataBean=(CdcElectionCityMember)record.toBean(CdcElectionCityMember.class);
		cdcElectionMemberDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionCityMember dataBean=(CdcElectionCityMember)record.toBean(CdcElectionCityMember.class);
		cdcElectionMemberDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		cdcElectionMemberDomain.delete(delIds);
	}
}
