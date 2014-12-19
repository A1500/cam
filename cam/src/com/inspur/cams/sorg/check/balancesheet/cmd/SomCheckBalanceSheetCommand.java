package com.inspur.cams.sorg.check.balancesheet.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.balancesheet.dao.SomCheckBalanceSheetDao;
import com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet;

/**
 * @title:SomCheckBalanceSheetCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckBalanceSheetCommand extends BaseAjaxCommand{
	private SomCheckBalanceSheetDao dao = (SomCheckBalanceSheetDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.balancesheet.dao.SomCheckBalanceSheetDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckBalanceSheet dataBean=(SomCheckBalanceSheet)record.toBean(SomCheckBalanceSheet.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckBalanceSheet dataBean=(SomCheckBalanceSheet)record.toBean(SomCheckBalanceSheet.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckBalanceSheet> list = new ArrayList<SomCheckBalanceSheet>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckBalanceSheet dataBean = (SomCheckBalanceSheet) records[i].toBean(SomCheckBalanceSheet.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
