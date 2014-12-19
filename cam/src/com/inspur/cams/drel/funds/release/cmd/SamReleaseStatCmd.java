package com.inspur.cams.drel.funds.release.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.drel.funds.release.dao.support.SamReleaseStatDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseStat;

/**
 * @title:SamReleaseStatCommand
 * @description:
 * @author:
 * @since:2012-06-11
 * @version:1.0
*/
public class SamReleaseStatCmd extends BaseAjaxCommand{
	private SamReleaseStatDao dao = (SamReleaseStatDao) DaoFactory
			.getDao("com.inspur.cams.drel.funds.release.dao.support.SamReleaseStatDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamReleaseStat dataBean=(SamReleaseStat)record.toBean(SamReleaseStat.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamReleaseStat dataBean=(SamReleaseStat)record.toBean(SamReleaseStat.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamReleaseStat> list = new ArrayList<SamReleaseStat>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamReleaseStat dataBean = (SamReleaseStat) records[i].toBean(SamReleaseStat.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
