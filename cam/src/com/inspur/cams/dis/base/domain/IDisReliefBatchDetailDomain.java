package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisReliefBatchDetail;


public interface IDisReliefBatchDetailDomain {
	public  void insert(DisReliefBatchDetail reliefBatchDetail);
	public DataSet query(ParameterSet pset);
	/**
	 * 根据批次id查询批次详细信息
	 */
	public DataSet queryBatchDetailByDetailId(ParameterSet pSet);
	/**
	 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
	 */
	public void deleteByDetailIdOrganCode(String DetailId,String requiredOrganCode);
	
	public DataSet queryBatchDetail(ParameterSet pset);
	/**
	 * 查询批次（冬春生活，因灾死亡，灾区民房）
	 * @param pset
	 * @return
	 */
	public DataSet queryAssistanceBatch(ParameterSet pset);
	
	public String batchSubmit(String subId);
	public void  update (DisReliefBatchDetail reliefBatchDetail);
	/**
	 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
	 */
	public void deleteByBatchId(String BatchId);
	
	/**
	 * 救灾批次明细查询
	 * @param pset
	 * @return
	 */
	public DataSet queryDetail(ParameterSet pset);
}

