package com.inspur.cams.fis.base.dao.jdbc;


import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.dao.IFisCemeCheckHistoryDao;
import com.inspur.cams.fis.base.data.FisCemeCheckHistory;

/**
 * 公墓年检整改历史记录表dao
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckHistoryDao extends EntityDao<FisCemeCheckHistory> implements IFisCemeCheckHistoryDao {
	
	@Override
	public Class<FisCemeCheckHistory> getEntityClass() {
		return FisCemeCheckHistory.class;
	}
	@SuppressWarnings("unchecked")
	public DataSet queryOrder(ParameterSet pset){
		 String cemeApplyId=(String)pset.getParameter("cemeApplyId");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT ");
		 sql.append("T.* ");
		 sql.append(" FROM  FIS_CEME_CHECK_HISTORY T ");
		 sql.append(" WHERE T.CEME_APPLY_ID= ? ");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(cemeApplyId);
		 //拆分自定义查询字段
		 sql.append(" ORDER BY T.FIRST_TIME DESC");
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		// System.out.println(sql.toString()+cemeApplyId);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		 
		
	}
	@SuppressWarnings("unchecked")
	public DataSet queryByCreateTime(ParameterSet pset){
		 String cemeApplyId=(String)pset.getParameter("cemeApplyId");
		  StringBuffer sql = new StringBuffer();
		 sql.append("SELECT ");
		 sql.append("T.* ");
		 sql.append(" FROM  FIS_CEME_CHECK_HISTORY T ");
		 sql.append(" WHERE T.CEME_APPLY_ID= ? ");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(cemeApplyId);
		 //拆分自定义查询字段
		 sql.append(" ORDER BY T.CREATE_TIME DESC");
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		// System.out.println(sql.toString()+cemeApplyId);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		 
		
	}
}