package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitStatus;

/**
 * 假矫装配企业当前状态表domain
 * @author 
 * @date 2013-04-19
 */
public interface IWealFitStatusDomain {

	/**
	 * 查询 假矫装配企业当前状态表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业当前状态表
	 * @param wealFitStatus
	 */
	@Trans
	public void insert(WealFitStatus wealFitStatus);
	
	/**
	 * 修改 假矫装配企业当前状态表
	 * @param wealFitStatus
	 */
	@Trans
	public void update(WealFitStatus wealFitStatus);
	
	/**
	 * 删除 假矫装配企业当前状态表
	 * @param fitId
	 */
	@Trans
	public void delete(String fitId);


}