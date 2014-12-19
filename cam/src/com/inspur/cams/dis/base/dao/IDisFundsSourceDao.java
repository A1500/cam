package com.inspur.cams.dis.base.dao;

import java.util.List;
import java.util.Set;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;

/**
 * 资金拨付表dao
 * @author 
 * @date 2013-01-04
 */
public interface IDisFundsSourceDao extends BaseCURD<DisFundsSource> {
	/**
	 * @Description: 修改基本
	 * @author xuexzh
	 */
	void updateBase(DisFundsSourceBatch disFundsSourceBatch);
	
	/**
	 * @Description: 查询资金
	 * @author xuexzh
	 */
	DataSet queryFunds(ParameterSet pset);

	/**
	 * @Description: 删除关系数据-至临时表
	 * @author xuexzh
	 */
	void deleteRef(DisFundsSource disFundsSource);

	/**
	 * @Description: 关系数据的资金返还给源编码-重置关系数据
	 * @author xuexzh
	 */
	void resetRef(DisFundsSource disFundsSource);
	/**
	 * @Description: 确认拨付
	 * @author xuexzh
	 */
	void confirmAllocation(DisFundsSourceBatch disFundsSourceBatch);
	/**
	 * @Description: 删除批次
	 * @author xuexzh
	 */
	void deleteAllocation(DisFundsSourceBatch disFundsSourceBatch);

	
	/**
	 * @Description: 重新计算中间数据(仅市级)
	 * @author xuexzh
	 */
	void reComputeMid(Set<Object> refMidSourceIdSet);

	/**
	 * @Description: 查询资金-单条
	 * @author xuexzh
	 */
	DataSet queryFundsSingle(ParameterSet pset);

	/**
	 * @Description: 关系数据的资金返还给源编码-重置关系数据-根据源记录
	 * @author xuexzh
	 */
	void resetRefByOld(DisFundsSource oldDisFundsSource, DisFundsSource disFundsSource);

	/**
	 * @Description: 删除关系数据-至临时表-根据源数据
	 * @author xuexzh
	 */
	void deleteRefByOld(DisFundsSource oldDisFundsSource, DisFundsSource disFundsSource);
	
	/**
	 * @Description: 关系数据的资金返还给源编码-重置关系数据-置换
	 * @author xuexzh
	 */
	void resetRefBySwap(DisFundsSource disFundsSource);
	/**
	 * @Description: 删除关系数据-至临时表-置换
	 * @author xuexzh
	 */
	void deleteRefBySwap(DisFundsSource disFundsSource);
	
	/**
	 * @Description: 重新计算单条记录
	 * @author xuexzh
	 */
	void reCompute(DisFundsSource disFundsSource, String actionFundsType);

	/**
	 * @Description: 验证是否已使用
	 * @author xuexzh
	 */
	boolean validateIsUse(DisFundsSource disFundsSource);

	/**
	 * @Description: 获取本地投入总和与预算总和
	 * @author xuexzh
	 */
	String queryFundsAndBudget(ParameterSet parameterSet);

	/**
	 * @Description: 分配统计
	 * @author xuexzh
	 */
	DataSet queryAllocationForSums(ParameterSet pset);

	/**
	 * @Description: 置换统计
	 * @author xuexzh
	 */
	DataSet querySwapGoodsForSums(ParameterSet pset);

	/**
	 * @Description: 结余统计
	 * @author xuexzh
	 */
	DataSet queryFundsBalance(ParameterSet pset);
}