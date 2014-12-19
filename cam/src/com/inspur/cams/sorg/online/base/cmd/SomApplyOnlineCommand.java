package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.online.base.dao.support.SomApplyOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomApplyOnline;

/**
 * @title:SomApplyOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
public class SomApplyOnlineCommand extends BaseAjaxCommand{
	private SomApplyOnlineDao dao = (SomApplyOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomApplyOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomApplyOnline dataBean=(SomApplyOnline)record.toBean(SomApplyOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomApplyOnline dataBean=(SomApplyOnline)record.toBean(SomApplyOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomApplyOnline> list = new ArrayList<SomApplyOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomApplyOnline dataBean = (SomApplyOnline) records[i].toBean(SomApplyOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	
	public void updateSomApply() {
		Record SomApplyOnlineRecord = (Record) getParameter("SomApplyOnlineRecord");
		SomApplyOnline somApplyOnline= (SomApplyOnline)SomApplyOnlineRecord.toBean(SomApplyOnline.class);
		dao.update(somApplyOnline);
	}
}
