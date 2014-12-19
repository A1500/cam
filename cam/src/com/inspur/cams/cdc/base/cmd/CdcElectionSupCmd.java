package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionSup;
import com.inspur.cams.cdc.base.domain.ICdcElectionSupDomain;

/**
 * 民主选举监督委员会cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionSupCmd extends BaseAjaxCommand {

	private ICdcElectionSupDomain cdcElectionSupDomain = ScaComponentFactory
			.getService(ICdcElectionSupDomain.class, "cdcElectionSupDomain/cdcElectionSupDomain");
	
	// 增加
	public void insert() {
		cdcElectionSupDomain.insert(getBean());
	}

	// 修改
	public void update() {
		cdcElectionSupDomain.update(getBean());
	}
	
	// 删除
	public void delete() {
		String supId = (String) getParameter("supId");
		cdcElectionSupDomain.delete(supId);
	}

	private CdcElectionSup getBean() {
		Record record = (Record) getParameter("record");
		CdcElectionSup cdcElectionSup = (CdcElectionSup) record.toBean(CdcElectionSup.class);
		
		Record[] records = (Record[]) getParameter("list");
		if (records != null) {
			List<CdcElectionMember> list = new ArrayList<CdcElectionMember>();
			for (int i = 0; i < records.length; i++) {
				CdcElectionMember cdcElectionMember = (CdcElectionMember) records[i].toBean(CdcElectionMember.class);
				list.add(cdcElectionMember);
			}
			cdcElectionSup.setCdcElectionMemberList(list);
		}
		
		return cdcElectionSup;
	}
	
}