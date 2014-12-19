package com.inspur.cams.drel.archive.sampeopleincomearchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeopleincomearchive.dao.jdbc.SamPeopleIncomeArchiveDao;
import com.inspur.cams.drel.archive.sampeopleincomearchive.data.SamPeopleIncomeArchive;

/**
 * @title:SamPeopleIncomeArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleIncomeArchiveCmd extends BaseAjaxCommand{
	private SamPeopleIncomeArchiveDao dao = (SamPeopleIncomeArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeopleincomearchive.dao.jdbc.SamPeopleIncomeArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleIncomeArchive dataBean=(SamPeopleIncomeArchive)record.toBean(SamPeopleIncomeArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleIncomeArchive dataBean=(SamPeopleIncomeArchive)record.toBean(SamPeopleIncomeArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleIncomeArchive> list = new ArrayList<SamPeopleIncomeArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleIncomeArchive dataBean = (SamPeopleIncomeArchive) records[i].toBean(SamPeopleIncomeArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
