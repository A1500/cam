package com.inspur.cams.drel.mbalance.dao.jdbc;


import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalDetailExpenseDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;
/**
 * 一站式结算_费用明细Dao
 * @author lgs
 *
 */
public class SamMedicalDetailExpenseDao extends EntityDao<SamMedicalDetailExpense> implements
		ISamMedicalDetailExpenseDao {

	@Override
	protected Class getEntityClass() {
		return SamMedicalDetailExpense.class;
	}

}
