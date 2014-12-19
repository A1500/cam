package com.inspur.cams.drel.archive.sampeopleextendarchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeopleextendarchive.dao.jdbc.SamPeopleExtendArchiveDao;
import com.inspur.cams.drel.archive.sampeopleextendarchive.data.SamPeopleExtendArchive;

/**
 * @title:SamPeopleExtendArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleExtendArchiveCmd extends BaseAjaxCommand{
	private SamPeopleExtendArchiveDao dao = (SamPeopleExtendArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeopleextendarchive.dao.jdbc.SamPeopleExtendArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleExtendArchive dataBean=(SamPeopleExtendArchive)record.toBean(SamPeopleExtendArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleExtendArchive dataBean=(SamPeopleExtendArchive)record.toBean(SamPeopleExtendArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleExtendArchive> list = new ArrayList<SamPeopleExtendArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleExtendArchive dataBean = (SamPeopleExtendArchive) records[i].toBean(SamPeopleExtendArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
