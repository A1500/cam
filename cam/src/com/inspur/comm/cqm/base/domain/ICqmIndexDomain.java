package com.inspur.comm.cqm.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmIndex;

/**
 * 自定义统计报表指标表domain
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmIndexDomain {

	/**
	 * 查询 自定义统计报表指标表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取报表行指标定义，同时获取行数
	 * @return
	 */
	public CqmIndex getRowIndex(String indexId,String organCode);
	
	/**
	 * 查询 指标代码
	 * @param pset
	 * @return
	 */
	public List getIndexData(String indexId);

	/**
	 * 获取字典
	 * @param pset
	 * @return
	 */
	public DataSet getDic(ParameterSet pset);

	/**
	 * 增加 自定义统计报表指标表
	 * @param cqmIndex
	 */
	@Trans
	public void insert(CqmIndex cqmIndex);
	
	/**
	 * 修改 自定义统计报表指标表
	 * @param cqmIndex
	 */
	@Trans
	public void update(CqmIndex cqmIndex);
	
	/**
	 * 删除 自定义统计报表指标表
	 * @param indexId
	 */
	@Trans
	public void delete(String indexId);

	public CqmIndex get(String indexId);

	/**
	 * 查询 指标代码
	 * @param indexId
	 * @return
	 */
	public List getSectionIndexData(String indexId);

}