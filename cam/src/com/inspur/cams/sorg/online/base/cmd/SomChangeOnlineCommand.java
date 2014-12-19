package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomChangeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomChangeOnline;

/**
 * @title:SomChangeOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-12
 * @version:1.0
*/
public class SomChangeOnlineCommand extends BaseAjaxCommand{
	private SomChangeOnlineDao dao = (SomChangeOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomChangeOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomChangeOnline dataBean=(SomChangeOnline)record.toBean(SomChangeOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomChangeOnline dataBean=(SomChangeOnline)record.toBean(SomChangeOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomChangeOnline> list = new ArrayList<SomChangeOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomChangeOnline dataBean = (SomChangeOnline) records[i].toBean(SomChangeOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
