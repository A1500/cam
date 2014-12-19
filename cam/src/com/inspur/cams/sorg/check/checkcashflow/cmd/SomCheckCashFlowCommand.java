package com.inspur.cams.sorg.check.checkcashflow.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.checkcashflow.dao.SomCheckCashFlowDao;
import com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow;

/**
 * @title:现金流量表Command
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
 */
public class SomCheckCashFlowCommand extends BaseAjaxCommand {
	private SomCheckCashFlowDao dao = (SomCheckCashFlowDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkcashflow.dao.SomCheckCashFlowDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckCashFlow dataBean = (SomCheckCashFlow) record
				.toBean(SomCheckCashFlow.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckCashFlow dataBean = (SomCheckCashFlow) record
				.toBean(SomCheckCashFlow.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}

	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckCashFlow> list = new ArrayList<SomCheckCashFlow>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckCashFlow dataBean = (SomCheckCashFlow) records[i]
					.toBean(SomCheckCashFlow.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
