package com.inspur.cams.sorg.check.checksuborgan.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.checksuborgan.dao.SomCheckSuborganDao;
import com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan;

/**
 * @title:分支、代表、办事、专项基金管理机构情况Command
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckSuborganCommand extends BaseAjaxCommand{
	private SomCheckSuborganDao dao = (SomCheckSuborganDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checksuborgan.dao.SomCheckSuborganDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckSuborgan dataBean=(SomCheckSuborgan)record.toBean(SomCheckSuborgan.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckSuborgan dataBean=(SomCheckSuborgan)record.toBean(SomCheckSuborgan.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckSuborgan> list = new ArrayList<SomCheckSuborgan>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckSuborgan dataBean = (SomCheckSuborgan) records[i].toBean(SomCheckSuborgan.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
