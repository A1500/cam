package com.inspur.cams.sorg.penalty.correct.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.penalty.base.dao.jdbc.SomPenaltyCorrectDao;
import com.inspur.cams.sorg.penalty.base.data.SomPenaltyCorrect;

/**
 * @title:SomPenaltyCorrectCommand
 * @description:
 * @author:
 * @since:2011-12-29
 * @version:1.0
*/
public class SomPenaltyCorrectCommand extends BaseAjaxCommand{
	private SomPenaltyCorrectDao dao = (SomPenaltyCorrectDao) DaoFactory
			.getDao("com.inspur.cams.sorg.penalty.base.dao.jdbc.SomPenaltyCorrectDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomPenaltyCorrect dataBean=(SomPenaltyCorrect)record.toBean(SomPenaltyCorrect.class);
		dataBean.setId(IdHelp.getUUID32());
		dataBean.setRegArea(BspUtil.getOrganCode());
		dataBean.setRegPeopleId(BspUtil.getEmpOrganId());
		dataBean.setRegPeopleName(BspUtil.getEmpOrgan().getOrganName());
		dataBean.setRegOrganId(BspUtil.getDeptOrganId());
		dataBean.setRegOrganName(BspUtil.getDeptOrgan().getOrganName());
		dataBean.setRegDate(DateUtil.getDay());
		dao.insert(dataBean);
		setReturn("id", dataBean.getId());
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomPenaltyCorrect dataBean=(SomPenaltyCorrect)record.toBean(SomPenaltyCorrect.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomPenaltyCorrect> list = new ArrayList<SomPenaltyCorrect>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomPenaltyCorrect dataBean = (SomPenaltyCorrect) records[i].toBean(SomPenaltyCorrect.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
