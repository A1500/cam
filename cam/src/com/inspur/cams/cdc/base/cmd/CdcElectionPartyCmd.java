package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionParty;
import com.inspur.cams.cdc.base.domain.ICdcElectionPartyDomain;

/**
 * 民主选举党员信息cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionPartyCmd extends BaseAjaxCommand {

	private ICdcElectionPartyDomain cdcElectionPartyDomain = ScaComponentFactory
			.getService(ICdcElectionPartyDomain.class, "cdcElectionPartyDomain/cdcElectionPartyDomain");
	
	// 增加
	public void insert() {
		cdcElectionPartyDomain.insert(getBean());
	}

	// 修改
	public void update() {
		cdcElectionPartyDomain.update(getBean());
	}
	
	// 删除
	public void delete() {
		String partyId = (String) getParameter("partyId");
		cdcElectionPartyDomain.delete(partyId);
	}

	private CdcElectionParty getBean() {
		Record record = (Record) getParameter("record");
		CdcElectionParty cdcElectionParty = (CdcElectionParty) record.toBean(CdcElectionParty.class);
		
		Record[] records = (Record[]) getParameter("list");
		if (records != null) {
			List<CdcElectionMember> list = new ArrayList<CdcElectionMember>();
			for (int i = 0; i < records.length; i++) {
				CdcElectionMember cdcElectionMember = (CdcElectionMember) records[i].toBean(CdcElectionMember.class);
				list.add(cdcElectionMember);
			}
			cdcElectionParty.setCdcElectionMemberList(list);
		}
		
		return cdcElectionParty;
	}
	
}