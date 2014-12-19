package com.inspur.cams.bpt.dicobjecttype.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.dicobjecttype.dao.*;

/**
 * @title:DicObjecttypeCommand
 * @description:
 * @author:
 * @since:2011-08-16
 * @version:1.0
*/
public class DicObjecttypeCommand extends BaseAjaxCommand{
	private DicObjecttypeDao dao = (DicObjecttypeDao) DaoFactory
			.getDao("com.inspur.cams.bpt.dicobjecttype.dao.DicObjecttypeDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		DicObjecttype dataBean=(DicObjecttype)record.toBean(DicObjecttype.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		DicObjecttype dataBean=(DicObjecttype)record.toBean(DicObjecttype.class);
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
		List<DicObjecttype> list = new ArrayList<DicObjecttype>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			DicObjecttype dataBean = (DicObjecttype) records[i].toBean(DicObjecttype.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
