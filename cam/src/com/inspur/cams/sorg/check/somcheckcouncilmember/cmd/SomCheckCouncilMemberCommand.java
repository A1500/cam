package com.inspur.cams.sorg.check.somcheckcouncilmember.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMember;
import com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMemberDao;

/**
 * @title:SomCheckCouncilMemberCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckCouncilMemberCommand extends BaseAjaxCommand{
	private SomCheckCouncilMemberDao dao = (SomCheckCouncilMemberDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMemberDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckCouncilMember dataBean=(SomCheckCouncilMember)record.toBean(SomCheckCouncilMember.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckCouncilMember dataBean=(SomCheckCouncilMember)record.toBean(SomCheckCouncilMember.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckCouncilMember> list = new ArrayList<SomCheckCouncilMember>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckCouncilMember dataBean = (SomCheckCouncilMember) records[i].toBean(SomCheckCouncilMember.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
