package com.inspur.comm.cqm.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.dao.ICqmUseSearchDao;
import com.inspur.comm.cqm.base.data.CqmUseSearch;

/**
 * 自定义报表查询逻辑dao
 * @author 
 * @date 2012-05-02
 */
public class CqmUseSearchDao extends EntityDao<CqmUseSearch> implements ICqmUseSearchDao {
	
	@Override
	public Class<CqmUseSearch> getEntityClass() {
		return CqmUseSearch.class;
	}

	public void deleteByReportId(String reportId) {
		this.executeUpdate("DELETE FROM CQM_USE_SEARCH S WHERE S.REPORT_ID =? ",
				new int[]{Types.VARCHAR},new Object[]{reportId});
	}

	public DataSet queryUserSearch(ParameterSet pset) {
		String reportId = (String) pset.getParameter("REPORT_ID");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT S.SEARCH_ID,S.REPORT_ID,S.VIEW_ID,");
		sql.append("S.COL_ID,S.COL_CODE,V.VIEW_NAME||':'||S.COL_NAME COL_NAME,");
		sql.append("S.COL_TYPE,S.INDEX_ID,S.SEARCH_OPER FROM CQM_USE_SEARCH S,CQM_VIEW V");
		sql.append(" WHERE V.VIEW_ID = S.VIEW_ID AND S.REPORT_ID =?");
		return this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{reportId}, true);
	}

}