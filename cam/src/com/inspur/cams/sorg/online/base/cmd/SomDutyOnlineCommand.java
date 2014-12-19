package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomDutyOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomDutyOnline;

/**
 * @title:SomDutyOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomDutyOnlineCommand extends BaseAjaxCommand{
	private SomDutyOnlineDao dao = (SomDutyOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomDutyOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomDutyOnline dataBean=(SomDutyOnline)record.toBean(SomDutyOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomDutyOnline dataBean=(SomDutyOnline)record.toBean(SomDutyOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomDutyOnline> list = new ArrayList<SomDutyOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomDutyOnline dataBean = (SomDutyOnline) records[i].toBean(SomDutyOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
