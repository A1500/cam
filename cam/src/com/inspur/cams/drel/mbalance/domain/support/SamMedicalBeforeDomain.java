package com.inspur.cams.drel.mbalance.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalBeforeDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalBeforeDomain;

/***
 *  一站结算_救助封顶线domain
 * @author 路国隋
 * @date 2011-6-15
 */
public class SamMedicalBeforeDomain implements ISamMedicalBeforeDomain{
	@Reference
	private ISamMedicalBeforeDao samMedicalBeforeDao;

	public void insert(SamMedicalBefore samMedicalBefore) {
		samMedicalBeforeDao.insert(samMedicalBefore);
	}

	public DataSet query(ParameterSet pset) {
		return samMedicalBeforeDao.query(pset);
	}

	public void update(SamMedicalBefore samMedicalBefore) {
		samMedicalBeforeDao.update(samMedicalBefore);
		
	}

	public void save(List<SamMedicalBefore> list) {
		samMedicalBeforeDao.save(list);
	}
	
	public void batchDelete(String[] delIds){
		samMedicalBeforeDao.batchDelete(delIds);
	}
}