package com.inspur.cams.sorg.check.checkinterorg.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkinterorg.dao.SomCheckInterOrgDao;
import com.inspur.cams.sorg.check.checkinterorg.data.SomCheckInterOrg;

/**
 * @title:SomCheckInterOrgCommand
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
public class SomCheckInterOrgCommand extends BaseAjaxCommand{
	private SomCheckInterOrgDao dao = (SomCheckInterOrgDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkinterorg.dao.SomCheckInterOrgDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckInterOrg dataBean=(SomCheckInterOrg)record.toBean(SomCheckInterOrg.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckInterOrg dataBean=(SomCheckInterOrg)record.toBean(SomCheckInterOrg.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckInterOrg> list = new ArrayList<SomCheckInterOrg>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckInterOrg dataBean = (SomCheckInterOrg) records[i].toBean(SomCheckInterOrg.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
