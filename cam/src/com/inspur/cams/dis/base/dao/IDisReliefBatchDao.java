package com.inspur.cams.dis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisReliefBatch;
/**
 * @title:IDisReliefBatchDao
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 public interface IDisReliefBatchDao extends BaseCURD<DisReliefBatch>{
	 /**
	  * 查询统计批次记录
	  * @param pset
	  * @return
	  */
	public DataSet queryBatchStatis(ParameterSet pset);
	
	public DataSet queryBatchForRoster(ParameterSet pset);
}

