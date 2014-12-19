package com.inspur.cams.drel.mbalance.cmd;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.mbalance.domain.ISamMedicalDetailExpenseDomain;

/**
 * 一站式结算_费用明细查询Cmd
 * @author lgs
 *
 */
public class SamMedicalDetailExpenseQueryCmd extends BaseQueryCommand {
	private ISamMedicalDetailExpenseDomain samMedicalDetailExpenseDomain=ScaComponentFactory.getService(ISamMedicalDetailExpenseDomain.class, "samMedicalDetailExpenseDomain/samMedicalDetailExpenseDomain");

	public DataSet execute() {
		ParameterSet paramSet = getParameterSet();
		return samMedicalDetailExpenseDomain.query(paramSet);
	}
}
