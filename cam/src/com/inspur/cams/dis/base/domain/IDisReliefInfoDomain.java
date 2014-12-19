package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisReliefInfo;


public interface IDisReliefInfoDomain {
	
	 public void save(DisReliefInfo disReliefInfo);
	 
	 public void update(DisReliefInfo disReliefInfo);
	 
	 public void delete(DisReliefInfo disReliefInfo);
	 
	 public void batchDelete(String[] delIds);

	public void batchSubmit(String[] subIds);
	
	public void saveInfo(DisReliefInfo info);
	
	public boolean checkDelete(String infoId);
	
	public boolean checkUpdate(String infoId);

	public void batchDelete(String[] delIds, String batchDetailId);
	/**
	 * 查询任务列表救灾的信息
	 * @param pset
	 * @return
	 */
	public DataSet queryTaskInfo(ParameterSet pset);
	public DataSet query(ParameterSet pset);
	/**
	 * 获取各批次的核准信息及平均值
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchGatherDate(ParameterSet pset);
}

