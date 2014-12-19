package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo;

/**
 * 基层民主民主监督信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcSuperviseReviewInfoDomain {

	/**
	 * ??��??基层民主民主监督信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基层民主民主监督信息�?
	 * @param cdcSuperviseInfo
	 */
	@Trans
	public void insert(CdcSuperviseReviewInfo cdcSuperviseReviewInfo);
	
	/**
	 * �????基层民主民主监督信息�?
	 * @param cdcSuperviseInfo
	 */
	@Trans
	public void update(CdcSuperviseReviewInfo cdcSuperviseReviewInfo);
	
	/**
	 * ??????基层民主民主监督信息�?
	 * @param superviseId
	 */
	@Trans
	public void delete(String superviseId);

}