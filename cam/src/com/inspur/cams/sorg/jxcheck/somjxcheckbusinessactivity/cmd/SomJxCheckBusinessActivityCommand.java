package com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.*;

/**
 * @title:SomJxCheckBusinessActivityCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckBusinessActivityCommand extends BaseAjaxCommand{
	private SomJxCheckBusinessActivityDao dao = (SomJxCheckBusinessActivityDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivityDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckBusinessActivity dataBean=(SomJxCheckBusinessActivity)record.toBean(SomJxCheckBusinessActivity.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckBusinessActivity dataBean=(SomJxCheckBusinessActivity)record.toBean(SomJxCheckBusinessActivity.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckBusinessActivity> list = new ArrayList<SomJxCheckBusinessActivity>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckBusinessActivity dataBean = (SomJxCheckBusinessActivity) records[i].toBean(SomJxCheckBusinessActivity.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
