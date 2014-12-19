package com.inspur.cams.drel.archive.baseinfopeoplearchive.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.jdbc.BaseinfoPeopleArchiveDao;
import com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive;

/**
 * @title:BaseinfoPeopleArchiveCommand
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
public class BaseinfoPeopleArchiveCmd extends BaseAjaxCommand{
	private BaseinfoPeopleArchiveDao dao = (BaseinfoPeopleArchiveDao) DaoFactory
			.getDao("com.inspur.cams.drel.archive.baseinfopeoplearchive.dao.jdbc.BaseinfoPeopleArchiveDao");
	public void insert() {
		Record record = (Record) getParameter("record");
		BaseinfoPeopleArchive dataBean=(BaseinfoPeopleArchive)record.toBean(BaseinfoPeopleArchive.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		BaseinfoPeopleArchive dataBean=(BaseinfoPeopleArchive)record.toBean(BaseinfoPeopleArchive.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BaseinfoPeopleArchive> list = new ArrayList<BaseinfoPeopleArchive>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BaseinfoPeopleArchive dataBean = (BaseinfoPeopleArchive) records[i].toBean(BaseinfoPeopleArchive.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	public void queryExistPeople(){
		String peopleId=(String) getParameter("peopleId");
		String flag = dao.queryExistPeople(peopleId);
		setReturn("flag",flag);
	}
}
