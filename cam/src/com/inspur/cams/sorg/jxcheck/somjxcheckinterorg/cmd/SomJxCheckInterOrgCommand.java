package com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.*;

/**
 * @title:SomJxCheckInterOrgCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckInterOrgCommand extends BaseAjaxCommand{
	private SomJxCheckInterOrgDao dao = (SomJxCheckInterOrgDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckInterOrg dataBean=(SomJxCheckInterOrg)record.toBean(SomJxCheckInterOrg.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckInterOrg dataBean=(SomJxCheckInterOrg)record.toBean(SomJxCheckInterOrg.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckInterOrg> list = new ArrayList<SomJxCheckInterOrg>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckInterOrg dataBean = (SomJxCheckInterOrg) records[i].toBean(SomJxCheckInterOrg.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
