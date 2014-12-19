package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcOrganReport;

/**
 * 基础信息社区单位组织统计表domain接口
 * @author shgtch
 * @date 2011-12-31
 */
public interface ICdcOrganReportDomain {

	/**
	 * 查询基础信息社区单位组织统计表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基础信息社区单位组织统计表
	 * @param cdcOrganReprot
	 */
	@Trans
	public void insert(CdcOrganReport cdcOrganReport);
	
	/**
	 * 修改基础信息社区单位组织统计表
	 * @param cdcOrganReprot
	 */
	@Trans
	public void update(CdcOrganReport cdcOrganReport);
	
	/**
	 * 删除基础信息社区单位组织统计表
	 * @param reprotId
	 */
	@Trans
	public void delete(String reprotId);

	/**
	 * 对本单位数据进行汇总
	 * @param cdcPopulateInfo
	 */
	@Trans
	public void sum(CdcOrganReport cdcOrganReport);

	public DataSet queryList(ParameterSet pset);

	@Trans
	public void report(String id);
	
}