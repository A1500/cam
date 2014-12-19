package com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.*;

/**
 * @title:SomJxCheckSupervisorOpinCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckSupervisorOpinCommand extends BaseAjaxCommand{
	private SomJxCheckSupervisorOpinDao dao = (SomJxCheckSupervisorOpinDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.SomJxCheckSupervisorOpinDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckSupervisorOpin dataBean=(SomJxCheckSupervisorOpin)record.toBean(SomJxCheckSupervisorOpin.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckSupervisorOpin dataBean=(SomJxCheckSupervisorOpin)record.toBean(SomJxCheckSupervisorOpin.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckSupervisorOpin> list = new ArrayList<SomJxCheckSupervisorOpin>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckSupervisorOpin dataBean = (SomJxCheckSupervisorOpin) records[i].toBean(SomJxCheckSupervisorOpin.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
