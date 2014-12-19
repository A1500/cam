package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.dao.ISamFamilyAssistanceDao;
import com.inspur.cams.drel.sam.dao.ISamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.domain.ISamFamilyAssistanceDomain;
/**
 * @title:家庭救助基本信息Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamFamilyAssistanceDomain implements ISamFamilyAssistanceDomain {
	@Reference
	private ISamFamilyAssistanceDao samFamilyAssistanceDao;
	
	public void insert(SamFamilyAssistance samFamilyAssistance) {
		samFamilyAssistanceDao.insert(samFamilyAssistance);
	}

	public DataSet query(ParameterSet pset) {
		return samFamilyAssistanceDao.query(pset);
	}

	public void update(SamFamilyAssistance samFamilyAssistance) {
		samFamilyAssistanceDao.update(samFamilyAssistance);
	}

	public void deleteByFamilyId(String familyId) {
		samFamilyAssistanceDao.deleteByFamilyId(familyId);		
	}

	public void deleteAssistance(String familyId,String assistanceType){
		samFamilyAssistanceDao.deleteAssistance(familyId,assistanceType);		
	}
}
