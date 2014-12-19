package com.inspur.cams.sorg.check.somcheckmajordetail.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetail;
import com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetailDao;

/**
 * @title:SomCheckMajorDetailCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckMajorDetailCommand extends BaseAjaxCommand{
	private SomCheckMajorDetailDao dao = (SomCheckMajorDetailDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somcheckmajordetail.dao.SomCheckMajorDetailDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckMajorDetail dataBean=(SomCheckMajorDetail)record.toBean(SomCheckMajorDetail.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckMajorDetail dataBean=(SomCheckMajorDetail)record.toBean(SomCheckMajorDetail.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckMajorDetail> list = new ArrayList<SomCheckMajorDetail>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckMajorDetail dataBean = (SomCheckMajorDetail) records[i].toBean(SomCheckMajorDetail.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
