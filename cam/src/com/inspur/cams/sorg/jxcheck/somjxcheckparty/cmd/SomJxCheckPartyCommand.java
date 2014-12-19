package com.inspur.cams.sorg.jxcheck.somjxcheckparty.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.*;

/**
 * @title:SomJxCheckPartyCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckPartyCommand extends BaseAjaxCommand{
	private SomJxCheckPartyDao dao = (SomJxCheckPartyDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckPartyDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckParty dataBean=(SomJxCheckParty)record.toBean(SomJxCheckParty.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckParty dataBean=(SomJxCheckParty)record.toBean(SomJxCheckParty.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckParty> list = new ArrayList<SomJxCheckParty>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckParty dataBean = (SomJxCheckParty) records[i].toBean(SomJxCheckParty.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
