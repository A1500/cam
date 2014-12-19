package com.inspur.cams.sorg.check.somcheckevaluate.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluate;
import com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluateDao;

/**
 * @title:SomCheckEvaluateCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckEvaluateCommand extends BaseAjaxCommand{
	private SomCheckEvaluateDao dao = (SomCheckEvaluateDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckevaluate.dao.SomCheckEvaluateDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckEvaluate dataBean=(SomCheckEvaluate)record.toBean(SomCheckEvaluate.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckEvaluate dataBean=(SomCheckEvaluate)record.toBean(SomCheckEvaluate.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckEvaluate> list = new ArrayList<SomCheckEvaluate>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckEvaluate dataBean = (SomCheckEvaluate) records[i].toBean(SomCheckEvaluate.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
