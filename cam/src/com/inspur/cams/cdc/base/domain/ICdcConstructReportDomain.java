package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcConstructInfo;
import com.inspur.cams.cdc.base.data.CdcConstructReport;

/**
 * 基础信息农村社区规划统计表domain接口
 * @author shgtch
 * @date 2012-2-7
 */
public interface ICdcConstructReportDomain {

	/**
	 * 查询基础信息农村社区规划统计信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基础信息农村社区规划统计信息
	 * @param cdcConstructInfo
	 */
	@Trans
	public void insert(CdcConstructReport cdcConstructReport);
	
	/**
	 * 修改基础信息农村社区规划统计信息
	 * @param cdcConstructInfo
	 */
	@Trans
	public void update(CdcConstructReport cdcConstructReportv);
	
	/**
	 * 删除基础信息农村社区规划统计信息
	 * @param constructId
	 */
	@Trans
	public void delete(String recordId);

	/**
	 * 对本单位数据进行汇总
	 * @param cdcDecisionInfo
	 */
	@Trans
	public void sum(CdcConstructReport cdcConstructReport);

	@Trans
	public void insert(CdcConstructReport cdcConstructReport,
			CdcConstructInfo cdcConstructinfo);

	@Trans
	public void update(CdcConstructReport cdcConstructReport,
			CdcConstructInfo cdcConstructinfo);
	
}