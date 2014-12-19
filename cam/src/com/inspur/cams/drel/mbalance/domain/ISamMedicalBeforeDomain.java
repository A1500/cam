package com.inspur.cams.drel.mbalance.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;

/***
 * 一站结算_救助医前救助domain接口
 * @author 路国隋
 * @date 2011-6-15
 */
public interface ISamMedicalBeforeDomain {
	/**
	 * 救助医前救助查询
	 * @param pset
	 * @return 
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 救助医前救助的插入
	 * @param samMedicalBefore
	 * @return
	 */
	@Trans
	public void insert(SamMedicalBefore samMedicalBefore);
	/**
	 * 救助医前救助的修改
	 * @param samMedicalBefore
	 */
	@Trans
	public void update(SamMedicalBefore samMedicalBefore);
	/**
	 * 救助医前救助的批量保存
	 * @param list
	 */
	@Trans
	public void save(List<SamMedicalBefore> list);
	/**
	 * 救助医前救助的批量删除
	 * @param delIds
	 */
	@Trans
	public void batchDelete(String[] delIds);
}
