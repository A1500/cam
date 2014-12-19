package com.inspur.cams.drel.archive.baseinfofamilyarchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc.BaseinfoFamilyArchiveDao;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;

/**
 * @title:BaseinfoFamilyArchiveCommand
 * @description:
 * @author:
 * @since:2012-05-30
 * @version:1.0
*/
public class BaseinfoFamilyArchiveCmd extends BaseAjaxCommand{
	private BaseinfoFamilyArchiveDao dao = (BaseinfoFamilyArchiveDao) DaoFactory
	.getDao("com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc.BaseinfoFamilyArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		BaseinfoFamilyArchive dataBean=(BaseinfoFamilyArchive)record.toBean(BaseinfoFamilyArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		BaseinfoFamilyArchive dataBean=(BaseinfoFamilyArchive)record.toBean(BaseinfoFamilyArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BaseinfoFamilyArchive> list = new ArrayList<BaseinfoFamilyArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BaseinfoFamilyArchive dataBean = (BaseinfoFamilyArchive) records[i].toBean(BaseinfoFamilyArchive.class);
			list.add(dataBean);
		}
		dao.save(list);
	}
}
