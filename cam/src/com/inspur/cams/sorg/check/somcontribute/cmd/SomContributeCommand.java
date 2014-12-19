package com.inspur.cams.sorg.check.somcontribute.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcontribute.dao.SomContribute;
import com.inspur.cams.sorg.check.somcontribute.dao.SomContributeDao;

/**
 * @title:SomContributeCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomContributeCommand extends BaseAjaxCommand{
	private SomContributeDao dao = (SomContributeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcontribute.dao.SomContributeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomContribute dataBean=(SomContribute)record.toBean(SomContribute.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomContribute dataBean=(SomContribute)record.toBean(SomContribute.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomContribute> list = new ArrayList<SomContribute>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomContribute dataBean = (SomContribute) records[i].toBean(SomContribute.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
