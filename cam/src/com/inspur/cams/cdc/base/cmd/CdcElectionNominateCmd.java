package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionNominate;
import com.inspur.cams.cdc.base.domain.ICdcElectionNominateDomain;

/**
 * 民主选举候选人的产生cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionNominateCmd extends BaseAjaxCommand {

	private ICdcElectionNominateDomain cdcElectionNominateDomain = ScaComponentFactory
			.getService(ICdcElectionNominateDomain.class, "cdcElectionNominateDomain/cdcElectionNominateDomain");
	
	// 增加
	public void insert() {
		cdcElectionNominateDomain.insert(getBean());
	}

	// 修改
	public void update() {
		cdcElectionNominateDomain.update(getBean());
	}
	
	// 删除
	public void delete() {
		String nominateId = (String) getParameter("nominateId");
		cdcElectionNominateDomain.delete(nominateId);
	}
	
	private CdcElectionNominate getBean() {
		Record record = (Record) getParameter("record");
		CdcElectionNominate cdcElectionNominate = (CdcElectionNominate) record.toBean(CdcElectionNominate.class);
		
		Record[] records = (Record[]) getParameter("list");
		if (records != null) {
			List<CdcElectionMember> list = new ArrayList<CdcElectionMember>();
			for (int i = 0; i < records.length; i++) {
				CdcElectionMember cdcElectionMember = (CdcElectionMember) records[i].toBean(CdcElectionMember.class);
				list.add(cdcElectionMember);
			}
			cdcElectionNominate.setCdcElectionMemberList(list);
		}
		
		return cdcElectionNominate;
	}
	
}