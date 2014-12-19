package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcElectionSup;

/**
 * 民主选举监督委员会domain
 * @author 
 * @date 2012-12-14
 */
public interface ICdcElectionSupDomain {

	/**
	 * 查询 民主选举监督委员会
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 民主选举监督委员会
	 * @param pset
	 * @return
	 */
	public CdcElectionSup get(String supId);

	/**
	 * 增加 民主选举监督委员会
	 * @param cdcElectionSup
	 */
	@Trans
	public void insert(CdcElectionSup cdcElectionSup);
	
	/**
	 * 修改 民主选举监督委员会
	 * @param cdcElectionSup
	 */
	@Trans
	public void update(CdcElectionSup cdcElectionSup);
	
	/**
	 * 删除 民主选举监督委员会
	 * @param supId
	 */
	@Trans
	public void delete(String supId);

}