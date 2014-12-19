package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomLiqpeopleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomLiqpeopleOnline;

/**
 * @title:SomLiqpeopleOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-14
 * @version:1.0
*/
public class SomLiqpeopleOnlineCommand extends BaseAjaxCommand{
	private SomLiqpeopleOnlineDao dao = (SomLiqpeopleOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomLiqpeopleOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomLiqpeopleOnline dataBean=(SomLiqpeopleOnline)record.toBean(SomLiqpeopleOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomLiqpeopleOnline dataBean=(SomLiqpeopleOnline)record.toBean(SomLiqpeopleOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomLiqpeopleOnline> list = new ArrayList<SomLiqpeopleOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomLiqpeopleOnline dataBean = (SomLiqpeopleOnline) records[i].toBean(SomLiqpeopleOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
