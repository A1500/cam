package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDao;
import com.inspur.cams.welfare.base.data.WealFitChangerecord;

/**
 * @title:WealFitChangerecordCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitChangerecordCommand extends BaseAjaxCommand{
	private WealFitChangerecordDao dao = (WealFitChangerecordDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitChangerecord dataBean=(WealFitChangerecord)record.toBean(WealFitChangerecord.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitChangerecord dataBean=(WealFitChangerecord)record.toBean(WealFitChangerecord.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitChangerecord> list = new ArrayList<WealFitChangerecord>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitChangerecord dataBean = (WealFitChangerecord) records[i].toBean(WealFitChangerecord.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
