package com.inspur.cams.sorg.jxcheck.somjxcheckfinance.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.*;

/**
 * @title:SomJxCheckFinanceCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckFinanceCommand extends BaseAjaxCommand{
	private SomJxCheckFinanceDao dao = (SomJxCheckFinanceDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinanceDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckFinance dataBean=(SomJxCheckFinance)record.toBean(SomJxCheckFinance.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckFinance dataBean=(SomJxCheckFinance)record.toBean(SomJxCheckFinance.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckFinance> list = new ArrayList<SomJxCheckFinance>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckFinance dataBean = (SomJxCheckFinance) records[i].toBean(SomJxCheckFinance.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
