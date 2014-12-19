package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionNominate;

/**
 * 民主选举候选人的产生domain
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionNominateDomain {

	/**
	 * 查询 民主选举候选人的产生
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 民主选举候选人的产生
	 * @param pset
	 * @return
	 */
	public CdcElectionNominate get(String nominateId);

	/**
	 * 增加 民主选举候选人的产生
	 * @param cdcElectionNominate
	 */
	@Trans
	public void insert(CdcElectionNominate cdcElectionNominate);
	
	/**
	 * 修改 民主选举候选人的产生
	 * @param cdcElectionNominate
	 */
	@Trans
	public void update(CdcElectionNominate cdcElectionNominate);
	
	/**
	 * 删除 民主选举候选人的产生
	 * @param nominateId
	 */
	@Trans
	public void delete(String nominateId);
	/**
	 * 查询汇总信息
	 * @param pset
	 * @return
	 */
	public DataSet querySum(ParameterSet pset);

}