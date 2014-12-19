package com.inspur.comm.cqm.base.domain.support;

import java.util.HashMap;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmColDao;
import com.inspur.comm.cqm.base.data.CqmCol;
import com.inspur.comm.cqm.base.domain.ICqmColDomain;
import com.inspur.comm.util.IdHelp;

/**
 * 自定义统计报表属性表domain
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmColDomain implements ICqmColDomain {

	@Reference
	private ICqmColDao cqmColDao;

	/**
	 * 查询 自定义统计报表属性表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmColDao.query(pset);
	}

	/**
	 * 获取视图的列
	 * @param viewLogic
	 * @return
	 */
	public DataSet getViewCol(String viewLogic) {
		return cqmColDao.getViewCol(viewLogic);
	}
	
	/**
	 * 增加 自定义统计报表属性表
	 * @param cqmCol
	 */
	@SuppressWarnings("unchecked")
	public void insert(CqmCol cqmCol) {
		cqmCol.setColId(IdHelp.getUUID32());
		cqmColDao.insert(cqmCol);
	}
	
	/**
	 * 修改 自定义统计报表属性表
	 * @param cqmCol
	 */
	public void update(CqmCol cqmCol) {
		cqmColDao.update(cqmCol);
	}
	
	/**
	 * 删除 自定义统计报表属性表
	 * @param colId
	 */
	public void delete(String colId) {
		cqmColDao.delete(colId);
	}

	/**
	 * 删除 自定义统计报表属性表
	 * @param colId
	 */
	public void deleteByViewId(String viewId) {
		cqmColDao.delete(viewId);
	}

	/**
	 * 自己拼装的查询
	 * @return
	 */
	public DataSet queryCols(ParameterSet pset) {
		return cqmColDao.queryCols(pset);
	}

	public CqmCol get(String relColId) {
		return cqmColDao.get(relColId);
	}

}