package com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.*;

/**
 * @title:SomJxCheckInMarketCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckInMarketCommand extends BaseAjaxCommand{
	private SomJxCheckInMarketDao dao = (SomJxCheckInMarketDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.SomJxCheckInMarketDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckInMarket dataBean=(SomJxCheckInMarket)record.toBean(SomJxCheckInMarket.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckInMarket dataBean=(SomJxCheckInMarket)record.toBean(SomJxCheckInMarket.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckInMarket> list = new ArrayList<SomJxCheckInMarket>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckInMarket dataBean = (SomJxCheckInMarket) records[i].toBean(SomJxCheckInMarket.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
