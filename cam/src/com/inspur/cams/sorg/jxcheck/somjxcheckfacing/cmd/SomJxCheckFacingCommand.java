package com.inspur.cams.sorg.jxcheck.somjxcheckfacing.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao.*;

/**
 * @title:SomJxCheckFacingCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckFacingCommand extends BaseAjaxCommand{
	private SomJxCheckFacingDao dao = (SomJxCheckFacingDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao.SomJxCheckFacingDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckFacing dataBean=(SomJxCheckFacing)record.toBean(SomJxCheckFacing.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckFacing dataBean=(SomJxCheckFacing)record.toBean(SomJxCheckFacing.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckFacing> list = new ArrayList<SomJxCheckFacing>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckFacing dataBean = (SomJxCheckFacing) records[i].toBean(SomJxCheckFacing.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
