package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitInfo;

/**
 * 假矫装配企业（业务类别：认定、年检、换证）业务信息表domain
 * @author 
 * @date 2013-04-19
 */
public interface IWealFitInfoDomain {

	/**
	 * 查询 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param wealFitInfo
	 */
	@Trans
	public void insert(WealFitInfo wealFitInfo);
	
	/**
	 * 修改 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param wealFitInfo
	 */
	@Trans
	public void update(WealFitInfo wealFitInfo);
	
	/**
	 * 删除 假矫装配企业（业务类别：认定、年检、换证）业务信息表
	 * @param taskCode
	 */
	@Trans
	public void delete(String taskCode);


}