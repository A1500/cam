package com.inspur.cams.drel.mbalance.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalSpPerDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalSpPer;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalSpPerDomain;

/***
 * 一站结算_优抚救助比例Domain
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalSpPerDomain implements ISamMedicalSpPerDomain{
	@Reference
	private ISamMedicalSpPerDao samMedicalSpPerDao;

	public String insert(SamMedicalSpPer samMedicalSpPer) {
		samMedicalSpPer.setId(IdHelp.getUUID30());
		SamMedicalSpPer s = samMedicalSpPerDao.insert(samMedicalSpPer);
		return s.getId();
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samMedicalSpPerDao.query(pset);
	}

	public void update(SamMedicalSpPer samMedicalSpPer) {
		// TODO Auto-generated method stub
		samMedicalSpPer.setModOrgan(BspUtil.getCorpOrgan().getOrganName());
		samMedicalSpPer.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		samMedicalSpPer.setModTime(DateUtil.getTime());
		samMedicalSpPerDao.update(samMedicalSpPer);
	}

	public void save(List<SamMedicalSpPer> list) {
		samMedicalSpPerDao.batchInsert(list);
		
	}
}
