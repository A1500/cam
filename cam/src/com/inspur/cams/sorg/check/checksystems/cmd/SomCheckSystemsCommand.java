package com.inspur.cams.sorg.check.checksystems.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.checksystems.dao.SomCheckSystemsDao;
import com.inspur.cams.sorg.check.checksystems.data.SomCheckSystems;

/**
 * @title:内部制度建设情况Command
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
 */
public class SomCheckSystemsCommand extends BaseAjaxCommand {
	private SomCheckSystemsDao dao = (SomCheckSystemsDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checksystems.dao.SomCheckSystemsDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckSystems dataBean = (SomCheckSystems) record
				.toBean(SomCheckSystems.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckSystems dataBean = (SomCheckSystems) record
				.toBean(SomCheckSystems.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}

	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckSystems> list = new ArrayList<SomCheckSystems>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckSystems dataBean = (SomCheckSystems) records[i]
					.toBean(SomCheckSystems.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
