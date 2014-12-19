package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionResult;

/**
 * 民主选举选举结果domain
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionResultDomain {

	/**
	 * 查询 民主选举选举结果
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 民主选举选举结果
	 * @param pset
	 * @return
	 */
	public CdcElectionResult get(String resultId);

	/**
	 * 增加 民主选举选举结果
	 * @param cdcElectionResult
	 */
	@Trans
	public void insert(CdcElectionResult cdcElectionResult);
	
	/**
	 * 修改 民主选举选举结果
	 * @param cdcElectionResult
	 */
	@Trans
	public void update(CdcElectionResult cdcElectionResult);
	
	/**
	 * 删除 民主选举选举结果
	 * @param resultId
	 */
	@Trans
	public void delete(String resultId);

}