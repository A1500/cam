package com.inspur.cams.sorg.check.somchecksupervisoropinion.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinion;
import com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinionDao;

/**
 * @title:SomCheckSupervisorOpinionCommand
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
public class SomCheckSupervisorOpinionCommand extends BaseAjaxCommand{
	private SomCheckSupervisorOpinionDao dao = (SomCheckSupervisorOpinionDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinionDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckSupervisorOpinion dataBean=(SomCheckSupervisorOpinion)record.toBean(SomCheckSupervisorOpinion.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckSupervisorOpinion dataBean=(SomCheckSupervisorOpinion)record.toBean(SomCheckSupervisorOpinion.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckSupervisorOpinion> list = new ArrayList<SomCheckSupervisorOpinion>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckSupervisorOpinion dataBean = (SomCheckSupervisorOpinion) records[i].toBean(SomCheckSupervisorOpinion.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
