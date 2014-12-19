package com.inspur.cams.bpt.manage.cmd;


import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptRegulationsTypeDao;
import com.inspur.cams.bpt.base.data.BptRegulationsType;

/**
 * @title:BptRegulationsTypeCommand
 * @description:
 * @author:
 * @since:2011-12-13
 * @version:1.0
*/
public class BptRegulationsTypeCommand extends BaseAjaxCommand{
	private BptRegulationsTypeDao dao = (BptRegulationsTypeDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptRegulationsTypeDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptRegulationsType dataBean=(BptRegulationsType)record.toBean(BptRegulationsType.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptRegulationsType dataBean=(BptRegulationsType)record.toBean(BptRegulationsType.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptRegulationsType> list = new ArrayList<BptRegulationsType>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptRegulationsType dataBean = (BptRegulationsType) records[i].toBean(BptRegulationsType.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
