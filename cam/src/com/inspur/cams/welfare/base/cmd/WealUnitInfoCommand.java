package com.inspur.cams.welfare.base.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.welfare.base.data.*;
import com.inspur.cams.welfare.base.dao.support.WealUnitInfoDao;

/**
 * @title:WealUnitInfoCommand
 * @description:
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitInfoCommand extends BaseAjaxCommand {
	private WealUnitInfoDao dao = (WealUnitInfoDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealUnitInfoDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealUnitInfo dataBean = (WealUnitInfo) record
				.toBean(WealUnitInfo.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealUnitInfo dataBean = (WealUnitInfo) record
				.toBean(WealUnitInfo.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds = (String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}

	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealUnitInfo> list = new ArrayList<WealUnitInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealUnitInfo dataBean = (WealUnitInfo) records[i]
					.toBean(WealUnitInfo.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
