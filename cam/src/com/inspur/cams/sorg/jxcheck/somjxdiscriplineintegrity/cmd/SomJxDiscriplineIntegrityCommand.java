package com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.*;

/**
 * @title:SomJxDiscriplineIntegrityCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxDiscriplineIntegrityCommand extends BaseAjaxCommand{
	private SomJxDiscriplineIntegrityDao dao = (SomJxDiscriplineIntegrityDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.SomJxDiscriplineIntegrityDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxDiscriplineIntegrity dataBean=(SomJxDiscriplineIntegrity)record.toBean(SomJxDiscriplineIntegrity.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxDiscriplineIntegrity dataBean=(SomJxDiscriplineIntegrity)record.toBean(SomJxDiscriplineIntegrity.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxDiscriplineIntegrity> list = new ArrayList<SomJxDiscriplineIntegrity>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxDiscriplineIntegrity dataBean = (SomJxDiscriplineIntegrity) records[i].toBean(SomJxDiscriplineIntegrity.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
