package com.inspur.cams.welfare.config.device.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.config.device.dao.WealDicFitdevice;
import com.inspur.cams.welfare.config.device.dao.WealDicFitdeviceDao;

/**
 * @title:WealDicFitdeviceCommand
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
public class WealDicFitdeviceCommand extends BaseAjaxCommand{
	private WealDicFitdeviceDao dao = (WealDicFitdeviceDao) DaoFactory
			.getDao("com.inspur.cams.welfare.config.device.dao.WealDicFitdeviceDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealDicFitdevice dataBean=(WealDicFitdevice)record.toBean(WealDicFitdevice.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealDicFitdevice dataBean=(WealDicFitdevice)record.toBean(WealDicFitdevice.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealDicFitdevice> list = new ArrayList<WealDicFitdevice>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealDicFitdevice dataBean = (WealDicFitdevice) records[i].toBean(WealDicFitdevice.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
