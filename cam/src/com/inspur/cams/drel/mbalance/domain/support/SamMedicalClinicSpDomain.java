package com.inspur.cams.drel.mbalance.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalClinicSpDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalClinicSp;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalClinicSpDomain;

public class SamMedicalClinicSpDomain implements ISamMedicalClinicSpDomain{
	@Reference
	private ISamMedicalClinicSpDao samMedicalClinicSpDao;

	@Trans
	public void insert(SamMedicalClinicSp bean) {
		samMedicalClinicSpDao.insert(bean);	
	}

	public DataSet query(ParameterSet pset) {
		return samMedicalClinicSpDao.query(pset);
	}
	@Trans
	public void update(SamMedicalClinicSp bean) {
		samMedicalClinicSpDao.update(bean);
	}

	public void delete(String[] ids) {
		samMedicalClinicSpDao.deleteByIds(ids);
	}

	public void submitRule(String[] ids) {
		samMedicalClinicSpDao.submitRule(ids);
	}

	public DataSet queryBySql(ParameterSet pset) {
		return samMedicalClinicSpDao.queryBySql(pset);
	}

	
	/**
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryForClinic(ParameterSet pset){
		return samMedicalClinicSpDao.queryForClinic(pset);
	}

   	/**
   	 * 优抚门规明细查询
   	 * @param pset
   	 * @return
   	 */
	public DataSet queryForClinicDetail(ParameterSet pset){
		return samMedicalClinicSpDao.queryForClinicDetail(pset);
	}
	/**
	 * 普通门规录入时人员查询
	 * @param pset
	 * @return
	 */
	
	public DataSet QueryPeople(ParameterSet pset){
		return samMedicalClinicSpDao.QueryPeople(pset);
	}
	/**
	 * 普通门规查询
	 * @param pset
	 * @return
	 */
	
	public DataSet queryForNomClinic(ParameterSet pset){
		return samMedicalClinicSpDao.queryForNomClinic(pset);
	}
}
