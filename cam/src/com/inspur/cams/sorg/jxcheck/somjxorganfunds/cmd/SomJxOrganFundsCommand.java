package com.inspur.cams.sorg.jxcheck.somjxorganfunds.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.*;

/**
 * @title:SomJxOrganFundsCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxOrganFundsCommand extends BaseAjaxCommand{
	private SomJxOrganFundsDao dao = (SomJxOrganFundsDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFundsDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxOrganFunds dataBean=(SomJxOrganFunds)record.toBean(SomJxOrganFunds.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxOrganFunds dataBean=(SomJxOrganFunds)record.toBean(SomJxOrganFunds.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxOrganFunds> list = new ArrayList<SomJxOrganFunds>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxOrganFunds dataBean = (SomJxOrganFunds) records[i].toBean(SomJxOrganFunds.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
