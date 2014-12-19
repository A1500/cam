package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomPeopleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPeopleOnline;

/**
 * @title:SomPeopleOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomPeopleOnlineCommand extends BaseAjaxCommand{
	private SomPeopleOnlineDao dao = (SomPeopleOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomPeopleOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPeopleOnline dataBean=(SomPeopleOnline)record.toBean(SomPeopleOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPeopleOnline dataBean=(SomPeopleOnline)record.toBean(SomPeopleOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPeopleOnline> list = new ArrayList<SomPeopleOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPeopleOnline dataBean = (SomPeopleOnline) records[i].toBean(SomPeopleOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
