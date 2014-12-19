package com.inspur.cams.welfare.config.economic.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.config.economic.dao.WealDicEconomicnature;
import com.inspur.cams.welfare.config.economic.dao.WealDicEconomicnatureDao;

/**
 * @title:WealDicEconomicnatureCommand
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
public class WealDicEconomicnatureCommand extends BaseAjaxCommand{
	private WealDicEconomicnatureDao dao = (WealDicEconomicnatureDao) DaoFactory
			.getDao("com.inspur.cams.welfare.config.economic.dao.WealDicEconomicnatureDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealDicEconomicnature dataBean=(WealDicEconomicnature)record.toBean(WealDicEconomicnature.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealDicEconomicnature dataBean=(WealDicEconomicnature)record.toBean(WealDicEconomicnature.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealDicEconomicnature> list = new ArrayList<WealDicEconomicnature>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealDicEconomicnature dataBean = (WealDicEconomicnature) records[i].toBean(WealDicEconomicnature.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
