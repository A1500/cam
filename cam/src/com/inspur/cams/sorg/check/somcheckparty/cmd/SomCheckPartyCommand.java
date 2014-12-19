package com.inspur.cams.sorg.check.somcheckparty.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckParty;
import com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckPartyDao;

/**
 * @title:SomCheckPartyCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckPartyCommand extends BaseAjaxCommand{
	private SomCheckPartyDao dao = (SomCheckPartyDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckPartyDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckParty dataBean=(SomCheckParty)record.toBean(SomCheckParty.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckParty dataBean=(SomCheckParty)record.toBean(SomCheckParty.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckParty> list = new ArrayList<SomCheckParty>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckParty dataBean = (SomCheckParty) records[i].toBean(SomCheckParty.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
