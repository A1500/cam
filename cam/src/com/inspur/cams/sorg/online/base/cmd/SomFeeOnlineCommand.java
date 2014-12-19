package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomFeeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomFeeOnline;

/**
 * @title:SomFeeOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomFeeOnlineCommand extends BaseAjaxCommand{
	private SomFeeOnlineDao dao = (SomFeeOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomFeeOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomFeeOnline dataBean=(SomFeeOnline)record.toBean(SomFeeOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomFeeOnline dataBean=(SomFeeOnline)record.toBean(SomFeeOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomFeeOnline> list = new ArrayList<SomFeeOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomFeeOnline dataBean = (SomFeeOnline) records[i].toBean(SomFeeOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
