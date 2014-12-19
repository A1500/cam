package com.inspur.cams.drel.mbalance.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;

/***
 * 一站结算_费用明细Domain接口
 * @author 路国隋
 * @date 2011-10-28
 */
public interface ISamMedicalDetailExpenseDomain {
	/**
	 * 费用明细查询
	 * @param pset
	 * @return 
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 费用明细的插入
	 * @param samMedicalDetailExpense
	 * @return
	 */
	@Trans
	public void insert(SamMedicalDetailExpense samMedicalDetailExpense);
	
	public void batchInsert(List<SamMedicalDetailExpense> list);
	/**
	 * 费用明细的修改
	 * @param samMedicalDetailExpense
	 */
	@Trans
	public void update(SamMedicalDetailExpense samMedicalDetailExpense);

	/**
	 * 费用明细批量保存
	 * @param list
	 */
	
	public void save(List<SamMedicalDetailExpense> list);
	
	
	public void batchDelete(String[] delIds);
}
