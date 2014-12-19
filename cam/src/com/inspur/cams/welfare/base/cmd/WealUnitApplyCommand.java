package com.inspur.cams.welfare.base.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.welfare.base.data.*;
import com.inspur.cams.welfare.base.dao.support.WealUnitApplyDao;

/**
 * @title:WealUnitApplyCommand
 * @description:
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitApplyCommand extends BaseAjaxCommand {
	private WealUnitApplyDao dao = (WealUnitApplyDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitApplyDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealUnitApply dataBean = (WealUnitApply) record
				.toBean(WealUnitApply.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealUnitApply dataBean = (WealUnitApply) record
				.toBean(WealUnitApply.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}

	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealUnitApply> list = new ArrayList<WealUnitApply>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealUnitApply dataBean = (WealUnitApply) records[i]
					.toBean(WealUnitApply.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
