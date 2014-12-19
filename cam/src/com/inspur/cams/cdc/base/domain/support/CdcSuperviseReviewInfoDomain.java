package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcSuperviseReviewInfoDao;
import com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo;
import com.inspur.cams.cdc.base.domain.ICdcSuperviseReviewInfoDomain;

/**
 * 基层民主民主监督信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcSuperviseReviewInfoDomain implements ICdcSuperviseReviewInfoDomain {

	@Reference
	private ICdcSuperviseReviewInfoDao cdcSuperviseReviewInfoDao;

	/**
	 * ??��??基层民主民主监督信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcSuperviseReviewInfoDao.query(pset);
	}

	/**
	 * �????基层民主民主监督信息�?
	 * @param cdcSuperviseInfo
	 */
	public void insert(CdcSuperviseReviewInfo cdcSuperviseReviewInfo) {
		cdcSuperviseReviewInfoDao.insert(cdcSuperviseReviewInfo);
	}
	
	/**
	 * �????基层民主民主监督信息�?
	 * @param cdcSuperviseInfo
	 */
	public void update(CdcSuperviseReviewInfo cdcSuperviseReviewInfo) {
		cdcSuperviseReviewInfoDao.update(cdcSuperviseReviewInfo);
	}
	
	/**
	 * ??????基层民主民主监督信息�?
	 * @param superviseId
	 */
	public void delete(String superviseId) {
		cdcSuperviseReviewInfoDao.delete(superviseId);
	}

}