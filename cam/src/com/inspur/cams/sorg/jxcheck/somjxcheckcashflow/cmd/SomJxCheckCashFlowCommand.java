package com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.*;

/**
 * @title:SomJxCheckCashFlowCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckCashFlowCommand extends BaseAjaxCommand{
	private SomJxCheckCashFlowDao dao = (SomJxCheckCashFlowDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlowDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckCashFlow dataBean=(SomJxCheckCashFlow)record.toBean(SomJxCheckCashFlow.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckCashFlow dataBean=(SomJxCheckCashFlow)record.toBean(SomJxCheckCashFlow.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckCashFlow> list = new ArrayList<SomJxCheckCashFlow>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckCashFlow dataBean = (SomJxCheckCashFlow) records[i].toBean(SomJxCheckCashFlow.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
