package com.inspur.cams.dis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisReliefInfo;
/**
 * @title:IDisReliefInfoDao
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 public interface IDisReliefInfoDao extends BaseCURD<DisReliefInfo>{
	public void save(List<DisReliefInfo> list);
	public DataSet query(ParameterSet pset);
	public void selectBatch(String batchDetailId);
	public DataSet queryTaskInfo(ParameterSet pset);
	/**
	 * 获取各批次的核准信息及平均值
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchGatherDate(ParameterSet pset);
}

