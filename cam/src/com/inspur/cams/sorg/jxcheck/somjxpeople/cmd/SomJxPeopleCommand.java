package com.inspur.cams.sorg.jxcheck.somjxpeople.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxpeople.dao.*;

/**
 * @title:SomJxPeopleCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxPeopleCommand extends BaseAjaxCommand{
	private SomJxPeopleDao dao = (SomJxPeopleDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeopleDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxPeople dataBean=(SomJxPeople)record.toBean(SomJxPeople.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxPeople dataBean=(SomJxPeople)record.toBean(SomJxPeople.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxPeople> list = new ArrayList<SomJxPeople>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxPeople dataBean = (SomJxPeople) records[i].toBean(SomJxPeople.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
