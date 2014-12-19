package com.inspur.cams.cdc.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcServiceInfo;
import com.inspur.cams.cdc.base.data.CdcServiceReport;

/**
 * 基础信息社区服务统计�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcServiceReportDomain {

	/**
	 * ??��??基础信息社区服务统计�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基础信息社区服务统计�?
	 * @param cdcServiceReport
	 */
	@Trans
	public void insert(CdcServiceReport cdcServiceReport);
	
	/**
	 * �????基础信息社区服务统计�?
	 * @param cdcServiceReport
	 */
	@Trans
	public void update(CdcServiceReport cdcServiceReport);
	
	/**
	 * ??????基础信息社区服务统计�?
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);

	@Trans
	public void insert(List<CdcServiceInfo> infos,
			CdcServiceReport cdcServiceReport);

	@Trans
	public void update(List<CdcServiceInfo> infos,
			CdcServiceReport cdcServiceReport);

	@Trans
	public void sum(CdcServiceReport cdcServiceReport);

}