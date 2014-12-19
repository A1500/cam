package com.inspur.cams.sorg.jxcheck.somjxchecksystems.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.*;

/**
 * @title:SomJxCheckSystemsCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckSystemsCommand extends BaseAjaxCommand{
	private SomJxCheckSystemsDao dao = (SomJxCheckSystemsDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.SomJxCheckSystemsDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckSystems dataBean=(SomJxCheckSystems)record.toBean(SomJxCheckSystems.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckSystems dataBean=(SomJxCheckSystems)record.toBean(SomJxCheckSystems.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckSystems> list = new ArrayList<SomJxCheckSystems>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckSystems dataBean = (SomJxCheckSystems) records[i].toBean(SomJxCheckSystems.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
