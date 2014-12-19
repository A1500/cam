package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao;
import com.inspur.cams.bpt.edoc.data.BptCatalogueArchives;

/**
 * @title:BptCatalogueArchivesCommand
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
public class BptCatalogueArchivesCommand extends BaseAjaxCommand{
	private BptCatalogueArchivesDao dao = (BptCatalogueArchivesDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCatalogueArchivesDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptCatalogueArchives dataBean=(BptCatalogueArchives)record.toBean(BptCatalogueArchives.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptCatalogueArchives dataBean=(BptCatalogueArchives)record.toBean(BptCatalogueArchives.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptCatalogueArchives> list = new ArrayList<BptCatalogueArchives>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptCatalogueArchives dataBean = (BptCatalogueArchives) records[i].toBean(BptCatalogueArchives.class);
			list.add(dataBean);
		}
		dao.save(list);
	}
}
