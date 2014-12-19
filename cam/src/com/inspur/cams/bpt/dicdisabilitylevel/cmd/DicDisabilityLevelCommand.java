package com.inspur.cams.bpt.dicdisabilitylevel.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.dicdisabilitylevel.dao.*;

/**
 * @title:DicDisabilityLevelCommand
 * @description:
 * @author:
 * @since:2011-11-03
 * @version:1.0
*/
public class DicDisabilityLevelCommand extends BaseAjaxCommand{
	private DicDisabilityLevelDao dao = (DicDisabilityLevelDao) DaoFactory
			.getDao("com.inspur.cams.bpt.dicdisabilitylevel.dao.DicDisabilityLevelDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		DicDisabilityLevel dataBean=(DicDisabilityLevel)record.toBean(DicDisabilityLevel.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		DicDisabilityLevel dataBean=(DicDisabilityLevel)record.toBean(DicDisabilityLevel.class);
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
		List<DicDisabilityLevel> list = new ArrayList<DicDisabilityLevel>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			DicDisabilityLevel dataBean = (DicDisabilityLevel) records[i].toBean(DicDisabilityLevel.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
