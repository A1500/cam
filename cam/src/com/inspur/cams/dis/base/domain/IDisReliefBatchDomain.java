package com.inspur.cams.dis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisReliefBatch;
import com.inspur.cams.dis.base.data.DisReliefInfo;


public interface IDisReliefBatchDomain {
	
	public DataSet query(ParameterSet pset);
	public void insert(DisReliefBatch disReliefBatch);
	public void  update(DisReliefBatch disReliefBatch);
	public void delete(String disReliefBatchId);
	public void save(List<DisReliefBatch> list);
	/**
	  * 查询批次信息
	 * @param pset
	 * @return
	 */
	public DataSet queryBatch(ParameterSet pset);
	
	/**
	 * 查询统计批次记录
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchStatis(ParameterSet pset);
	
	public DataSet queryBatchForRoster(ParameterSet pset);
}

