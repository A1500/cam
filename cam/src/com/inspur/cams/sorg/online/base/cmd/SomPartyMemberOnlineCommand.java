package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomPartyMemberOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPartyMemberOnline;

/**
 * @title:SomPartyMemberOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
public class SomPartyMemberOnlineCommand extends BaseAjaxCommand{
	private SomPartyMemberOnlineDao dao = (SomPartyMemberOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomPartyMemberOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPartyMemberOnline dataBean=(SomPartyMemberOnline)record.toBean(SomPartyMemberOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPartyMemberOnline dataBean=(SomPartyMemberOnline)record.toBean(SomPartyMemberOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPartyMemberOnline> list = new ArrayList<SomPartyMemberOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPartyMemberOnline dataBean = (SomPartyMemberOnline) records[i].toBean(SomPartyMemberOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
