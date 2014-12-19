package com.inspur.cams.drel.archive.sampeoplediseasearchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeoplediseasearchive.dao.jdbc.SamPeopleDiseaseArchiveDao;
import com.inspur.cams.drel.archive.sampeoplediseasearchive.data.SamPeopleDiseaseArchive;

/**
 * @title:SamPeopleDiseaseArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleDiseaseArchiveCmd extends BaseAjaxCommand{
	private SamPeopleDiseaseArchiveDao dao = (SamPeopleDiseaseArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeoplediseasearchive.dao.jdbc.SamPeopleDiseaseArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleDiseaseArchive dataBean=(SamPeopleDiseaseArchive)record.toBean(SamPeopleDiseaseArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleDiseaseArchive dataBean=(SamPeopleDiseaseArchive)record.toBean(SamPeopleDiseaseArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleDiseaseArchive> list = new ArrayList<SamPeopleDiseaseArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleDiseaseArchive dataBean = (SamPeopleDiseaseArchive) records[i].toBean(SamPeopleDiseaseArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
