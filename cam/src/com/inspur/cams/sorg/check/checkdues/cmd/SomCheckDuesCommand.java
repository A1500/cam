package com.inspur.cams.sorg.check.checkdues.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkdues.dao.SomCheckDuesDao;
import com.inspur.cams.sorg.check.checkdues.data.SomCheckDues;

/**
 * @title:SomCheckDuesCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckDuesCommand extends BaseAjaxCommand{
	private SomCheckDuesDao dao = (SomCheckDuesDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkdues.dao.SomCheckDuesDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckDues dataBean=(SomCheckDues)record.toBean(SomCheckDues.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckDues dataBean=(SomCheckDues)record.toBean(SomCheckDues.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckDues> list = new ArrayList<SomCheckDues>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckDues dataBean = (SomCheckDues) records[i].toBean(SomCheckDues.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
