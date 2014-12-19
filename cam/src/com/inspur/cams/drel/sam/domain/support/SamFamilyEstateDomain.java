package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.dao.ISamFamilyEstateDao;
import com.inspur.cams.drel.sam.dao.ISamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.data.SamFamilyEstate;
import com.inspur.cams.drel.sam.domain.ISamFamilyEstateDomain;
/**
 * @title:家庭财产信息Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamFamilyEstateDomain implements ISamFamilyEstateDomain {
	@Reference
	private ISamFamilyEstateDao samFamilyEstateDao;
	
	public void insert(SamFamilyEstate samFamilyEstate) {
		samFamilyEstateDao.insert(samFamilyEstate);
	}
	public DataSet query(ParameterSet pset) {
		return samFamilyEstateDao.query(pset);
	}
	public void update(SamFamilyEstate samFamilyEstate) {
		samFamilyEstateDao.update(samFamilyEstate);
	}

}
