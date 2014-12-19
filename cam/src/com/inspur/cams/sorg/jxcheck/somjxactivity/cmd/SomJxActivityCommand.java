package com.inspur.cams.sorg.jxcheck.somjxactivity.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxactivity.dao.*;

/**
 * @title:SomJxActivityCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxActivityCommand extends BaseAjaxCommand{
	private SomJxActivityDao dao = (SomJxActivityDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivityDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxActivity dataBean=(SomJxActivity)record.toBean(SomJxActivity.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxActivity dataBean=(SomJxActivity)record.toBean(SomJxActivity.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxActivity> list = new ArrayList<SomJxActivity>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxActivity dataBean = (SomJxActivity) records[i].toBean(SomJxActivity.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
