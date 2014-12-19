package com.inspur.comm.cqm.base.dao;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.data.CqmIndex;

/**
 * 自定义统计报表指标表dao
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmIndexDao extends BaseCURD<CqmIndex> {

	/**
	 * 获取指标的条数
	 * @param indexDataSql
	 * @return
	 */
	public BigDecimal getIndexRowNum(CqmIndex cqmIndex,String organCode);
	
	/**
	 * 查询 指标代码
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getIndexData(String indexDataSql);

	/**
	 * 获取字典
	 * @param pset
	 * @return
	 */
	public DataSet getDic(ParameterSet pset);

}