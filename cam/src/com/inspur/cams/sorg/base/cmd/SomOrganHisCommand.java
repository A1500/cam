package com.inspur.cams.sorg.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.base.dao.jdbc.SomOrganHisDao;
import com.inspur.cams.sorg.base.data.SomOrganHis;

/**
 * @title:SomOrganHisCommand
 * @description:
 * @author:
 * @since:2012-05-28
 * @version:1.0
*/
public class SomOrganHisCommand extends BaseAjaxCommand{
	private SomOrganHisDao dao = (SomOrganHisDao) DaoFactory
			.getDao("com.inspur.cams.sorg.base.dao.SomOrganHisDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomOrganHis dataBean=(SomOrganHis)record.toBean(SomOrganHis.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomOrganHis dataBean=(SomOrganHis)record.toBean(SomOrganHis.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomOrganHis> list = new ArrayList<SomOrganHis>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomOrganHis dataBean = (SomOrganHis) records[i].toBean(SomOrganHis.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
