package com.inspur.cams.marry.base.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.marry.base.dao.*;

/**
 * @title:MrmExamApplyCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class MrmExamApplyCommand extends BaseAjaxCommand{
	private MrmExamApplyDao dao = (MrmExamApplyDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.MrmExamApplyDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		MrmExamApply dataBean=(MrmExamApply)record.toBean(MrmExamApply.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		MrmExamApply dataBean=(MrmExamApply)record.toBean(MrmExamApply.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<MrmExamApply> list = new ArrayList<MrmExamApply>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmExamApply dataBean = (MrmExamApply) records[i].toBean(MrmExamApply.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
