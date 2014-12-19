package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamFamilySupportDao;
import com.inspur.cams.drel.sam.data.SamFamilySupport;
import com.inspur.cams.drel.sam.domain.ISamFamilySupportDomain;

/**
 * @title:赡扶抚养人Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamFamilySupportDomain implements ISamFamilySupportDomain{
	@Reference
	private ISamFamilySupportDao samFamilySupportDao;
	
	public void insert(SamFamilySupport samFamilySupport) {
		samFamilySupportDao.insert(samFamilySupport);
		
	}

	public DataSet query(ParameterSet pset) {
		return samFamilySupportDao.query(pset);
	}

	public void update(SamFamilySupport samFamilySupport) {
		samFamilySupportDao.update(samFamilySupport);
		
	}

}
