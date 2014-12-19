package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcConstructInfo;

/**
 * 基础信息农村社区规划信息domain接口
 * @author shgtch
 * @date 2012-2-7
 */
public interface ICdcConstructInfoDomain {

	/**
	 * 查询基础信息农村社区规划信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基础信息农村社区规划信息
	 * @param cdcConstructInfo
	 */
	@Trans
	public void insert(CdcConstructInfo cdcConstructInfo);
	
	/**
	 * 修改基础信息农村社区规划信息
	 * @param cdcConstructInfo
	 */
	@Trans
	public void update(CdcConstructInfo cdcConstructInfo);
	
	/**
	 * 删除基础信息农村社区规划信息
	 * @param constructId
	 */
	@Trans
	public void delete(String recordId);

}