package com.inspur.cams.sorg.check.checkevent.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkevent.dao.SomCheckEventDao;
import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;

/**
 * @title:SomCheckEventCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckEventCommand extends BaseAjaxCommand{
	private SomCheckEventDao dao = (SomCheckEventDao) DaoFactory.getDao("com.inspur.cams.sorg.check.checkevent.dao.SomCheckEventDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckEvent dataBean=(SomCheckEvent)record.toBean(SomCheckEvent.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckEvent dataBean=(SomCheckEvent)record.toBean(SomCheckEvent.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckEvent> list = new ArrayList<SomCheckEvent>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckEvent dataBean = (SomCheckEvent) records[i].toBean(SomCheckEvent.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
