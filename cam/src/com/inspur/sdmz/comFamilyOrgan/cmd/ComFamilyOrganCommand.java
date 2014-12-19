package com.inspur.sdmz.comFamilyOrgan.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.sdmz.comFamilyOrgan.dao.*;

/**
 * @title:ComFamilyOrganCommand
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
public class ComFamilyOrganCommand extends BaseAjaxCommand{
	private ComFamilyOrganDao dao = (ComFamilyOrganDao) DaoFactory
			.getDao("com.inspur.sdmz.comFamilyOrgan.dao.ComFamilyOrganDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		ComFamilyOrgan dataBean=(ComFamilyOrgan)record.toBean(ComFamilyOrgan.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		ComFamilyOrgan dataBean=(ComFamilyOrgan)record.toBean(ComFamilyOrgan.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<ComFamilyOrgan> list = new ArrayList<ComFamilyOrgan>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			ComFamilyOrgan dataBean = (ComFamilyOrgan) records[i].toBean(ComFamilyOrgan.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
