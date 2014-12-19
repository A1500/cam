package com.inspur.cams.sorg.jxcheck.somjxmajordetail.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetail;
import com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao;

/**
 * @title:SomJxMajorDetailCommand
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
public class SomJxMajorDetailCommand extends BaseAjaxCommand{
	private SomJxMajorDetailDao dao = (SomJxMajorDetailDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetailDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxMajorDetail dataBean=(SomJxMajorDetail)record.toBean(SomJxMajorDetail.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxMajorDetail dataBean=(SomJxMajorDetail)record.toBean(SomJxMajorDetail.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxMajorDetail> list = new ArrayList<SomJxMajorDetail>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxMajorDetail dataBean = (SomJxMajorDetail) records[i].toBean(SomJxMajorDetail.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
