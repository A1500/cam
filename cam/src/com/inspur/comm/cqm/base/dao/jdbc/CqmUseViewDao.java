package com.inspur.comm.cqm.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.dao.ICqmUseViewDao;
import com.inspur.comm.cqm.base.data.CqmUseView;
import java.sql.Types;
/**
 * 自定义报表使用视图dao
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseViewDao extends EntityDao<CqmUseView> implements ICqmUseViewDao {
	
	@Override
	public Class<CqmUseView> getEntityClass() {
		return CqmUseView.class;
	}

	public void deleteByReportId(String reportId) {
		this.executeUpdate("DELETE FROM CQM_USE_VIEW T WHERE T.REPORT_ID=?",
				new int[]{Types.VARCHAR},new Object[]{reportId});
	}

	public CqmUseView get(String reportId, String viewId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("REPORT_ID@=", reportId);
		pset.setParameter("VIEW_ID@=", viewId);
		DataSet ds = this.query(pset);
		if(ds.getCount()>0){
			CqmUseView userView  = (CqmUseView) (ds.getRecord(0)).toBean(CqmUseView.class);
			return userView;
		}
		return null;
	}

}