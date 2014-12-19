package com.inspur.cams.sorg.check.somcheckpunnish.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnish;
import com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnishDao;

/**
 * @title:SomCheckPunnishCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckPunnishCommand extends BaseAjaxCommand{
	private SomCheckPunnishDao dao = (SomCheckPunnishDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckpunnish.dao.SomCheckPunnishDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckPunnish dataBean=(SomCheckPunnish)record.toBean(SomCheckPunnish.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckPunnish dataBean=(SomCheckPunnish)record.toBean(SomCheckPunnish.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckPunnish> list = new ArrayList<SomCheckPunnish>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckPunnish dataBean = (SomCheckPunnish) records[i].toBean(SomCheckPunnish.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
