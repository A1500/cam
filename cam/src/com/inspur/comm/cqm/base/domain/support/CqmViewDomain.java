package com.inspur.comm.cqm.base.domain.support;

import java.util.HashMap;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmViewDao;
import com.inspur.comm.cqm.base.data.CqmCol;
import com.inspur.comm.cqm.base.data.CqmView;
import com.inspur.comm.cqm.base.domain.ICqmColDomain;
import com.inspur.comm.cqm.base.domain.ICqmViewDomain;
import com.inspur.comm.util.IdHelp;

/**
 * 自定义统计报表视图表domain
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewDomain implements ICqmViewDomain {

	@Reference
	private ICqmViewDao cqmViewDao;
	
	@Reference
	private ICqmColDomain cqmColDomain;

	/**
	 * 查询 自定义统计报表视图表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmViewDao.query(pset);
	}

	/**
	 * 查询 根据模型视图关系查询视图字典
	 * @param pset
	 * @return
	 */
	public DataSet queryByViewRel(String moduleId) {
		return cqmViewDao.queryByViewRel(moduleId);
	}

	/**
	 * 增加 自定义统计报表视图表
	 * @param cqmView
	 */
	@SuppressWarnings("unchecked")
	public void insert(CqmView cqmView) {
		cqmView.setViewId(IdHelp.getUUID32());
		cqmViewDao.insert(cqmView);
		
		List<CqmCol> cqmPropertyList = cqmView.getCqmColList();
		for (int i = 0; i < cqmPropertyList.size(); i++) {
			CqmCol cqmCol = (CqmCol) cqmPropertyList.get(i);
			cqmCol.setViewId(cqmView.getViewId());
			cqmColDomain.insert(cqmCol);
		}
	}
	
	/**
	 * 修改 自定义统计报表视图表
	 * @param cqmView
	 */
	public void update(CqmView cqmView) {
		List<CqmCol> cqmColList = cqmView.getCqmColList();
		for (int i = 0; i < cqmColList.size(); i++) {
			CqmCol cqmCol = (CqmCol) cqmColList.get(i);
			if (cqmCol.getState() == Record.STATE_NEW) {
				cqmCol.setViewId(cqmView.getViewId());
				cqmColDomain.insert(cqmCol);
			} else if (cqmCol.getState() == Record.STATE_MODIFIED) {
				cqmColDomain.update(cqmCol);
			} else if (cqmCol.getState() == Record.STATE_DELETED) {
				cqmColDomain.delete(cqmCol.getColId());
			}
		}
		cqmViewDao.update(cqmView);
	}
	
	/**
	 * 删除 自定义统计报表视图表
	 * @param viewId
	 */
	public void delete(String viewId) {
		cqmColDomain.deleteByViewId(viewId);
		cqmViewDao.delete(viewId);
	}

}