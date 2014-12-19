package com.inspur.cams.sorg.assess.assesstask.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.assess.assesstask.dao.SomAssessTaskDao;
import com.inspur.cams.sorg.assess.assesstask.data.SomAssessTask;

/**
 * @title:SomAssessTaskCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class SomAssessTaskCommand extends BaseAjaxCommand{
	private SomAssessTaskDao dao = (SomAssessTaskDao) DaoFactory
			.getDao("com.inspur.cams.sorg.assess.assesstask.dao.SomAssessTaskDao");

	public void insert() {
		String deptName = BspUtil.getDeptOrgan().getOrganName();
		String areaCode = BspUtil.getOrganCode();
		Record record = (Record) getParameter("record");
		String taskId = IdHelp.getUUID32();
		record.set("taskId", taskId);
		SomAssessTask dataBean=(SomAssessTask)record.toBean(SomAssessTask.class);
		dataBean.setOrganName(deptName);
		dataBean.setOrganAreaCode(areaCode);
		dataBean.setStartDate(DateUtil.getDay());
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomAssessTask dataBean=(SomAssessTask)record.toBean(SomAssessTask.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomAssessTask> list = new ArrayList<SomAssessTask>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomAssessTask dataBean = (SomAssessTask) records[i].toBean(SomAssessTask.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
