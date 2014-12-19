package com.inspur.cams.drel.archive.sampeopledisabilityarchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeopledisabilityarchive.dao.jdbc.SamPeopleDisabilityArchiveDao;
import com.inspur.cams.drel.archive.sampeopledisabilityarchive.data.SamPeopleDisabilityArchive;

/**
 * @title:SamPeopleDisabilityArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleDisabilityArchiveCmd extends BaseAjaxCommand{
	private SamPeopleDisabilityArchiveDao dao = (SamPeopleDisabilityArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeopledisabilityarchive.dao.jdbc.SamPeopleDisabilityArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleDisabilityArchive dataBean=(SamPeopleDisabilityArchive)record.toBean(SamPeopleDisabilityArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleDisabilityArchive dataBean=(SamPeopleDisabilityArchive)record.toBean(SamPeopleDisabilityArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleDisabilityArchive> list = new ArrayList<SamPeopleDisabilityArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleDisabilityArchive dataBean = (SamPeopleDisabilityArchive) records[i].toBean(SamPeopleDisabilityArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
