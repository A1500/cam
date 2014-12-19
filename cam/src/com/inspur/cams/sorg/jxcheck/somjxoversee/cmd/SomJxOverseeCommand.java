package com.inspur.cams.sorg.jxcheck.somjxoversee.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxoversee.dao.*;

/**
 * @title:SomJxOverseeCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxOverseeCommand extends BaseAjaxCommand{
	private SomJxOverseeDao dao = (SomJxOverseeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOverseeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxOversee dataBean=(SomJxOversee)record.toBean(SomJxOversee.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxOversee dataBean=(SomJxOversee)record.toBean(SomJxOversee.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxOversee> list = new ArrayList<SomJxOversee>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxOversee dataBean = (SomJxOversee) records[i].toBean(SomJxOversee.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
