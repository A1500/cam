package com.inspur.cams.drel.mbalance.domain.support;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalConConfigDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalConConfig;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalConConfigDomain;

/***
 * 一站结算_费用明细Domain
 * @author 路国隋
 * @date 2011-6-15
 */
public class SamMedicalConConfigDomain implements ISamMedicalConConfigDomain{
	@Reference
	private ISamMedicalConConfigDao samMedicalConConfigDao;

	public void insert(SamMedicalConConfig samMedicalConConfig) {
		samMedicalConConfigDao.insert(samMedicalConConfig);
	}

	public DataSet query(ParameterSet pset) {
		return samMedicalConConfigDao.query(pset);
	}

	public void update(SamMedicalConConfig samMedicalConConfig) {
		samMedicalConConfigDao.update(samMedicalConConfig);
	}

	public void save(List<SamMedicalConConfig> list) {
		samMedicalConConfigDao.batchInsert(list);
		
	}

	public void batchDelete(String[] delIds) {
		samMedicalConConfigDao.batchDelete(delIds);
	}
	
	public Map queryConConfig(String organArea,String insuranceType){
		return samMedicalConConfigDao.queryConConfig(organArea, insuranceType);
	}
}