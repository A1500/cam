package com.inspur.cams.dis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dis.base.dao.support.DisReliefBatchDao;
import com.inspur.cams.dis.base.data.DisReliefBatch;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDomain;

/**
 * @title:DisReliefDetailDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class DisReliefBatchDomain implements IDisReliefBatchDomain {

	 @Reference
	 DisReliefBatchDao disReliefBatchDao;
	 public DataSet query(ParameterSet pset){
		 return disReliefBatchDao.query(pset);
	 }
	 public void insert(DisReliefBatch disReliefBatch){
		 disReliefBatchDao.insert(disReliefBatch);
	 }
	 public void  update(DisReliefBatch disReliefBatch){
		 disReliefBatchDao.update(disReliefBatch);
	 }
	 public void delete(String disReliefBatchId){
		 disReliefBatchDao.delete(disReliefBatchId);
	 }
	 public void save(List<DisReliefBatch> list){
		 disReliefBatchDao.save(list);
	 }
	 /**
	  * 查询批次信息
	 * @param pset
	 * @return
	 */
	public DataSet queryBatch(ParameterSet pset){
		DataSet ds = disReliefBatchDao.queryBatch(pset);
		return ds;
	}
	
	/**
	 * 查询统计批次记录
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchStatis(ParameterSet pset) {
		DataSet ds = this.disReliefBatchDao.queryBatchStatis(pset);
		return ds;
	}
	public DataSet queryBatchForRoster(ParameterSet pset){
		DataSet ds = this.disReliefBatchDao.queryBatchForRoster(pset);
		return ds;
		
	}
}