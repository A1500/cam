package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitChangerecord;

/**
 * 假矫装配企业变更备案表domain
 * @author 
 * @date 2013-04-19
 */
public interface IWealFitChangerecordDomain {

	/**
	 * 查询 假矫装配企业变更备案表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业变更备案表
	 * @param wealFitChangerecord
	 */
	@Trans
	public void insert(WealFitChangerecord wealFitChangerecord);
	
	/**
	 * 修改 假矫装配企业变更备案表
	 * @param wealFitChangerecord
	 */
	@Trans
	public void update(WealFitChangerecord wealFitChangerecord);
	
	/**
	 * 删除 假矫装配企业变更备案表
	 * @param changeId
	 */
	@Trans
	public void delete(String changeId);


}