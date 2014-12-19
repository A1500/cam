package com.inspur.cams.sorg.check.checkintervisit.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkintervisit.dao.SomCheckInterVisitDao;
import com.inspur.cams.sorg.check.checkintervisit.data.SomCheckInterVisit;

/**
 * @title:SomCheckInterVisitCommand
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
public class SomCheckInterVisitCommand extends BaseAjaxCommand{
	private SomCheckInterVisitDao dao = (SomCheckInterVisitDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkintervisit.dao.SomCheckInterVisitDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckInterVisit dataBean=(SomCheckInterVisit)record.toBean(SomCheckInterVisit.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckInterVisit dataBean=(SomCheckInterVisit)record.toBean(SomCheckInterVisit.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckInterVisit> list = new ArrayList<SomCheckInterVisit>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckInterVisit dataBean = (SomCheckInterVisit) records[i].toBean(SomCheckInterVisit.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
