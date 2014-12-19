package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcManageInfo;

/**
 * 基层民主民主管理信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcManageInfoDomain {

	/**
	 * ??��??基层民主民主管理信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基层民主民主管理信息�?
	 * @param cdcManageInfo
	 */
	@Trans
	public void insert(CdcManageInfo cdcManageInfo);
	
	/**
	 * �????基层民主民主管理信息�?
	 * @param cdcManageInfo
	 */
	@Trans
	public void update(CdcManageInfo cdcManageInfo);
	
	/**
	 * ??????基层民主民主管理信息�?
	 * @param manageId
	 */
	@Trans
	public void delete(String manageId);

}