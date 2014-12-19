package com.inspur.cams.sorg.check.checkpublication.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkpublication.dao.SomCheckPublicationDao;
import com.inspur.cams.sorg.check.checkpublication.data.SomCheckPublication;

/**
 * @title:SomCheckPublicationCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckPublicationCommand extends BaseAjaxCommand{
	private SomCheckPublicationDao dao = (SomCheckPublicationDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkpublication.dao.SomCheckPublicationDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckPublication dataBean=(SomCheckPublication)record.toBean(SomCheckPublication.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckPublication dataBean=(SomCheckPublication)record.toBean(SomCheckPublication.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckPublication> list = new ArrayList<SomCheckPublication>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckPublication dataBean = (SomCheckPublication) records[i].toBean(SomCheckPublication.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
