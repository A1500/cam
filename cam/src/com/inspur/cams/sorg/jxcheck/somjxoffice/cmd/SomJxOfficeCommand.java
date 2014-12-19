package com.inspur.cams.sorg.jxcheck.somjxoffice.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxoffice.dao.*;

/**
 * @title:SomJxOfficeCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxOfficeCommand extends BaseAjaxCommand{
	private SomJxOfficeDao dao = (SomJxOfficeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxoffice.dao.SomJxOfficeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxOffice dataBean=(SomJxOffice)record.toBean(SomJxOffice.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxOffice dataBean=(SomJxOffice)record.toBean(SomJxOffice.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxOffice> list = new ArrayList<SomJxOffice>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxOffice dataBean = (SomJxOffice) records[i].toBean(SomJxOffice.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
