package com.inspur.cams.drel.mbalance.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.mbalance.data.SamMedicalClinicSp;

/**
 * @title:ISamMedicalClinicSpDao
 * @description:
 * @author:
 * @since:2011-07-20
 * @version:1.0
*/
 public interface ISamMedicalClinicSpDao extends BaseCURD<SamMedicalClinicSp>{
	public void save(List<SamMedicalClinicSp> list);
	
	public void deleteByIds(String[] ids);

	public void submitRule(String[] ids);
	
	public DataSet queryBySql(ParameterSet pset);
	
	/**
	 * 
	 * @param pset
	 * @return
	 */
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

