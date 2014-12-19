package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcManageInfo;
import com.inspur.cams.cdc.base.data.CdcManageReport;

/**
 * 基层民主民主管理统计�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcManageReportDomain {

	/**
	 * ??��??基层民主民主管理统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基层民主民主管理统计�?
	 * @param cdcManageReport
	 */
	@Trans
	public void insert(CdcManageInfo cdcManageInfo,CdcManageReport cdcManageReport);
	
	/**
	 * �????基层民主民主管理统计�?
	 * @param cdcManageReport
	 */
	@Trans
	public void update(CdcManageInfo cdcManageInfo,CdcManageReport cdcManageReport);
	
	@Trans
	public void update(CdcManageReport cdcManageReport);
	
	/**
	 * ??????基层民主民主管理统计�?
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);

	@Trans
	public void sum(CdcManageReport cdcManageReport);

}