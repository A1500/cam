package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisCurrentMoney;

/**
 * 单位当前资金情况表domain
 * @author 
 * @date 2012-11-05
 */
public interface IDisCurrentMoneyDomain {

	/**
	 * 查询 单位当前资金情况表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 单位当前资金情况表
	 * @param pset
	 * @return
	 */
	public DisCurrentMoney get(String recordId);

	/**
	 * 增加 单位当前资金情况表
	 * @param disCurrentMoney
	 */
	@Trans
	public void insert(DisCurrentMoney disCurrentMoney);
	
	/**
	 * 修改 单位当前资金情况表
	 * @param disCurrentMoney
	 */
	@Trans
	public void update(DisCurrentMoney disCurrentMoney);
	
	/**
	 * 删除 单位当前资金情况表
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);

	@Trans
	public void updateOfOrgan(String receiveOrganCode);

}