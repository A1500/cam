package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomPartyPraiseOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPartyPraiseOnline;

/**
 * @title:SomPartyPraiseOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
public class SomPartyPraiseOnlineCommand extends BaseAjaxCommand{
	private SomPartyPraiseOnlineDao dao = (SomPartyPraiseOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomPartyPraiseOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPartyPraiseOnline dataBean=(SomPartyPraiseOnline)record.toBean(SomPartyPraiseOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPartyPraiseOnline dataBean=(SomPartyPraiseOnline)record.toBean(SomPartyPraiseOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPartyPraiseOnline> list = new ArrayList<SomPartyPraiseOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPartyPraiseOnline dataBean = (SomPartyPraiseOnline) records[i].toBean(SomPartyPraiseOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
