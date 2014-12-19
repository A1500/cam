package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcNatureInfoDao;
import com.inspur.cams.cdc.base.data.CdcNatureInfo;
import com.inspur.cams.cdc.base.domain.ICdcNatureInfoDomain;

/**
 * 基础信息自然状况信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcNatureInfoDomain implements ICdcNatureInfoDomain {

	@Reference
	private ICdcNatureInfoDao cdcNatureInfoDao;

	/**
	 * ??��??基础信息自然状况信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcNatureInfoDao.query(pset);
	}

	/**
	 * �????基础信息自然状况信息�?
	 * @param cdcNatureInfo
	 */
	public void insert(CdcNatureInfo cdcNatureInfo) {
		
		cdcNatureInfoDao.insert(cdcNatureInfo);
	}
	
	/**
	 * �????基础信息自然状况信息�?
	 * @param cdcNatureInfo
	 */
	public void update(CdcNatureInfo cdcNatureInfo) {
		cdcNatureInfoDao.update(cdcNatureInfo);
	}
	
	/**
	 * ??????基础信息自然状况信息�?
	 * @param natureId
	 */
	public void delete(String natureId) {
		cdcNatureInfoDao.delete(natureId);
	}

}