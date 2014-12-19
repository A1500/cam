package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealFitProductivepower;

/**
 * 假矫装配企业生产能力信息domain
 * @author 
 * @date 2012-05-25
 */
public interface IWealFitProductivepowerDomain {

	/**
	 * 查询 假矫装配企业生产能力信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);


	/**
	 * 增加 假矫装配企业生产能力信息
	 * @param wealFitProductivepower
	 */
	@Trans
	public void insert(WealFitProductivepower wealFitProductivepower);
	
	/**
	 * 修改 假矫装配企业生产能力信息
	 * @param wealFitProductivepower
	 */
	@Trans
	public void update(WealFitProductivepower wealFitProductivepower);
	
	/**
	 * 删除 假矫装配企业生产能力信息
	 * @param produceId
	 */
	@Trans
	public void delete(String produceId);


}