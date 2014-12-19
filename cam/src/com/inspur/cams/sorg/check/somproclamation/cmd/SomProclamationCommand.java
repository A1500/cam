package com.inspur.cams.sorg.check.somproclamation.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somproclamation.dao.SomProclamation;
import com.inspur.cams.sorg.check.somproclamation.dao.SomProclamationDao;

/**
 * @title:SomProclamationCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomProclamationCommand extends BaseAjaxCommand{
	private SomProclamationDao dao = (SomProclamationDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somproclamation.dao.SomProclamationDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomProclamation dataBean=(SomProclamation)record.toBean(SomProclamation.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomProclamation dataBean=(SomProclamation)record.toBean(SomProclamation.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomProclamation> list = new ArrayList<SomProclamation>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomProclamation dataBean = (SomProclamation) records[i].toBean(SomProclamation.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
