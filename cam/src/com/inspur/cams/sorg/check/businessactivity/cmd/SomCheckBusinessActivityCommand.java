package com.inspur.cams.sorg.check.businessactivity.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.businessactivity.dao.SomCheckBusinessActivityDao;
import com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity;

/**
 * @title:SomCheckBusinessActivityCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckBusinessActivityCommand extends BaseAjaxCommand{
	private SomCheckBusinessActivityDao dao = (SomCheckBusinessActivityDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.businessactivity.dao.SomCheckBusinessActivityDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckBusinessActivity dataBean=(SomCheckBusinessActivity)record.toBean(SomCheckBusinessActivity.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckBusinessActivity dataBean=(SomCheckBusinessActivity)record.toBean(SomCheckBusinessActivity.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckBusinessActivity> list = new ArrayList<SomCheckBusinessActivity>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckBusinessActivity dataBean = (SomCheckBusinessActivity) records[i].toBean(SomCheckBusinessActivity.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
