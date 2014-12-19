package com.inspur.comm.cqm.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;

import com.inspur.comm.cqm.base.data.CqmView;

/**
 * 自定义统计报表视图表dao
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmViewDao extends BaseCURD<CqmView> {
	
	/**
	 * 查询 根据模型视图关系查询视图字典
	 * @param pset
	 * @return
	 */
	public DataSet queryByViewRel(String moduleId);

}