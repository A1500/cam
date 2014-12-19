package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisFundsSourceBatch;

/**
 * 资金拨付批次表domain
 * @author 
 * @date 2013-01-04
 */
public interface IDisFundsSourceBatchDomain {

	/**
	 * 查询 资金拨付批次表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 资金拨付批次表
	 * @param pset
	 * @return
	 */
	public DisFundsSourceBatch get(String batchId);

	/**
	 * 增加 资金拨付批次表
	 * @param disFundsSourceBatch
	 */
	@Trans
	public void insert(DisFundsSourceBatch disFundsSourceBatch);
	
	/**
	 * 修改 资金拨付批次表
	 * @param disFundsSourceBatch
	 */
	@Trans
	public void update(DisFundsSourceBatch disFundsSourceBatch);
	
	/**
	 * 删除 资金拨付批次表
	 * @param batchId
	 */
	@Trans
	public void delete(String batchId);

	/**
	 * @Description: 第一次增加
	 * @author xuexzh
	 */
	@Trans
	public void insertInit(DisFundsSourceBatch disFundsSourceBatch);

	/**
	 * @Description: 修改基本
	 * @author xuexzh
	 */
	@Trans
	public void updateInit(DisFundsSourceBatch disFundsSourceBatch);
	
	/**
	 * @Description: 拨付
	 * @author xuexzh
	 */
	@Trans
	public void allocation(ParameterSet parameterSet);
	/**
	 * @Description: 拨付-市县
	 * @author xuexzh
	 */
	@Trans
	public void allocationSingle(ParameterSet parameterSet);

	/**
	 * @Description: 确认拨付
	 * @author xuexzh
	 */
	@Trans
	public void confirmAllocation(DisFundsSourceBatch disFundsSourceBatch);
	
	/**
	 * @Description: 删除批次
	 * @author xuexzh
	 */
	@Trans
	public void deleteAllocation(DisFundsSourceBatch disFundsSourceBatch);

	/**
	 * @Description: 置换物资
	 * @author xuexzh
	 */
	@Trans
	public void swapMeterial(ParameterSet parameterSet);
}