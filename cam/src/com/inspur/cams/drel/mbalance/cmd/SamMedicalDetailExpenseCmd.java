package com.inspur.cams.drel.mbalance.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalDetailExpenseDomain;

/**
 * 一站式结算_费用明细Cmd
 * @author lgs
 *
 */
public class SamMedicalDetailExpenseCmd extends BaseAjaxCommand {
	private ISamMedicalDetailExpenseDomain samMedicalDetailExpenseDomain=ScaComponentFactory.getService(ISamMedicalDetailExpenseDomain.class, "samMedicalDetailExpenseDomain/samMedicalDetailExpenseDomain");

	
	public void insert() {
		Record record = (Record) getParameter("record");
		SamMedicalDetailExpense dataBean=(SamMedicalDetailExpense)record.toBean(SamMedicalDetailExpense.class);
		samMedicalDetailExpenseDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SamMedicalDetailExpense dataBean=(SamMedicalDetailExpense)record.toBean(SamMedicalDetailExpense.class);
		samMedicalDetailExpenseDomain.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samMedicalDetailExpenseDomain.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SamMedicalDetailExpense> list = new ArrayList<SamMedicalDetailExpense>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SamMedicalDetailExpense dataBean = (SamMedicalDetailExpense) records[i].toBean(SamMedicalDetailExpense.class);
			list.add(dataBean);
		}

		samMedicalDetailExpenseDomain.save(list);
	}
}
