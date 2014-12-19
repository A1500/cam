package com.inspur.cams.dis.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dis.base.dao.IDisFundsSourceDao;
import com.inspur.cams.dis.base.dao.IDisFundsSourceDetailDao;
import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.domain.IDisFundsSourceDomain;

/**
 * 资金拨付表domain
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceDomain implements IDisFundsSourceDomain {

	@Reference
	private IDisFundsSourceDao disFundsSourceDao;
	@Reference
	private IDisFundsSourceDetailDao disFundsSourceDetailDao;

	/**
	 * 查询 资金拨付表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return disFundsSourceDao.query(pset);
	}

	/**
	 * 获取 资金拨付表
	 * @param pset
	 * @return
	 */
	public DisFundsSource get(String sourceId) {
		return disFundsSourceDao.get(sourceId);
	}

	/**
	 * 增加 资金拨付表
	 * @param disFundsSource
	 */
	public void insert(DisFundsSource disFundsSource) {
		disFundsSourceDao.insert(disFundsSource);
		disFundsSourceDetailDao.save(disFundsSource.getDisFundsSourceDetailList());
	}
	
	/**
	 * 修改 资金拨付表
	 * @param disFundsSource
	 */
	public void update(DisFundsSource disFundsSource) {
		disFundsSourceDao.update(disFundsSource);
	}
	
	/**
	 * 删除 资金拨付表
	 * @param sourceId
	 */
	public void delete(String sourceId) {
		disFundsSourceDao.delete(sourceId);
		disFundsSourceDetailDao.deleteByRef(sourceId);
	}
	
	/**
	 * @Description: 查询资金
	 * @author xuexzh
	 */
	public DataSet queryFunds(ParameterSet pset) {
		return disFundsSourceDao.queryFunds(pset);
	}
	
	/**
	 * @Description: 查询资金-单条
	 * @author xuexzh
	 */
	public DataSet queryFundsSingle(ParameterSet pset) {
		return disFundsSourceDao.queryFundsSingle(pset);
	}
	
	/**
	 * @Description: 获取本地投入总和与预算总和
	 * @author xuexzh
	 */
	public String queryFundsAndBudget(ParameterSet parameterSet) {
		return disFundsSourceDao.queryFundsAndBudget(parameterSet);
	}
	
	/**
	 * @Description: 分配统计
	 * @author xuexzh
	 */
	public DataSet queryAllocationForSums(ParameterSet pset) {
		return disFundsSourceDao.queryAllocationForSums(pset);
	}

	/**
	 * @Description: 置换统计
	 * @author xuexzh
	 */
	public DataSet querySwapGoodsForSums(ParameterSet pset) {
		return disFundsSourceDao.querySwapGoodsForSums(pset);
	}
	
	/**
	 * @Description: 结余统计
	 * @author xuexzh
	 */
	public DataSet queryFundsBalance(ParameterSet pset) {
		return disFundsSourceDao.queryFundsBalance(pset);
	}
}