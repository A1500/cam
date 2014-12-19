package com.inspur.comm.cqm.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmUseViewDao;
import com.inspur.comm.cqm.base.data.CqmUseView;
import com.inspur.comm.cqm.base.domain.ICqmUseViewDomain;

/**
 * 自定义报表使用视图domain
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseViewDomain implements ICqmUseViewDomain {

	@Reference
	private ICqmUseViewDao cqmUseViewDao;

	/**
	 * 查询 自定义报表使用视图
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmUseViewDao.query(pset);
	}

	/**
	 * 获取 自定义报表使用视图
	 * @param pset
	 * @return
	 */
	public CqmUseView get(String useViewId) {
		return cqmUseViewDao.get(useViewId);
	}

	/**
	 * 增加 自定义报表使用视图
	 * @param cqmUseView
	 */
	public void insert(CqmUseView cqmUseView) {
		cqmUseViewDao.insert(cqmUseView);
	}
	
	/**
	 * 修改 自定义报表使用视图
	 * @param cqmUseView
	 */
	public void update(CqmUseView cqmUseView) {
		cqmUseViewDao.update(cqmUseView);
	}
	
	/**
	 * 删除 自定义报表使用视图
	 * @param useViewId
	 */
	public void delete(String useViewId) {
		cqmUseViewDao.delete(useViewId);
	}

	public void deleteByReportId(String reportId) {
		cqmUseViewDao.deleteByReportId(reportId);
	}

	public List<CqmUseView> getUseViews(String reportId) {
		ParameterSet pSet = new ParameterSet();
		List<CqmUseView> returnList = new ArrayList<CqmUseView>();
		pSet.clear();
		pSet.setParameter("REPORT_ID@=", reportId);
		DataSet ds = cqmUseViewDao.query(pSet);
		if(ds.getCount()>0){
			for(int i = 0;i<ds.getCount();i++){
				Record record = ds.getRecord(i);
				CqmUseView view = (CqmUseView) record.toBean(CqmUseView.class);
				returnList.add(view);
			}
			
		}
		return returnList;
	}

	public CqmUseView get(String reportId, String viewId) {
		return cqmUseViewDao.get(reportId,viewId);
	}

}