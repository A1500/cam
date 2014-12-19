package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitInfoDao;
import com.inspur.cams.welfare.base.data.WealFitInfo;

/**
 * @title:WealFitInfoCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitInfoCommand extends BaseAjaxCommand{
	private WealFitInfoDao dao = (WealFitInfoDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitInfoDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitInfo dataBean=(WealFitInfo)record.toBean(WealFitInfo.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitInfo dataBean=(WealFitInfo)record.toBean(WealFitInfo.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitInfo> list = new ArrayList<WealFitInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitInfo dataBean = (WealFitInfo) records[i].toBean(WealFitInfo.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
