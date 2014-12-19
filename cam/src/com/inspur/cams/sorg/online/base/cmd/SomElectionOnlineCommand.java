package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomElectionOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomElectionOnline;

/**
 * @title:SomElectionOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-22
 * @version:1.0
*/
public class SomElectionOnlineCommand extends BaseAjaxCommand{
	private SomElectionOnlineDao dao = (SomElectionOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomElectionOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomElectionOnline dataBean=(SomElectionOnline)record.toBean(SomElectionOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomElectionOnline dataBean=(SomElectionOnline)record.toBean(SomElectionOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomElectionOnline> list = new ArrayList<SomElectionOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomElectionOnline dataBean = (SomElectionOnline) records[i].toBean(SomElectionOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
