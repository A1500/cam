package com.inspur.cams.sorg.check.checkpublicbenefit.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.check.checkpublicbenefit.dao.SomCheckPublicBenefitDao;
import com.inspur.cams.sorg.check.checkpublicbenefit.data.SomCheckPublicBenefit;

/**
 * @title:SomCheckPublicBenefitCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class SomCheckPublicBenefitCommand extends BaseAjaxCommand{
	private SomCheckPublicBenefitDao dao = (SomCheckPublicBenefitDao) DaoFactory
			.getDao("com.inspur.cams.sorg.check.checkpublicbenefit.dao.SomCheckPublicBenefitDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomCheckPublicBenefit dataBean=(SomCheckPublicBenefit)record.toBean(SomCheckPublicBenefit.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomCheckPublicBenefit dataBean=(SomCheckPublicBenefit)record.toBean(SomCheckPublicBenefit.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomCheckPublicBenefit> list = new ArrayList<SomCheckPublicBenefit>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomCheckPublicBenefit dataBean = (SomCheckPublicBenefit) records[i].toBean(SomCheckPublicBenefit.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
