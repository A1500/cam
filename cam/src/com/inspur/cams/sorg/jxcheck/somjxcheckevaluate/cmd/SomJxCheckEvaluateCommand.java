package com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.*;

/**
 * @title:SomJxCheckEvaluateCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckEvaluateCommand extends BaseAjaxCommand{
	private SomJxCheckEvaluateDao dao = (SomJxCheckEvaluateDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluateDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckEvaluate dataBean=(SomJxCheckEvaluate)record.toBean(SomJxCheckEvaluate.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckEvaluate dataBean=(SomJxCheckEvaluate)record.toBean(SomJxCheckEvaluate.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckEvaluate> list = new ArrayList<SomJxCheckEvaluate>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckEvaluate dataBean = (SomJxCheckEvaluate) records[i].toBean(SomJxCheckEvaluate.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
