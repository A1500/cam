package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisFundsSourceDomain;

/**
 * 资金拨付表查询cmd
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceQueryCmd extends BaseQueryCommand {

	private IDisFundsSourceDomain disFundsSourceDomain = ScaComponentFactory
			.getService(IDisFundsSourceDomain.class, "disFundsSourceDomain/disFundsSourceDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDomain.query(pset);
	}
	
	/**
	 * @Description: 查询资金
	 * @author xuexzh
	 */
	public DataSet queryFunds() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDomain.queryFunds(pset);
	} 
	
	/**
	 * @Description: 查询资金-单条
	 * @author xuexzh
	 */
	public DataSet queryFundsSingle() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDomain.queryFundsSingle(pset);
	} 
	
	/**
	 * @Description: 分配统计
	 * @author xuexzh
	 */
	public DataSet queryAllocationForSums() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDomain.queryAllocationForSums(pset);
	} 
	
	/**
	 * @Description: 置换统计
	 * @author xuexzh
	 */
	public DataSet querySwapGoodsForSums() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDomain.querySwapGoodsForSums(pset);
	} 
	
	/**
	 * @Description: 结余统计
	 * @author xuexzh
	 */
	public DataSet queryFundsBalance() {
		ParameterSet pset = getParameterSet();
		return disFundsSourceDomain.queryFundsBalance(pset);
	} 
}