package com.inspur.cams.sorg.check.checkworker.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkworker.dao.SomCheckWorkerDao;
import com.inspur.cams.sorg.check.checkworker.data.SomCheckWorker;

/**
 * @title:SomCheckWorkerCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckWorkerCommand extends BaseAjaxCommand{
	private SomCheckWorkerDao dao = (SomCheckWorkerDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkworker.dao.SomCheckWorkerDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckWorker dataBean=(SomCheckWorker)record.toBean(SomCheckWorker.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckWorker dataBean=(SomCheckWorker)record.toBean(SomCheckWorker.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckWorker> list = new ArrayList<SomCheckWorker>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckWorker dataBean = (SomCheckWorker) records[i].toBean(SomCheckWorker.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
