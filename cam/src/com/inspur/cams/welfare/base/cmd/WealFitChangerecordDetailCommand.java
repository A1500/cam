package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDetailDao;
import com.inspur.cams.welfare.base.data.WealFitChangerecordDetail;

/**
 * @title:WealFitChangerecordDetailCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitChangerecordDetailCommand extends BaseAjaxCommand{
	private WealFitChangerecordDetailDao dao = (WealFitChangerecordDetailDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitChangerecordDetailDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitChangerecordDetail dataBean=(WealFitChangerecordDetail)record.toBean(WealFitChangerecordDetail.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitChangerecordDetail dataBean=(WealFitChangerecordDetail)record.toBean(WealFitChangerecordDetail.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitChangerecordDetail> list = new ArrayList<WealFitChangerecordDetail>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitChangerecordDetail dataBean = (WealFitChangerecordDetail) records[i].toBean(WealFitChangerecordDetail.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
