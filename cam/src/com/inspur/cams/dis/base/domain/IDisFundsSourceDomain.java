package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisFundsSource;

/**
 * 资金拨付表domain
 * @author 
 * @date 2013-01-04
 */
public interface IDisFundsSourceDomain {

	/**
	 * 查询 资金拨付表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 资金拨付表
	 * @param pset
	 * @return
	 */
	public DisFundsSource get(String sourceId);

	/**
	 * 增加 资金拨付表
	 * @param disFundsSource
	 */
	@Trans
	public void insert(DisFundsSource disFundsSource);
	
	/**
	 * 修改 资金拨付表
	 * @param disFundsSource
	 */
	@Trans
	public void update(DisFundsSource disFundsSource);
	
	/**
	 * 删除 资金拨付表
	 * @param sourceId
	 */
	@Trans
	public void delete(String sourceId);
	
	/**
	 * @Description: 查询资金
	 * @author xuexzh
	 */
	public DataSet queryFunds(ParameterSet pset);
	
	/**
	 * @Description: 查询资金-单条
	 * @author xuexzh
	 */
	public DataSet queryFundsSingle(ParameterSet pset);

	/**
	 * @Description: 获取本地投入总和与预算总和
	 * @author xuexzh
	 */
	public String queryFundsAndBudget(ParameterSet parameterSet);

	/**
	 * @Description: 分配统计
	 * @author xuexzh
	 */
	public DataSet queryAllocationForSums(ParameterSet pset);
	
	/**
	 * @Description: 置换统计
	 * @author xuexzh
	 */
	public DataSet querySwapGoodsForSums(ParameterSet pset);

	/**
	 * @Description: 结余统计
	 * @author xuexzh
	 */
	public DataSet queryFundsBalance(ParameterSet pset);

}