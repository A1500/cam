package com.inspur.cams.sorg.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.base.dao.jdbc.SomPeopleResumeDao;
import com.inspur.cams.sorg.base.data.SomPeopleResume;

/**
 * @title:SomPeopleResumeCommand
 * @description:
 * @author:
 * @since:2011-10-31
 * @version:1.0
*/
public class SomPeopleResumeCommand extends BaseAjaxCommand{
	private SomPeopleResumeDao dao = (SomPeopleResumeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomPeopleResumeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPeopleResume dataBean=(SomPeopleResume)record.toBean(SomPeopleResume.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPeopleResume dataBean=(SomPeopleResume)record.toBean(SomPeopleResume.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPeopleResume> list = new ArrayList<SomPeopleResume>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPeopleResume dataBean = (SomPeopleResume) records[i].toBean(SomPeopleResume.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
