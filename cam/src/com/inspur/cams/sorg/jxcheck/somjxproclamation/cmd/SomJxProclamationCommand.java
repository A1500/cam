package com.inspur.cams.sorg.jxcheck.somjxproclamation.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.*;

/**
 * @title:SomJxProclamationCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxProclamationCommand extends BaseAjaxCommand{
	private SomJxProclamationDao dao = (SomJxProclamationDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxproclamation.dao.SomJxProclamationDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxProclamation dataBean=(SomJxProclamation)record.toBean(SomJxProclamation.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxProclamation dataBean=(SomJxProclamation)record.toBean(SomJxProclamation.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxProclamation> list = new ArrayList<SomJxProclamation>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxProclamation dataBean = (SomJxProclamation) records[i].toBean(SomJxProclamation.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
