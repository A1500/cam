package com.inspur.cams.cdc.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcElectionMember;
import com.inspur.cams.cdc.base.data.CdcElectionResult;
import com.inspur.cams.cdc.base.domain.ICdcElectionResultDomain;

/**
 * 民主选举选举结果cmd
 * @author 
 * @date 2012-12-14
 */
public class CdcElectionResultCmd extends BaseAjaxCommand {

	private ICdcElectionResultDomain cdcElectionResultDomain = ScaComponentFactory
			.getService(ICdcElectionResultDomain.class, "cdcElectionResultDomain/cdcElectionResultDomain");
	
	// 增加
	public void insert() {
		cdcElectionResultDomain.insert(getBean());
	}

	// 修改
	public void update() {
		cdcElectionResultDomain.update(getBean());
	}
	
	// 删除
	public void delete() {
		String resultId = (String) getParameter("resultId");
		cdcElectionResultDomain.delete(resultId);
	}

	private CdcElectionResult getBean() {
		Record record = (Record) getParameter("record");
		CdcElectionResult cdcElectionResult = (CdcElectionResult) record.toBean(CdcElectionResult.class);
		
		Record[] records = (Record[]) getParameter("list");//村委会成员
		if (records != null) {
			List<CdcElectionMember> list = new ArrayList<CdcElectionMember>();
			for (int i = 0; i < records.length; i++) {
				CdcElectionMember cdcElectionMember = (CdcElectionMember) records[i].toBean(CdcElectionMember.class);
				list.add(cdcElectionMember);
			}
			cdcElectionResult.setCdcElectionMemberList(list);
		}

		Record[] records2 = (Record[]) getParameter("list2");//另行选举
		if (records2 != null) {
			List<CdcElectionMember> otherMemberList = new ArrayList<CdcElectionMember>();
			for (int i = 0; i < records2.length; i++) {
				CdcElectionMember cdcElectionMember = (CdcElectionMember) records2[i].toBean(CdcElectionMember.class);
				otherMemberList.add(cdcElectionMember);
			}
			cdcElectionResult.setOtherMemberList(otherMemberList);
		}

		Record[] records3 = (Record[]) getParameter("list3");//下属委员会
		if (records3 != null) {
			List<CdcElectionMember> subMemberList = new ArrayList<CdcElectionMember>();
			for (int i = 0; i < records3.length; i++) {
				CdcElectionMember cdcElectionMember = (CdcElectionMember) records3[i].toBean(CdcElectionMember.class);
				subMemberList.add(cdcElectionMember);
			}
			cdcElectionResult.setSubMemberList(subMemberList);
		}

		Record[] records4 = (Record[]) getParameter("list4");//财会人员
		if (records4 != null) {
			List<CdcElectionMember> funMemberList = new ArrayList<CdcElectionMember>();
			for (int i = 0; i < records4.length; i++) {
				CdcElectionMember cdcElectionMember = (CdcElectionMember) records4[i].toBean(CdcElectionMember.class);
				funMemberList.add(cdcElectionMember);
			}
			cdcElectionResult.setFunMemberList(funMemberList);
		}
		
		return cdcElectionResult;
	}
	
}