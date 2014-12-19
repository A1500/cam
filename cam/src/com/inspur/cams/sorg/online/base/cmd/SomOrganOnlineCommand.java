package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomOrganOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomOrganOnline;

/**
 * @title:SomOrganOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomOrganOnlineCommand extends BaseAjaxCommand{
	private SomOrganOnlineDao dao = (SomOrganOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomOrganOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomOrganOnline dataBean=(SomOrganOnline)record.toBean(SomOrganOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomOrganOnline dataBean=(SomOrganOnline)record.toBean(SomOrganOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomOrganOnline> list = new ArrayList<SomOrganOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomOrganOnline dataBean = (SomOrganOnline) records[i].toBean(SomOrganOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
