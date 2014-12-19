package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcCaperInfo;

/**
 * 活动信息domain
 * @author 
 * @date 2013-02-26
 */
public interface ICdcCaperInfoDomain {

	/**
	 * 查询 活动信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 活动信息
	 * @param pset
	 * @return
	 */
	public CdcCaperInfo get(String caperId);

	/**
	 * 增加 活动信息
	 * @param cdcCaperInfo
	 */
	@Trans
	public void insert(CdcCaperInfo cdcCaperInfo);
	
	/**
	 * 修改 活动信息
	 * @param cdcCaperInfo
	 */
	@Trans
	public void update(CdcCaperInfo cdcCaperInfo);
	
	/**
	 * 删除 活动信息
	 * @param caperId
	 */
	@Trans
	public void deleteCaper(String caperId);

}