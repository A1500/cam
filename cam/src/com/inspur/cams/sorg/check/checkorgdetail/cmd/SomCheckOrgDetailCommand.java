package com.inspur.cams.sorg.check.checkorgdetail.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.check.checkorgdetail.dao.SomCheckOrgDetailDao;
import com.inspur.cams.sorg.check.checkorgdetail.data.SomCheckOrgDetail;

/**
 * @title:SomCheckOrgDetailCommand
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
public class SomCheckOrgDetailCommand extends BaseAjaxCommand{
	private SomCheckOrgDetailDao dao = (SomCheckOrgDetailDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkorgdetail.dao.SomCheckOrgDetailDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckOrgDetail dataBean=(SomCheckOrgDetail)record.toBean(SomCheckOrgDetail.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckOrgDetail dataBean=(SomCheckOrgDetail)record.toBean(SomCheckOrgDetail.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckOrgDetail> list = new ArrayList<SomCheckOrgDetail>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckOrgDetail dataBean = (SomCheckOrgDetail) records[i].toBean(SomCheckOrgDetail.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
