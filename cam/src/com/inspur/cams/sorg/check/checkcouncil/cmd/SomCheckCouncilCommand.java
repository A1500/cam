package com.inspur.cams.sorg.check.checkcouncil.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.checkcouncil.dao.SomCheckCouncilDao;
import com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil;

/**
 * @title:SomCheckCouncilCommand
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
public class SomCheckCouncilCommand extends BaseAjaxCommand{
	private SomCheckCouncilDao dao = (SomCheckCouncilDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkcouncil.dao.SomCheckCouncilDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckCouncil dataBean=(SomCheckCouncil)record.toBean(SomCheckCouncil.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckCouncil dataBean=(SomCheckCouncil)record.toBean(SomCheckCouncil.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckCouncil> list = new ArrayList<SomCheckCouncil>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckCouncil dataBean = (SomCheckCouncil) records[i].toBean(SomCheckCouncil.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
