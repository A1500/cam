package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitApply;

/**
 * 假矫装配企业业务表domain
 * @author 
 * @date 2012-05-25
 */
public interface IWealFitApplyDomain {

	/**
	 * 查询 假矫装配企业业务表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业业务表
	 * @param wealFitApply
	 */
	@Trans
	public void insert(WealFitApply wealFitApply);
	
	/**
	 * 修改 假矫装配企业业务表
	 * @param wealFitApply
	 */
	@Trans
	public void update(WealFitApply wealFitApply);
	
	/**
	 * 删除 假矫装配企业业务表
	 * @param taskCode
	 */
	@Trans
	public void delete(String taskCode);

	@Trans
	public DataSet queryQualificationList(ParameterSet pset);
	
	public DataSet queryQualificationPrintList(ParameterSet pset);


}