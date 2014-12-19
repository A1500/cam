package com.inspur.cams.sorg.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.base.dao.jdbc.SomPartyMemberStatusChangeDao;
import com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange;

/**
 * @title:SomPartyMemberStatusChangeCommand
 * @description:
 * @author:
 * @since:2012-08-21
 * @version:1.0
*/
public class SomPartyMemberStatusChangeCommand extends BaseAjaxCommand{
	private SomPartyMemberStatusChangeDao dao = (SomPartyMemberStatusChangeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomPartyMemberStatusChangeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPartyMemberStatusChange dataBean=(SomPartyMemberStatusChange)record.toBean(SomPartyMemberStatusChange.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPartyMemberStatusChange dataBean=(SomPartyMemberStatusChange)record.toBean(SomPartyMemberStatusChange.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPartyMemberStatusChange> list = new ArrayList<SomPartyMemberStatusChange>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPartyMemberStatusChange dataBean = (SomPartyMemberStatusChange) records[i].toBean(SomPartyMemberStatusChange.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
