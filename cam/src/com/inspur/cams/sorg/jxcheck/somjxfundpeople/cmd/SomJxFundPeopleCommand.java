package com.inspur.cams.sorg.jxcheck.somjxfundpeople.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.*;

/**
 * @title:SomJxFundPeopleCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxFundPeopleCommand extends BaseAjaxCommand{
	private SomJxFundPeopleDao dao = (SomJxFundPeopleDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeopleDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxFundPeople dataBean=(SomJxFundPeople)record.toBean(SomJxFundPeople.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxFundPeople dataBean=(SomJxFundPeople)record.toBean(SomJxFundPeople.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxFundPeople> list = new ArrayList<SomJxFundPeople>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxFundPeople dataBean = (SomJxFundPeople) records[i].toBean(SomJxFundPeople.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
