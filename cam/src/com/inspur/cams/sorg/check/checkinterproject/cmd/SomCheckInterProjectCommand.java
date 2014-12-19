package com.inspur.cams.sorg.check.checkinterproject.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkinterproject.dao.SomCheckInterProjectDao;
import com.inspur.cams.sorg.check.checkinterproject.data.SomCheckInterProject;

/**
 * @title:SomCheckInterProjectCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckInterProjectCommand extends BaseAjaxCommand{
	private SomCheckInterProjectDao dao = (SomCheckInterProjectDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkinterproject.dao.SomCheckInterProjectDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckInterProject dataBean=(SomCheckInterProject)record.toBean(SomCheckInterProject.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckInterProject dataBean=(SomCheckInterProject)record.toBean(SomCheckInterProject.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckInterProject> list = new ArrayList<SomCheckInterProject>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckInterProject dataBean = (SomCheckInterProject) records[i].toBean(SomCheckInterProject.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
