package com.inspur.cams.sorg.jxcheck.somjxlargedonation.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonation;
import com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonationDao;

/**
 * @title:SomJxLargeDonationCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxLargeDonationCommand extends BaseAjaxCommand{
	private SomJxLargeDonationDao dao = (SomJxLargeDonationDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonationDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxLargeDonation dataBean=(SomJxLargeDonation)record.toBean(SomJxLargeDonation.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxLargeDonation dataBean=(SomJxLargeDonation)record.toBean(SomJxLargeDonation.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxLargeDonation> list = new ArrayList<SomJxLargeDonation>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxLargeDonation dataBean = (SomJxLargeDonation) records[i].toBean(SomJxLargeDonation.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
