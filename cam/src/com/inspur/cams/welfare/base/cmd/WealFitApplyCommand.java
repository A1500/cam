package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitApplyDao;
import com.inspur.cams.welfare.base.data.WealFitApply;

/**
 * @title:WealFitApplyCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitApplyCommand extends BaseAjaxCommand{
	private WealFitApplyDao dao = (WealFitApplyDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitApplyDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitApply dataBean=(WealFitApply)record.toBean(WealFitApply.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitApply dataBean=(WealFitApply)record.toBean(WealFitApply.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitApply> list = new ArrayList<WealFitApply>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitApply dataBean = (WealFitApply) records[i].toBean(WealFitApply.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
