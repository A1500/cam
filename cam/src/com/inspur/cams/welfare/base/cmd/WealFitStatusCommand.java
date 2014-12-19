package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitStatusDao;
import com.inspur.cams.welfare.base.data.WealFitStatus;

/**
 * @title:WealFitStatusCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitStatusCommand extends BaseAjaxCommand{
	private WealFitStatusDao dao = (WealFitStatusDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitStatusDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitStatus dataBean=(WealFitStatus)record.toBean(WealFitStatus.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitStatus dataBean=(WealFitStatus)record.toBean(WealFitStatus.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitStatus> list = new ArrayList<WealFitStatus>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitStatus dataBean = (WealFitStatus) records[i].toBean(WealFitStatus.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
