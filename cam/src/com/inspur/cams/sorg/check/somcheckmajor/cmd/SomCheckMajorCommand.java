package com.inspur.cams.sorg.check.somcheckmajor.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajor;
import com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajorDao;

/**
 * @title:SomCheckMajorCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckMajorCommand extends BaseAjaxCommand{
	private SomCheckMajorDao dao = (SomCheckMajorDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckmajor.dao.SomCheckMajorDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckMajor dataBean=(SomCheckMajor)record.toBean(SomCheckMajor.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckMajor dataBean=(SomCheckMajor)record.toBean(SomCheckMajor.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckMajor> list = new ArrayList<SomCheckMajor>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckMajor dataBean = (SomCheckMajor) records[i].toBean(SomCheckMajor.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
