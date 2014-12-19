package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcNatureInfo;
import com.inspur.cams.cdc.base.data.CdcNatureReport;

/**
 * 基础信息自然状况统计�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcNatureReportDomain {

	/**
	 * ??��??基础信息自然状况统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基础信息自然状况统计�?
	 * @param cdcNatureReport
	 */
	@Trans
	public void insert(CdcNatureReport cdcNatureReport);
	
	/**
	 * �????基础信息自然状况统计�?
	 * @param cdcNatureReport
	 */
	@Trans
	public void update(CdcNatureReport cdcNatureReport);
	
	/**
	 * ??????基础信息自然状况统计�?
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);

	@Trans
	public void insert(CdcNatureInfo cdcNatureInfo,
			CdcNatureReport cdcNatureReport);

	@Trans
	public void update(CdcNatureInfo cdcNatureInfo,
			CdcNatureReport cdcNatureReport);

	@Trans
	public void sum(CdcNatureReport cdcNatureReport);

}