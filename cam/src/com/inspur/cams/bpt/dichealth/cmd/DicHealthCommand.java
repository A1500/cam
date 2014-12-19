package com.inspur.cams.bpt.dichealth.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.bpt.dichealth.dao.DicHealth;
import com.inspur.cams.bpt.dichealth.dao.DicHealthDao;

/**
 * @title:DicHealthCommand
 * @description:
 * @author:
 * @since:2011-12-26
 * @version:1.0
*/
public class DicHealthCommand extends BaseAjaxCommand{
	private DicHealthDao dao = (DicHealthDao) DaoFactory
			.getDao("com.inspur.cams.bpt.dichealth.dao.DicHealthDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		DicHealth dataBean=(DicHealth)record.toBean(DicHealth.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		DicHealth dataBean=(DicHealth)record.toBean(DicHealth.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<DicHealth> list = new ArrayList<DicHealth>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			DicHealth dataBean = (DicHealth) records[i].toBean(DicHealth.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
