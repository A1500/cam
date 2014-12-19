package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcPeopleReport;

/**
 * 基础信息两委成员与工作者统计表Domain接口类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcPeopleReportDomain {

	/**
	 * 查询基础信息两委成员与工作者统计表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	@Trans
	public void insert(CdcPeopleReport cdcPeopleReport);
	
	/**
	 * 修改基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	@Trans
	public void update(CdcPeopleReport cdcPeopleReport);
	
	/**
	 * 删除基础信息两委成员与工作者统计表
	 * @param reportId
	 */
	@Trans
	public void delete(String reportId);
	
	/**
	 * 汇总基础信息两委成员与工作者统计表
	 * @param cdcPeopleReport
	 */
	@Trans
	public void sum(CdcPeopleReport cdcPeopleReport);
}