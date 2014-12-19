package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.domain.ICdcElectionMemberDomain;

/**
 * 民主选举人员信息cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionMemberCmd extends BaseAjaxCommand {

	private ICdcElectionMemberDomain cdcElectionMemberDomain = ScaComponentFactory
			.getService(ICdcElectionMemberDomain.class, "cdcElectionMemberDomain/cdcElectionMemberDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcElectionMember cdcElectionMember = (CdcElectionMember) record.toBean(CdcElectionMember.class);
		cdcElectionMemberDomain.insert(cdcElectionMember);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcElectionMember cdcElectionMember = (CdcElectionMember) record.toBean(CdcElectionMember.class);
		cdcElectionMemberDomain.update(cdcElectionMember);
	}
	
	// 删除
	public void delete() {
		String memberId = (String) getParameter("memberId");
		cdcElectionMemberDomain.delete(memberId);
	}
	
}