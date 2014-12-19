package com.inspur.cams.sorg.jxcheck.somjxcheckchanges.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao.*;

/**
 * @title:SomJxCheckChangesCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckChangesCommand extends BaseAjaxCommand{
	private SomJxCheckChangesDao dao = (SomJxCheckChangesDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao.SomJxCheckChangesDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckChanges dataBean=(SomJxCheckChanges)record.toBean(SomJxCheckChanges.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckChanges dataBean=(SomJxCheckChanges)record.toBean(SomJxCheckChanges.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckChanges> list = new ArrayList<SomJxCheckChanges>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckChanges dataBean = (SomJxCheckChanges) records[i].toBean(SomJxCheckChanges.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
