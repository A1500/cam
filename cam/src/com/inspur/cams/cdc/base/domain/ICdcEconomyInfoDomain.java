package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcEconomyInfo;

/**
 * 基础信息社区资产状况信息表domain接口
 * @author shgtch
 * @date 2011-12-31
 */
public interface ICdcEconomyInfoDomain {

	/**
	 * 获取基础信息社区资产状况信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基础信息社区资产状况信息
	 * @param cdcEconomyInfo
	 */
	@Trans
	public void insert(CdcEconomyInfo cdcEconomyInfo);
	
	/**
	 * 修改基础信息社区资产状况信息
	 * @param cdcEconomyInfo
	 */
	@Trans
	public void update(CdcEconomyInfo cdcEconomyInfo);
	
	/**
	 * 删除基础信息社区资产状况信息
	 * @param economyId
	 */
	@Trans
	public void delete(String recordId);

	/**
	 * 对本单位数据进行汇总
	 * @param cdcDecisionInfo
	 */
	@Trans
	public void sum(CdcEconomyInfo cdcEconomyInfo);
	
}