package com.inspur.cams.drel.mbalance.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMedicalClinicSp;

/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-7-20
 */
public interface ISamMedicalClinicSpDomain {
	public DataSet query(ParameterSet pset);
	@Trans
	public void insert(SamMedicalClinicSp bean);
	@Trans
	public void update(SamMedicalClinicSp bean);
	@Trans
	public void delete(String[] ids);
	@Trans
	public void submitRule(String[] ids);
	@Trans
	public DataSet queryBySql(ParameterSet pset);
	
	/**
	 * 
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet queryForClinic(ParameterSet pset);
   	/**
   	 * 优抚门规明细查询
   	 * @param pset
   	 * @return
   	 */
	public DataSet queryForClinicDetail(ParameterSet pset);
	/**
	 * 普通门规录入时人员查询
	 * @param pset
	 * @return
	 */
	
	public DataSet QueryPeople(ParameterSet pset);
	/**
	 * 普通门规查询
	 * @param pset
	 * @return
	 */
	
	public DataSet queryForNomClinic(ParameterSet pset);
}
