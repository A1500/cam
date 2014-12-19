package com.inspur.comm.cqm.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.dao.ICqmColDao;
import com.inspur.comm.cqm.base.data.CqmCol;

/**
 * 自定义统计报表属性表dao
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmColDao extends EntityDao<CqmCol> implements ICqmColDao {

	private static String DELETE_BYVIEWID = "delete from cqm_col where view_id=?";
	
	@Override
	public Class<CqmCol> getEntityClass() {
		return CqmCol.class;
	}

	public DataSet getViewCol(String viewLogic) {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from (");
		sql.append(viewLogic);
		sql.append(") where rownum=1");
		List<Map> list = executeQuery(sql.toString());
		DataSet ds = new DataSet();
		if (list.size() > 0) {
			Map map = list.get(0);
			Object[] key = map.keySet().toArray();
			for (int i = 0; i < key.length; i++) {
				CqmCol cqmCol = new CqmCol();
				cqmCol.setColCode(((String)key[i]).toLowerCase());
				ds.addRecord(cqmCol);
			}
		}
		return ds;
	}

	/**
	 * 删除 自定义统计报表属性表
	 * @param colId
	 */
	public void deleteByViewId(String viewId) {
		executeUpdate(DELETE_BYVIEWID, new int[]{ Types.VARCHAR }, new Object[]{ viewId });
	}

	public DataSet queryCols(ParameterSet pset) {
		String viewIds = (String) pset.getParameter("viewIds");
		String colIdsNotIn = (String) pset.getParameter("colIdsNotIn");
		String ifPrivilege = (String) pset.getParameter("ifPrivilege");
		
		List<Integer> typesList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.COL_ID,T.COL_TYPE,T.IF_ROW,T.INDEX_ID,");
		sql.append(" V.VIEW_NAME||':'||T.COL_NAME COL_NAME,T.COL_CODE,");
		sql.append("T.IF_COL,T.VIEW_ID FROM CQM_COL T,CQM_VIEW V WHERE 1 = 1 ");
		sql.append(" AND V.VIEW_ID = T.VIEW_ID ");
		if(viewIds!=null&&(!"".equals(viewIds))){
			String[] viewId = viewIds.split(",");
			sql.append("AND T.VIEW_ID IN (");
			for(int i = 0;i<viewId.length;i++){
				sql.append(" ?");
				if(i!=viewId.length-1){sql.append(",");}
				typesList.add(Types.VARCHAR);
				argsList.add(viewId[i]);
			}
			sql.append(" )");
	
		}
		if(ifPrivilege!=null&&(!"".equals(ifPrivilege))){
			sql.append(" AND T.IF_PRIVILEGE = '1' ");
		}else{
			sql.append(" AND T.IF_COL = '1' ");
		}
		if(colIdsNotIn!=null&&(!"".equals(colIdsNotIn))){
			sql.append(" AND T.COL_ID NOT IN (");
			String[] colIdNotIn = colIdsNotIn.split(",");
			for(int i = 0;i<colIdNotIn.length;i++){
				sql.append(" ?");
				if(i!=colIdNotIn.length-1){sql.append(",");}
				typesList.add(Types.VARCHAR);
				argsList.add(colIdNotIn[i]);
			}
			sql.append(")");
		}
		
		sql.append(" ORDER BY T.VIEW_ID");
		int[] types = new int[typesList.size()];
		for(int i = 0;i<types.length;i++){
			types[i] = typesList.get(i);
		}
		Object[] args = argsList.toArray();
		DataSet ds = this.executeDataset(sql.toString(),types,args,false);
		return ds;
	}

}