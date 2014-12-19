package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomHeldOrganOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomHeldOrganOnline;

/**
 * @title:SomHeldOrganOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomHeldOrganOnlineCommand extends BaseAjaxCommand{
	private SomHeldOrganOnlineDao dao = (SomHeldOrganOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomHeldOrganOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomHeldOrganOnline dataBean=(SomHeldOrganOnline)record.toBean(SomHeldOrganOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomHeldOrganOnline dataBean=(SomHeldOrganOnline)record.toBean(SomHeldOrganOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomHeldOrganOnline> list = new ArrayList<SomHeldOrganOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomHeldOrganOnline dataBean = (SomHeldOrganOnline) records[i].toBean(SomHeldOrganOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
