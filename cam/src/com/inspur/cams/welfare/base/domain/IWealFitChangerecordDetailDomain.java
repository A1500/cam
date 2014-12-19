package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitChangerecordDetail;

/**
 * 假矫装配企业变更备案明细表domain
 * @author 
 * @date 2013-04-19
 */
public interface IWealFitChangerecordDetailDomain {

	/**
	 * 查询 假矫装配企业变更备案明细表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业变更备案明细表
	 * @param wealFitChangerecordDetail
	 */
	@Trans
	public void insert(WealFitChangerecordDetail wealFitChangerecordDetail);
	
	/**
	 * 修改 假矫装配企业变更备案明细表
	 * @param wealFitChangerecordDetail
	 */
	@Trans
	public void update(WealFitChangerecordDetail wealFitChangerecordDetail);
	
	/**
	 * 删除 假矫装配企业变更备案明细表
	 * @param detailId
	 */
	@Trans
	public void delete(String detailId);


}