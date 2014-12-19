package com.inspur.cams.drel.archive.sampeopletypearchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeopletypearchive.dao.jdbc.SamPeopleTypeArchiveDao;
import com.inspur.cams.drel.archive.sampeopletypearchive.data.SamPeopleTypeArchive;

/**
 * @title:SamPeopleTypeArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleTypeArchiveCmd extends BaseAjaxCommand{
	private SamPeopleTypeArchiveDao dao = (SamPeopleTypeArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeopletypearchive.dao.jdbc.SamPeopleTypeArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleTypeArchive dataBean=(SamPeopleTypeArchive)record.toBean(SamPeopleTypeArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleTypeArchive dataBean=(SamPeopleTypeArchive)record.toBean(SamPeopleTypeArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleTypeArchive> list = new ArrayList<SamPeopleTypeArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleTypeArchive dataBean = (SamPeopleTypeArchive) records[i].toBean(SamPeopleTypeArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
