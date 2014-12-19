package com.inspur.cams.sorg.jxcheck.somjxviporgan.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.*;

/**
 * @title:SomJxVipOrganCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxVipOrganCommand extends BaseAjaxCommand{
	private SomJxVipOrganDao dao = (SomJxVipOrganDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrganDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxVipOrgan dataBean=(SomJxVipOrgan)record.toBean(SomJxVipOrgan.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxVipOrgan dataBean=(SomJxVipOrgan)record.toBean(SomJxVipOrgan.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxVipOrgan> list = new ArrayList<SomJxVipOrgan>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxVipOrgan dataBean = (SomJxVipOrgan) records[i].toBean(SomJxVipOrgan.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
