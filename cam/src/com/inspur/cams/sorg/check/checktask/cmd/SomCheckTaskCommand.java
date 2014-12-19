package com.inspur.cams.sorg.check.checktask.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.check.checktask.dao.SomCheckTaskDao;
import com.inspur.cams.sorg.check.checktask.data.SomCheckTask;

/**
 * @title:SomCheckTaskCommand
 * @description:
 * @author:
 * @since:2011-12-28
 * @version:1.0
*/
public class SomCheckTaskCommand extends BaseAjaxCommand{
	private SomCheckTaskDao dao = (SomCheckTaskDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checktask.dao.SomCheckTaskDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckTask dataBean=(SomCheckTask)record.toBean(SomCheckTask.class);
		dataBean.setTaskId(IdHelp.getUUID32());
		dataBean.setAddDate(DateUtil.getDay());
		dataBean.setAddOrgan(BspUtil.getDeptOrgan().getOrganName());
		dataBean.setAddOrganId(BspUtil.getDeptOrganId());
		dataBean.setAddPersonn(BspUtil.getEmpOrgan().getOrganName());
		dataBean.setAddPersonnId(BspUtil.getEmpOrganId());
		dataBean.setAreaCode(BspUtil.getOrganCode());
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckTask dataBean=(SomCheckTask)record.toBean(SomCheckTask.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckTask> list = new ArrayList<SomCheckTask>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckTask dataBean = (SomCheckTask) records[i].toBean(SomCheckTask.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
