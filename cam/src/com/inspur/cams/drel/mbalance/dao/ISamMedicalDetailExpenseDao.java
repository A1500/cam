package com.inspur.cams.drel.mbalance.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;
/**
 * 一站式结算_费用明细Dao接口
 * @author lgs
 *
 */
public interface ISamMedicalDetailExpenseDao extends BaseCURD<SamMedicalDetailExpense> {
	public void save(List<SamMedicalDetailExpense> list);
}
