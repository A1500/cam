package com.inspur.cams.sorg.jxcheck.somjxextraplan.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxextraplan.dao.*;

/**
 * @title:SomJxExtraPlanCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxExtraPlanCommand extends BaseAjaxCommand{
	private SomJxExtraPlanDao dao = (SomJxExtraPlanDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxextraplan.dao.SomJxExtraPlanDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxExtraPlan dataBean=(SomJxExtraPlan)record.toBean(SomJxExtraPlan.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxExtraPlan dataBean=(SomJxExtraPlan)record.toBean(SomJxExtraPlan.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxExtraPlan> list = new ArrayList<SomJxExtraPlan>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxExtraPlan dataBean = (SomJxExtraPlan) records[i].toBean(SomJxExtraPlan.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
