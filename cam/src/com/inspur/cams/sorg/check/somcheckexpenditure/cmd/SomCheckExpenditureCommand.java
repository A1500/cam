package com.inspur.cams.sorg.check.somcheckexpenditure.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditure;
import com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditureDao;

/**
 * @title:SomCheckExpenditureCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckExpenditureCommand extends BaseAjaxCommand{
	private SomCheckExpenditureDao dao = (SomCheckExpenditureDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditureDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckExpenditure dataBean=(SomCheckExpenditure)record.toBean(SomCheckExpenditure.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckExpenditure dataBean=(SomCheckExpenditure)record.toBean(SomCheckExpenditure.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckExpenditure> list = new ArrayList<SomCheckExpenditure>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckExpenditure dataBean = (SomCheckExpenditure) records[i].toBean(SomCheckExpenditure.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
