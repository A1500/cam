package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionPrepare;

/**
 * 民主选举选举准备信息表domain
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionPrepareDomain {

	/**
	 * 查询 民主选举选举准备信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 民主选举选举准备信息表
	 * @param pset
	 * @return
	 */
	public CdcElectionPrepare get(String prepareId);

	/**
	 * 增加 民主选举选举准备信息表
	 * @param cdcElectionPrepare
	 */
	@Trans
	public void insert(CdcElectionPrepare cdcElectionPrepare);
	
	/**
	 * 修改 民主选举选举准备信息表
	 * @param cdcElectionPrepare
	 */
	@Trans
	public void update(CdcElectionPrepare cdcElectionPrepare);
	
	/**
	 * 删除 民主选举选举准备信息表
	 * @param prepareId
	 */
	@Trans
	public void delete(String prepareId);

	/**
	 * 查询汇总数据
	 * @param pset
	 * @return
	 */
	public DataSet querySum(ParameterSet pset);

}