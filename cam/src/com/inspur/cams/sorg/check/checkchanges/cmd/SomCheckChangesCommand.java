package com.inspur.cams.sorg.check.checkchanges.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkchanges.dao.SomCheckChangesDao;
import com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges;

/**
 * @title:SomCheckChangesCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckChangesCommand extends BaseAjaxCommand{
	private SomCheckChangesDao dao = (SomCheckChangesDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkchanges.dao.SomCheckChangesDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckChanges dataBean=(SomCheckChanges)record.toBean(SomCheckChanges.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckChanges dataBean=(SomCheckChanges)record.toBean(SomCheckChanges.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckChanges> list = new ArrayList<SomCheckChanges>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckChanges dataBean = (SomCheckChanges) records[i].toBean(SomCheckChanges.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
