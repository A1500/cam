package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcFacilitiesReport;

/**
 * 社区建设基础设施统计Domain接口
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcFacilitiesReportDomain {

	/**
	 * 查询社区建设基础设施统计
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社区建设基础设施统计
	 * @param cdcFacilitiesReport
	 */
	@Trans
	public void insert(CdcFacilitiesReport cdcFacilitiesReport);
	
	/**
	 * 修改社区建设基础设施统计
	 * @param cdcFacilitiesReport
	 */
	@Trans
	public void update(CdcFacilitiesReport cdcFacilitiesReport);
	
	/**
	 * 删除社区建设基础设施统计
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);
	
	/**
	 * 汇总社区建设基础设施
	 */
	@Trans
	public void sum(CdcFacilitiesReport cdcFacilitiesReport);

	public DataSet queryList(ParameterSet pset);

	@Trans
	public void report(String id);

}