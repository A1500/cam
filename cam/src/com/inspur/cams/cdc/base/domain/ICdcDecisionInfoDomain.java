package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcDecisionInfo;

/**
 * 基层民主民主决策信息表domain接口
 * @author shgtch
 * @date 2011-12-20
 */
public interface ICdcDecisionInfoDomain {

	/**
	 * 查询基层民主民主决策信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基层民主民主决策信息
	 * @param cdcDecisionInfo
	 */
	@Trans
	public void insert(CdcDecisionInfo cdcDecisionInfo);
	
	/**
	 * 修改基层民主民主决策信息
	 * @param cdcDecisionInfo
	 */
	@Trans
	public void update(CdcDecisionInfo cdcDecisionInfo);

	/**
	 * 删除基层民主民主决策信息
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);
	
	/**
	 * 对本单位数据进行汇总
	 * @param cdcDecisionInfo
	 */
	@Trans
	public void sum(CdcDecisionInfo cdcDecisionInfo);

	/**
	 * 删除某次填报数据
	 * @param recordId 填报
	 * @param organCode 行政区划
	 */
	@Trans
	public void delete(String recordId, String organCode);
	
}