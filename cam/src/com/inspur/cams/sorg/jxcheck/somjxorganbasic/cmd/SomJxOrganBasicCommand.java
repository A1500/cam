package com.inspur.cams.sorg.jxcheck.somjxorganbasic.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.*;

/**
 * @title:SomJxOrganBasicCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxOrganBasicCommand extends BaseAjaxCommand{
	private SomJxOrganBasicDao dao = (SomJxOrganBasicDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasicDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxOrganBasic dataBean=(SomJxOrganBasic)record.toBean(SomJxOrganBasic.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxOrganBasic dataBean=(SomJxOrganBasic)record.toBean(SomJxOrganBasic.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxOrganBasic> list = new ArrayList<SomJxOrganBasic>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxOrganBasic dataBean = (SomJxOrganBasic) records[i].toBean(SomJxOrganBasic.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
