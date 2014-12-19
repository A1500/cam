package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomHeldPeopleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomHeldPeopleOnline;

/**
 * @title:SomHeldPeopleOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomHeldPeopleOnlineCommand extends BaseAjaxCommand{
	private SomHeldPeopleOnlineDao dao = (SomHeldPeopleOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomHeldPeopleOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomHeldPeopleOnline dataBean=(SomHeldPeopleOnline)record.toBean(SomHeldPeopleOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomHeldPeopleOnline dataBean=(SomHeldPeopleOnline)record.toBean(SomHeldPeopleOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomHeldPeopleOnline> list = new ArrayList<SomHeldPeopleOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomHeldPeopleOnline dataBean = (SomHeldPeopleOnline) records[i].toBean(SomHeldPeopleOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
