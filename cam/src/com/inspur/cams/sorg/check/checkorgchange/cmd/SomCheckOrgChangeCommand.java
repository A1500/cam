package com.inspur.cams.sorg.check.checkorgchange.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.checkorgchange.dao.SomCheckOrgChangeDao;
import com.inspur.cams.sorg.check.checkorgchange.data.SomCheckOrgChange;

/**
 * @title:SomCheckOrgChangeCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class SomCheckOrgChangeCommand extends BaseAjaxCommand{
	private SomCheckOrgChangeDao dao = (SomCheckOrgChangeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkorgchange.dao.SomCheckOrgChangeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckOrgChange dataBean=(SomCheckOrgChange)record.toBean(SomCheckOrgChange.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckOrgChange dataBean=(SomCheckOrgChange)record.toBean(SomCheckOrgChange.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckOrgChange> list = new ArrayList<SomCheckOrgChange>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckOrgChange dataBean = (SomCheckOrgChange) records[i].toBean(SomCheckOrgChange.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
