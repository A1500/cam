package com.inspur.cams.sorg.online.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.base.dao.support.SomRuleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomRuleOnline;

/**
 * @title:SomRuleOnlineCommand
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
public class SomRuleOnlineCommand extends BaseAjaxCommand{
	private SomRuleOnlineDao dao = (SomRuleOnlineDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.base.dao.support.SomRuleOnlineDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomRuleOnline dataBean=(SomRuleOnline)record.toBean(SomRuleOnline.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomRuleOnline dataBean=(SomRuleOnline)record.toBean(SomRuleOnline.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomRuleOnline> list = new ArrayList<SomRuleOnline>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomRuleOnline dataBean = (SomRuleOnline) records[i].toBean(SomRuleOnline.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
