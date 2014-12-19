package com.inspur.cams.drel.archive.sampeopleeduarchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeopleeduarchive.dao.jdbc.SamPeopleEduArchiveDao;
import com.inspur.cams.drel.archive.sampeopleeduarchive.data.SamPeopleEduArchive;

/**
 * @title:SamPeopleEduArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleEduArchiveCmd extends BaseAjaxCommand{
	private SamPeopleEduArchiveDao dao = (SamPeopleEduArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeopleeduarchive.dao.jdbc.SamPeopleEduArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleEduArchive dataBean=(SamPeopleEduArchive)record.toBean(SamPeopleEduArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleEduArchive dataBean=(SamPeopleEduArchive)record.toBean(SamPeopleEduArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleEduArchive> list = new ArrayList<SamPeopleEduArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleEduArchive dataBean = (SamPeopleEduArchive) records[i].toBean(SamPeopleEduArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
