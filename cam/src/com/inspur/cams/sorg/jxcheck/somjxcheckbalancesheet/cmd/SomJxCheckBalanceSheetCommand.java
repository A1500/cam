package com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.*;

/**
 * @title:SomJxCheckBalanceSheetCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckBalanceSheetCommand extends BaseAjaxCommand{
	private SomJxCheckBalanceSheetDao dao = (SomJxCheckBalanceSheetDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheetDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckBalanceSheet dataBean=(SomJxCheckBalanceSheet)record.toBean(SomJxCheckBalanceSheet.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckBalanceSheet dataBean=(SomJxCheckBalanceSheet)record.toBean(SomJxCheckBalanceSheet.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckBalanceSheet> list = new ArrayList<SomJxCheckBalanceSheet>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckBalanceSheet dataBean = (SomJxCheckBalanceSheet) records[i].toBean(SomJxCheckBalanceSheet.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
