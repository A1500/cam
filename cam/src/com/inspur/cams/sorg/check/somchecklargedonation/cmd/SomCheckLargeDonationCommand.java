package com.inspur.cams.sorg.check.somchecklargedonation.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonation;
import com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonationDao;

/**
 * @title:SomCheckLargeDonationCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckLargeDonationCommand extends BaseAjaxCommand{
	private SomCheckLargeDonationDao dao = (SomCheckLargeDonationDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somchecklargedonation.dao.SomCheckLargeDonationDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckLargeDonation dataBean=(SomCheckLargeDonation)record.toBean(SomCheckLargeDonation.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckLargeDonation dataBean=(SomCheckLargeDonation)record.toBean(SomCheckLargeDonation.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckLargeDonation> list = new ArrayList<SomCheckLargeDonation>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckLargeDonation dataBean = (SomCheckLargeDonation) records[i].toBean(SomCheckLargeDonation.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
