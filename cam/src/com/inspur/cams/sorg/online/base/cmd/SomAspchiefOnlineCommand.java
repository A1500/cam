package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomAspchiefOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomAspchiefOnline;

/**
 * @title:SomAspchiefOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomAspchiefOnlineCommand extends BaseAjaxCommand{
	private SomAspchiefOnlineDao dao = (SomAspchiefOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomAspchiefOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomAspchiefOnline dataBean=(SomAspchiefOnline)record.toBean(SomAspchiefOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomAspchiefOnline dataBean=(SomAspchiefOnline)record.toBean(SomAspchiefOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomAspchiefOnline> list = new ArrayList<SomAspchiefOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomAspchiefOnline dataBean = (SomAspchiefOnline) records[i].toBean(SomAspchiefOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
