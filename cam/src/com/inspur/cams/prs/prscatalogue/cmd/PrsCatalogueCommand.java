package com.inspur.cams.prs.prscatalogue.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.prs.prscatalogue.dao.PrsCatalogue;
import com.inspur.cams.prs.prscatalogue.dao.PrsCatalogueDao;

/**
 * @title:PrsCatalogueCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class PrsCatalogueCommand extends BaseAjaxCommand{
	private PrsCatalogueDao dao = (PrsCatalogueDao) DaoFactory
			.getDao("org.prscatalogue.dao.PrsCatalogueDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		PrsCatalogue dataBean=(PrsCatalogue)record.toBean(PrsCatalogue.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		PrsCatalogue dataBean=(PrsCatalogue)record.toBean(PrsCatalogue.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<PrsCatalogue> list = new ArrayList<PrsCatalogue>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			PrsCatalogue dataBean = (PrsCatalogue) records[i].toBean(PrsCatalogue.class);
			list.add(dataBean);
		}
		// do save
		PrsCatalogueDao dao = (PrsCatalogueDao) DaoFactory
				.getDao("org.prscatalogue.dao.PrsCatalogueDao");
		dao.save(list);
	}
}
