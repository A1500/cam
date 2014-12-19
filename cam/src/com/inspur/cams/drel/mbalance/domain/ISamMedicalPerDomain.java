package com.inspur.cams.drel.mbalance.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMedicalPer;
/***
 * 一站结算_救助比例domain接口
 * @author yanliangliang
 * @date 2011-6-15
 */
public interface ISamMedicalPerDomain {
	/**
	 * 救助比例查询
	 * @param pset
	 * @return 
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 救助比例的插入
	 * @param samMedicalTopLine
	 * @return
	 */
	@Trans
	public String insert(SamMedicalPer samMedicalPer);
	/**
	 * 救助比例的修改
	 * @param samMedicalTopLine
	 */
	@Trans
	public void update(SamMedicalPer samMedicalPer);
	/**
	 * 救助比例批量保存
	 * @param list
	 */
	
	public void save(List<SamMedicalPer> list);
}
