package com.inspur.cams.welfare.base.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.welfare.base.data.*;
import com.inspur.cams.welfare.base.dao.support.WealUnitStatusDao;

/**
 * @title:WealUnitStatusCommand
 * @description:
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitStatusCommand extends BaseAjaxCommand {
	private WealUnitStatusDao dao = (WealUnitStatusDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitStatusDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealUnitStatus dataBean = (WealUnitStatus) record
				.toBean(WealUnitStatus.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealUnitStatus dataBean = (WealUnitStatus) record
				.toBean(WealUnitStatus.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}

	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealUnitStatus> list = new ArrayList<WealUnitStatus>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealUnitStatus dataBean = (WealUnitStatus) records[i]
					.toBean(WealUnitStatus.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
