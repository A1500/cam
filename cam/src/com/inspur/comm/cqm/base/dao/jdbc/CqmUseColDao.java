package com.inspur.comm.cqm.base.dao.jdbc;

import java.util.ArrayList;
import java.util.List;
import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.dao.ICqmUseColDao;
import com.inspur.comm.cqm.base.data.CqmUseCol;

/**
 * 自定义报表使用列dao
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmUseColDao extends EntityDao<CqmUseCol> implements ICqmUseColDao {
	
	@Override
	public Class<CqmUseCol> getEntityClass() {
		return CqmUseCol.class;
	}

	public DataSet queryUserCol(ParameterSet pset) {
		String reportId = (String) pset.getParameter("REPORT_ID");
		StringBuffer sql = new StringBuffer();
		List<Integer> typesList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT T.USE_COL_ID,T.REPORT_ID,T.COL_ID,");
		sql.append("T.COL_TYPE,T.INDEX_ID,V.VIEW_NAME||':'||T.COL_NAME COL_NAME,");
		sql.append("T.COL_CODE,T.VIEW_ID,T.VIEW_LOGIC,T.VIEW_CODE");
		sql.append(" FROM CQM_USE_COL T,CQM_VIEW V WHERE 1 = 1 AND V.VIEW_ID = T.VIEW_ID");
		if(reportId!=null&&(!"".equals(reportId))){
			sql.append(" AND T.REPORT_ID= ?");
			typesList.add(Types.VARCHAR);
			argsList.add(reportId);
		}
		sql.append(" ORDER BY T.VIEW_ID");
		int[] types = new int[typesList.size()];
		for(int i = 0;i<types.length;i++){
			types[i] = typesList.get(i);
		}
		Object[] args = argsList.toArray();
		DataSet ds = this.executeDataset(sql.toString(),types,args,true);
		return ds;
	}

	public void deleteByReportId(String reportId) {
		this.executeUpdate("DELETE FROM CQM_USE_COL C WHERE C.REPORT_ID = ?"
				,new int[]{Types.VARCHAR},new Object[]{reportId});
	}

}