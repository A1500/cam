package com.inspur.cams.sorg.partycheck.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.partycheck.domain.*;
import com.inspur.cams.sorg.partycheck.data.*;
import com.inspur.cams.sorg.partycheck.dao.*;
/**
 * @title:SomPartyCheckCommand
 * @description:
 * @author:
 * @since:2013-04-26
 * @version:1.0
*/
public class SomPartyCheckCommand extends BaseAjaxCommand{
	private SomPartyCheckDao dao = (SomPartyCheckDao) DaoFactory
			.getDao("com.inspur.cams.sorg.partycheck.dao.SomPartyCheckDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPartyCheck dataBean=(SomPartyCheck)record.toBean(SomPartyCheck.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPartyCheck dataBean=(SomPartyCheck)record.toBean(SomPartyCheck.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPartyCheck> list = new ArrayList<SomPartyCheck>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPartyCheck dataBean = (SomPartyCheck) records[i].toBean(SomPartyCheck.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
