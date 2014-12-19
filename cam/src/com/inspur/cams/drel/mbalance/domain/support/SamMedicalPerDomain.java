package com.inspur.cams.drel.mbalance.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalPerDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalPer;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalPerDomain;

/***
 * 一站结算_救助比例domain
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalPerDomain implements ISamMedicalPerDomain{
	@Reference
	private ISamMedicalPerDao samMedicalPerDao;

	public String insert(SamMedicalPer samMedicalPer) {
		samMedicalPer.setId(IdHelp.getUUID30());
		SamMedicalPer s = samMedicalPerDao.insert(samMedicalPer);
		return s.getId();
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samMedicalPerDao.query(pset);
	}

	public void update(SamMedicalPer samMedicalPer) {
		// TODO Auto-generated method stub
		samMedicalPer.setModOrgan(BspUtil.getCorpOrgan().getOrganName());
		samMedicalPer.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		samMedicalPer.setModTime(DateUtil.getTime());
		samMedicalPerDao.update(samMedicalPer);
	}
	
	public void save(List<SamMedicalPer> list){
		samMedicalPerDao.batchInsert(list);
	}
}
