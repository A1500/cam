package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcSuperviseInfoDao;
import com.inspur.cams.cdc.base.data.CdcSuperviseInfo;
import com.inspur.cams.cdc.base.domain.ICdcSuperviseInfoDomain;

/**
 * 基层民主民主监督信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcSuperviseInfoDomain implements ICdcSuperviseInfoDomain {

	@Reference
	private ICdcSuperviseInfoDao cdcSuperviseInfoDao;

	/**
	 * ??��??基层民主民主监督信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcSuperviseInfoDao.query(pset);
	}

	/**
	 * �????基层民主民主监督信息�?
	 * @param cdcSuperviseInfo
	 */
	public void insert(CdcSuperviseInfo cdcSuperviseInfo) {
		cdcSuperviseInfoDao.insert(cdcSuperviseInfo);
	}
	
	/**
	 * �????基层民主民主监督信息�?
	 * @param cdcSuperviseInfo
	 */
	public void update(CdcSuperviseInfo cdcSuperviseInfo) {
		cdcSuperviseInfoDao.update(cdcSuperviseInfo);
	}
	
	/**
	 * ??????基层民主民主监督信息�?
	 * @param superviseId
	 */
	public void delete(String superviseId) {
		cdcSuperviseInfoDao.delete(superviseId);
	}

}