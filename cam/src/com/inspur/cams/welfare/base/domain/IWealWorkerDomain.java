package com.inspur.cams.welfare.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.WealWorker;

/**
 * 职工信息表domain
 * 
 * @author
 * @date 2013-04-19
 */
public interface IWealWorkerDomain {

	/**
	 * 查询 职工信息表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加 职工信息表
	 * 
	 * @param wealWorker
	 */
	@Trans
	public void insert(WealWorker wealWorker);

	/**
	 * 修改 职工信息表
	 * 
	 * @param wealWorker
	 */
	@Trans
	public void update(WealWorker wealWorker);

	/**
	 * 删除 职工信息表
	 * 
	 * @param workerId
	 */
	@Trans
	public void delete(String workerId);

	/**
	 * 查询 职工信息统计信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryFitWorkerSum(ParameterSet pset);

	public DataSet queryUnitWorkerSum(ParameterSet pset);

	/**
	 * 查询 残疾职工明细
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnitWorkerDisability(ParameterSet pset);
	@Trans
	public void batchInsert(List<WealWorker> list);
	  
	@Trans
	public void batchUpdate(List<WealWorker> list);

	public DataSet getWorker(ParameterSet pset);

}