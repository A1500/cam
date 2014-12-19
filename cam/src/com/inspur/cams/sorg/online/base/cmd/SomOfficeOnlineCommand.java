package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomOfficeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomOfficeOnline;

/**
 * @title:SomOfficeOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-26
 * @version:1.0
*/
public class SomOfficeOnlineCommand extends BaseAjaxCommand{
	private SomOfficeOnlineDao dao = (SomOfficeOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomOfficeOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomOfficeOnline dataBean=(SomOfficeOnline)record.toBean(SomOfficeOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomOfficeOnline dataBean=(SomOfficeOnline)record.toBean(SomOfficeOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomOfficeOnline> list = new ArrayList<SomOfficeOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomOfficeOnline dataBean = (SomOfficeOnline) records[i].toBean(SomOfficeOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
