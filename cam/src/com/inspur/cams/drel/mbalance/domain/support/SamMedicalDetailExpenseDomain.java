package com.inspur.cams.drel.mbalance.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalDetailExpenseDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalDetailExpenseDomain;

/***
 * 一站结算_费用明细Domain
 * @author 路国隋
 * @date 2011-6-15
 */
public class SamMedicalDetailExpenseDomain implements ISamMedicalDetailExpenseDomain{
	@Reference
	private ISamMedicalDetailExpenseDao samMedicalDetailExpenseDao;

	public void insert(SamMedicalDetailExpense samMedicalDetailExpense) {
		samMedicalDetailExpenseDao.insert(samMedicalDetailExpense);
	}
	public void batchInsert(List<SamMedicalDetailExpense> list){
		samMedicalDetailExpenseDao.batchInsert(list);
	}
	public DataSet query(ParameterSet pset) {
		return samMedicalDetailExpenseDao.query(pset);
	}

	public void update(SamMedicalDetailExpense samMedicalDetailExpense) {
		samMedicalDetailExpenseDao.update(samMedicalDetailExpense);
	}

	public void save(List<SamMedicalDetailExpense> list) {
		samMedicalDetailExpenseDao.batchInsert(list);
		
	}

	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samMedicalDetailExpenseDao.batchDelete(delIds);
	}
}
