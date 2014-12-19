package com.inspur.cams.sorg.check.checkdonatedetail.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkdonatedetail.dao.SomCheckDonateDetailDao;
import com.inspur.cams.sorg.check.checkdonatedetail.data.SomCheckDonateDetail;


/**
 * @title:SomCheckDonateDetailCommand
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
public class SomCheckDonateDetailCommand extends BaseAjaxCommand{
	private SomCheckDonateDetailDao dao = (SomCheckDonateDetailDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkdonatedetail.dao.SomCheckDonateDetailDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckDonateDetail dataBean=(SomCheckDonateDetail)record.toBean(SomCheckDonateDetail.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckDonateDetail dataBean=(SomCheckDonateDetail)record.toBean(SomCheckDonateDetail.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckDonateDetail> list = new ArrayList<SomCheckDonateDetail>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckDonateDetail dataBean = (SomCheckDonateDetail) records[i].toBean(SomCheckDonateDetail.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
