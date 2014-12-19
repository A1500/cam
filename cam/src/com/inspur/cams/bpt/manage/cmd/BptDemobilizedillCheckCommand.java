package com.inspur.cams.bpt.manage.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao;
import com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.data.BptDemobilizedillnessCheck;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;

/**
 * BptDemobilizedillCheckCommand
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
public class BptDemobilizedillCheckCommand extends BaseAjaxCommand{
	private BptDemobilizedillCheckDao dao = (BptDemobilizedillCheckDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptDemobilizedillCheckDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		BptDemobilizedillnessCheck dataBean=(BptDemobilizedillnessCheck)record.toBean(BptDemobilizedillnessCheck.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		BptDemobilizedillnessCheck dataBean=(BptDemobilizedillnessCheck)record.toBean(BptDemobilizedillnessCheck.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptDemobilizedillnessCheck> list = new ArrayList<BptDemobilizedillnessCheck>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptDemobilizedillnessCheck dataBean = (BptDemobilizedillnessCheck) records[i].toBean(BptDemobilizedillnessCheck.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
