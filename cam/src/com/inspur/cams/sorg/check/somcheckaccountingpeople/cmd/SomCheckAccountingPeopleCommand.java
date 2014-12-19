package com.inspur.cams.sorg.check.somcheckaccountingpeople.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeople;
import com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeopleDao;

/**
 * @title:SomCheckAccountingPeopleCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckAccountingPeopleCommand extends BaseAjaxCommand{
	private SomCheckAccountingPeopleDao dao = (SomCheckAccountingPeopleDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckaccountingpeople.dao.SomCheckAccountingPeopleDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckAccountingPeople dataBean=(SomCheckAccountingPeople)record.toBean(SomCheckAccountingPeople.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckAccountingPeople dataBean=(SomCheckAccountingPeople)record.toBean(SomCheckAccountingPeople.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckAccountingPeople> list = new ArrayList<SomCheckAccountingPeople>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckAccountingPeople dataBean = (SomCheckAccountingPeople) records[i].toBean(SomCheckAccountingPeople.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
