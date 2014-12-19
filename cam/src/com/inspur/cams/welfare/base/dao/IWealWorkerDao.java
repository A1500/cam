package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.data.WealWorker;

/**
 * @title:IWealWorkerDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealWorkerDao extends BaseCURD<WealWorker>{
	public void save(List<WealWorker> list);
	/**
	 * 查询 职工信息统计信息
	 * @param pset
	 * @return
	 */
	public DataSet queryFitWorkerSum(ParameterSet pset);
}

