package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomPeopleResumeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPeopleResumeOnline;

/**
 * @title:SomPeopleResumeOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomPeopleResumeOnlineCommand extends BaseAjaxCommand{
	private SomPeopleResumeOnlineDao dao = (SomPeopleResumeOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomPeopleResumeOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPeopleResumeOnline dataBean=(SomPeopleResumeOnline)record.toBean(SomPeopleResumeOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPeopleResumeOnline dataBean=(SomPeopleResumeOnline)record.toBean(SomPeopleResumeOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPeopleResumeOnline> list = new ArrayList<SomPeopleResumeOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPeopleResumeOnline dataBean = (SomPeopleResumeOnline) records[i].toBean(SomPeopleResumeOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
