package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomElectronicOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomElectronicOnline;

/**
 * @title:SomElectronicOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomElectronicOnlineCommand extends BaseAjaxCommand{
	private SomElectronicOnlineDao dao = (SomElectronicOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomElectronicOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomElectronicOnline dataBean=(SomElectronicOnline)record.toBean(SomElectronicOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomElectronicOnline dataBean=(SomElectronicOnline)record.toBean(SomElectronicOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomElectronicOnline> list = new ArrayList<SomElectronicOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomElectronicOnline dataBean = (SomElectronicOnline) records[i].toBean(SomElectronicOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
