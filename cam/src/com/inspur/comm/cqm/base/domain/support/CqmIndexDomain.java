package com.inspur.comm.cqm.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmIndexDao;
import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.domain.ICqmIndexDomain;

/**
 * 自定义统计报表指标表domain
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmIndexDomain implements ICqmIndexDomain {

	@Reference
	private ICqmIndexDao cqmIndexDao;

	/**
	 * 查询 自定义统计报表指标表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmIndexDao.query(pset);
	}

	/**
	 * 获取报表行指标定义，同时获取行数
	 * @return
	 */
	public CqmIndex getRowIndex(String indexId,String organCode) {
		CqmIndex cqmIndex = cqmIndexDao.get(indexId);
		cqmIndex.setRowCount(cqmIndexDao.getIndexRowNum(cqmIndex,organCode));
		return cqmIndex;
	}
	
	/**
	 * 查询 指标代码
	 * @param pset
	 * @return
	 */
	public List getIndexData(String indexId) {
		CqmIndex cqmIndex = cqmIndexDao.get(indexId);
		StringBuffer sql = new StringBuffer();
		sql.append("select ");
		sql.append(cqmIndex.getIndexCode());
		sql.append(" code,");
		sql.append(cqmIndex.getIndexName());
		sql.append(" name from (");
		sql.append(cqmIndex.getIndexLogic());
		sql.append(")");
		
		return cqmIndexDao.getIndexData(sql.toString());
	}
	/**
	 * 查询 区间型指标代码
	 *@param pset
	 *@return
	 */
	public List getSectionIndexData(String indexId) {
		CqmIndex cqmIndex = cqmIndexDao.get(indexId);
		return cqmIndexDao.getIndexData(cqmIndex.getIndexLogic());
	}
	/**
	 * 获取字典
	 * @param pset
	 * @return
	 */
	public DataSet getDic(ParameterSet pset) {
		return cqmIndexDao.getDic(pset);
	}

	/**
	 * 增加 自定义统计报表指标表
	 * @param cqmIndex
	 */
	public void insert(CqmIndex cqmIndex) {
		cqmIndexDao.insert(cqmIndex);
	}
	
	/**
	 * 修改 自定义统计报表指标表
	 * @param cqmIndex
	 */
	public void update(CqmIndex cqmIndex) {
		cqmIndexDao.update(cqmIndex);
	}
	
	/**
	 * 删除 自定义统计报表指标表
	 * @param indexId
	 */
	public void delete(String indexId) {
		cqmIndexDao.delete(indexId);
	}

	public CqmIndex get(String indexId) {
		return cqmIndexDao.get(indexId);
	}

}