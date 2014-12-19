package com.inspur.cams.fis.cremationRate.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.fis.cremationRate.dao.*;
import com.inspur.cams.fis.cremationRate.data.*;
/**
 * @title:FisCremationRateConfigCommand
 * @description:
 * @author:
 * @since:2012-11-16
 * @version:1.0
*/
public class FisCremationRateConfigCommand extends BaseAjaxCommand{
	private FisCremationRateConfigDao dao = (FisCremationRateConfigDao) DaoFactory
			.getDao("com.inspur.cams.fis.cremationRate.dao.FisCremationRateConfigDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		FisCremationRateConfig dataBean=(FisCremationRateConfig)record.toBean(FisCremationRateConfig.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		FisCremationRateConfig dataBean=(FisCremationRateConfig)record.toBean(FisCremationRateConfig.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<FisCremationRateConfig> list = new ArrayList<FisCremationRateConfig>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			FisCremationRateConfig dataBean = (FisCremationRateConfig) records[i].toBean(FisCremationRateConfig.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
