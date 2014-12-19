package com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.*;

/**
 * @title:SomJxCheckPunnishCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckPunnishCommand extends BaseAjaxCommand{
	private SomJxCheckPunnishDao dao = (SomJxCheckPunnishDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.SomJxCheckPunnishDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckPunnish dataBean=(SomJxCheckPunnish)record.toBean(SomJxCheckPunnish.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckPunnish dataBean=(SomJxCheckPunnish)record.toBean(SomJxCheckPunnish.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckPunnish> list = new ArrayList<SomJxCheckPunnish>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckPunnish dataBean = (SomJxCheckPunnish) records[i].toBean(SomJxCheckPunnish.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
