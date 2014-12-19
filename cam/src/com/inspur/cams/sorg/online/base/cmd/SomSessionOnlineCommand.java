package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomSessionOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomSessionOnline;

/**
 * @title:SomSessionOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomSessionOnlineCommand extends BaseAjaxCommand{
	private SomSessionOnlineDao dao = (SomSessionOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomSessionOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomSessionOnline dataBean=(SomSessionOnline)record.toBean(SomSessionOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomSessionOnline dataBean=(SomSessionOnline)record.toBean(SomSessionOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomSessionOnline> list = new ArrayList<SomSessionOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomSessionOnline dataBean = (SomSessionOnline) records[i].toBean(SomSessionOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
