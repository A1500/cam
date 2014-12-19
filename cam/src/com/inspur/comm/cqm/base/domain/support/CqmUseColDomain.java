package com.inspur.comm.cqm.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmUseColDao;
import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.domain.ICqmUseColDomain;

/**
 * 自定义报表使用列domain
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseColDomain implements ICqmUseColDomain {

	@Reference
	private ICqmUseColDao cqmUseColDao;

	/**
	 * 查询 自定义报表使用列
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmUseColDao.query(pset);
	}

	/**
	 * 获取 自定义报表使用列
	 * @param pset
	 * @return
	 */
	public CqmUseCol get(String useColId) {
		return cqmUseColDao.get(useColId);
	}

	/**
	 * 增加 自定义报表使用列
	 * @param cqmUseCol
	 */
	public void insert(CqmUseCol cqmUseCol) {
		cqmUseColDao.insert(cqmUseCol);
	}
	
	/**
	 * 修改 自定义报表使用列
	 * @param cqmUseCol
	 */
	public void update(CqmUseCol cqmUseCol) {
		cqmUseColDao.update(cqmUseCol);
	}
	
	/**
	 * 删除 自定义报表使用列
	 * @param useColId
	 */
	public void delete(String useColId) {
		cqmUseColDao.delete(useColId);
	}

	public DataSet queryUserCol(ParameterSet pset) {
		return cqmUseColDao.queryUserCol(pset);
	}

	public void deleteByReportId(String reportId) {
		cqmUseColDao.deleteByReportId(reportId);
	}

}