package com.inspur.cams.sorg.jxcheck.somjxcheckmajor.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajor;
import com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajorDao;

/**
 * @title:SomJxCheckMajorCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxCheckMajorCommand extends BaseAjaxCommand{
	private SomJxCheckMajorDao dao = (SomJxCheckMajorDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajorDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckMajor dataBean=(SomJxCheckMajor)record.toBean(SomJxCheckMajor.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckMajor dataBean=(SomJxCheckMajor)record.toBean(SomJxCheckMajor.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckMajor> list = new ArrayList<SomJxCheckMajor>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckMajor dataBean = (SomJxCheckMajor) records[i].toBean(SomJxCheckMajor.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
