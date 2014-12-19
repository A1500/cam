package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcPlanInfo;

/**
 * 社区建设规划信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcPlanInfoDomain {

	/**
	 * ??��??社区建设规划信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????社区建设规划信息�?
	 * @param cdcPlanInfo
	 */
	@Trans
	public void insert(CdcPlanInfo cdcPlanInfo);
	
	/**
	 * �????社区建设规划信息�?
	 * @param cdcPlanInfo
	 */
	@Trans
	public void update(CdcPlanInfo cdcPlanInfo);
	
	/**
	 * ??????社区建设规划信息�?
	 * @param planId
	 */
	@Trans
	public void delete(String planId);

	@Trans
	public void sum(CdcPlanInfo cdcPlanInfo);

	public DataSet queryList(ParameterSet pset);

	@Trans
	public void report(String id);

	@Trans
	public void audit(String id);

}