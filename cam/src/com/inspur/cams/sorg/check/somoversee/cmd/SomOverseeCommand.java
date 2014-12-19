package com.inspur.cams.sorg.check.somoversee.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somoversee.dao.SomOversee;
import com.inspur.cams.sorg.check.somoversee.dao.SomOverseeDao;

/**
 * @title:SomOverseeCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomOverseeCommand extends BaseAjaxCommand{
	private SomOverseeDao dao = (SomOverseeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somoversee.dao.SomOverseeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomOversee dataBean=(SomOversee)record.toBean(SomOversee.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomOversee dataBean=(SomOversee)record.toBean(SomOversee.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomOversee> list = new ArrayList<SomOversee>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomOversee dataBean = (SomOversee) records[i].toBean(SomOversee.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
