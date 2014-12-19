package com.inspur.cams.sorg.jxcheck.somjxchangecircs.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.*;

/**
 * @title:SomJxChangeCircsCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxChangeCircsCommand extends BaseAjaxCommand{
	private SomJxChangeCircsDao dao = (SomJxChangeCircsDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.SomJxChangeCircsDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxChangeCircs dataBean=(SomJxChangeCircs)record.toBean(SomJxChangeCircs.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxChangeCircs dataBean=(SomJxChangeCircs)record.toBean(SomJxChangeCircs.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxChangeCircs> list = new ArrayList<SomJxChangeCircs>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxChangeCircs dataBean = (SomJxChangeCircs) records[i].toBean(SomJxChangeCircs.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
