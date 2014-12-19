package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcSuperviseReport;

/**
 * 基层民主民主监督统计�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcSuperviseReportDomain {

	/**
	 * ??��??基层民主民主监督统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基层民主民主监督统计�?
	 * @param cdcSuperviseReport
	 */
	@Trans
	public void insert(CdcSuperviseReport cdcSuperviseReport);
	
	/**
	 * �????基层民主民主监督统计�?
	 * @param cdcSuperviseReport
	 */
	@Trans
	public void update(CdcSuperviseReport cdcSuperviseReport);
	
	/**
	 * ??????基层民主民主监督统计�?
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);
	
	//汇总
	@Trans
	public void sum(CdcSuperviseReport cdcSuperviseReport);

}