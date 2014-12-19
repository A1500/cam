package com.inspur.cams.drel.archive.sampeopleinsurancearchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.sampeopleinsurancearchive.dao.jdbc.SamPeopleInsuranceArchiveDao;
import com.inspur.cams.drel.archive.sampeopleinsurancearchive.data.SamPeopleInsuranceArchive;

/**
 * @title:SamPeopleInsuranceArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class SamPeopleInsuranceArchiveCmd extends BaseAjaxCommand{
	private SamPeopleInsuranceArchiveDao dao = (SamPeopleInsuranceArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.sampeopleinsurancearchive.dao.jdbc.SamPeopleInsuranceArchiveDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SamPeopleInsuranceArchive dataBean=(SamPeopleInsuranceArchive)record.toBean(SamPeopleInsuranceArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamPeopleInsuranceArchive dataBean=(SamPeopleInsuranceArchive)record.toBean(SamPeopleInsuranceArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamPeopleInsuranceArchive> list = new ArrayList<SamPeopleInsuranceArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamPeopleInsuranceArchive dataBean = (SamPeopleInsuranceArchive) records[i].toBean(SamPeopleInsuranceArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
