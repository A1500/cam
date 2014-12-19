package com.inspur.cams.welfare.base.domain.support;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealWorkerDao;
import com.inspur.cams.welfare.base.data.WealWorker;
import com.inspur.cams.welfare.base.domain.IWealWorkerDomain;

/**
 * 职工信息表domain
 * 
 * @author
 * @date 2013-04-19
 */
public class WealWorkerDomain implements IWealWorkerDomain {

	private WealWorkerDao wealWorkerDao = (WealWorkerDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealWorkerDao");

	/**
	 * 查询 职工信息表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealWorkerDao.query(pset);
	}

	/**
	 * 增加 职工信息表
	 * 
	 * @param wealWorker
	 */
	public void insert(WealWorker wealWorker) {
		wealWorker.setWorkerId(IdHelp.getUUID32());
		wealWorkerDao.insert(wealWorker);
	}

	/**
	 * 修改 职工信息表
	 * 
	 * @param wealWorker
	 */
	public void update(WealWorker wealWorker) {
		wealWorkerDao.update(wealWorker);
	}

	/**
	 * 删除 职工信息表
	 * 
	 * @param workerId
	 */
	public void delete(String workerId) {
		wealWorkerDao.delete(workerId);
	}

	/**
	 * 查询 职工信息统计信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryFitWorkerSum(ParameterSet pset) {
		return wealWorkerDao.queryFitWorkerSum(pset);
	}

	public DataSet queryUnitWorkerSum(ParameterSet pset) {
		return wealWorkerDao.queryUnitWorkerSum(pset);
	}

	/**
	 * 查询 残疾职工明细
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnitWorkerDisability(ParameterSet pset) {
		return wealWorkerDao.queryUnitWorkerDisability(pset);
	}

	public void batchInsert(List<WealWorker> list) {
		// TODO Auto-generated method stub
		wealWorkerDao.batchInsert(list);
		
	}

	public void batchUpdate(List<WealWorker> list) {
		// TODO Auto-generated method stub
		wealWorkerDao.batchUpdate(list);
		
	}
   
	public DataSet getWorker(ParameterSet pset){
		return wealWorkerDao.getWorker(pset);
	}
}