package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.welfare.base.dao.support.WealFitDeviceDao;
import com.inspur.cams.welfare.base.data.WealFitDevice;

/**
 * @title:WealFitDeviceCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitDeviceCommand extends BaseAjaxCommand{
	private WealFitDeviceDao dao = (WealFitDeviceDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitDeviceDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitDevice dataBean=(WealFitDevice)record.toBean(WealFitDevice.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitDevice dataBean=(WealFitDevice)record.toBean(WealFitDevice.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitDevice> list = new ArrayList<WealFitDevice>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitDevice dataBean = (WealFitDevice) records[i].toBean(WealFitDevice.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
