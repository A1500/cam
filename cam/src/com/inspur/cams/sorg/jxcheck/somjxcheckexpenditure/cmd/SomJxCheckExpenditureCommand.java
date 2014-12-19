package com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.*;

/**
 * @title:SomJxCheckExpenditureCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckExpenditureCommand extends BaseAjaxCommand{
	private SomJxCheckExpenditureDao dao = (SomJxCheckExpenditureDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditureDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckExpenditure dataBean=(SomJxCheckExpenditure)record.toBean(SomJxCheckExpenditure.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckExpenditure dataBean=(SomJxCheckExpenditure)record.toBean(SomJxCheckExpenditure.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckExpenditure> list = new ArrayList<SomJxCheckExpenditure>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckExpenditure dataBean = (SomJxCheckExpenditure) records[i].toBean(SomJxCheckExpenditure.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
