package com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao.*;

/**
 * @title:SomJxCheckInterProjectCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckInterProjectCommand extends BaseAjaxCommand{
	private SomJxCheckInterProjectDao dao = (SomJxCheckInterProjectDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao.SomJxCheckInterProjectDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckInterProject dataBean=(SomJxCheckInterProject)record.toBean(SomJxCheckInterProject.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckInterProject dataBean=(SomJxCheckInterProject)record.toBean(SomJxCheckInterProject.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckInterProject> list = new ArrayList<SomJxCheckInterProject>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckInterProject dataBean = (SomJxCheckInterProject) records[i].toBean(SomJxCheckInterProject.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
