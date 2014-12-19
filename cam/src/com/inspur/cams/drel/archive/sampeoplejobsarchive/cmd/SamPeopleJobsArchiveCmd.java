package com.inspur.cams.drel.archive.sampeoplejobsarchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeoplejobsarchive.dao.jdbc.SamPeopleJobsArchiveDao;
import com.inspur.cams.drel.archive.sampeoplejobsarchive.data.SamPeopleJobsArchive;

/**
 * @title:SamPeopleJobsArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleJobsArchiveCmd extends BaseAjaxCommand{
	private SamPeopleJobsArchiveDao dao = (SamPeopleJobsArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeoplejobsarchive.dao.jdbc.SamPeopleJobsArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleJobsArchive dataBean=(SamPeopleJobsArchive)record.toBean(SamPeopleJobsArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleJobsArchive dataBean=(SamPeopleJobsArchive)record.toBean(SamPeopleJobsArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleJobsArchive> list = new ArrayList<SamPeopleJobsArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleJobsArchive dataBean = (SamPeopleJobsArchive) records[i].toBean(SamPeopleJobsArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
