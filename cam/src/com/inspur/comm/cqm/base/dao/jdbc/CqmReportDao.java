package com.inspur.comm.cqm.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.share.permit.bean.RoleView;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.comm.cqm.base.dao.ICqmReportDao;
import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.data.CqmReport;
import com.inspur.comm.cqm.base.data.CqmUseCol;
import com.inspur.comm.cqm.base.data.CqmUseSearch;
import com.inspur.comm.cqm.base.data.CqmUseView;
import com.inspur.comm.cqm.base.data.ReportData;
import com.inspur.comm.cqm.base.data.ReportRow;

/**
 * 自定义统计报表dao
 * @author shgtch
 * @date 2012-03-22
 */
public class CqmReportDao extends EntityDao<CqmReport> implements ICqmReportDao {
	
	@Override
	public Class<CqmReport> getEntityClass() {
		return CqmReport.class;
	}

	/**
	 * 查询报表行
	 * @param rowLogic
	 * @return
	 */
	public DataSet getReportRow(String organCode,CqmIndex cqmIndex) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if ("0".equals(cqmIndex.getIfLoadOnce())) {
			sql.append("select * from (select row_.*,rownum rownum_ from (");
		}
		sql.append("select * from (select  ");
		sql.append(cqmIndex.getIndexCode());
		sql.append(" code,");
		sql.append(cqmIndex.getIndexName());
		sql.append(" name from (");
		sql.append(cqmIndex.getIndexLogic());
		sql.append(")) ");
		if(cqmIndex.getIndexLogic().contains("dic_city")){
			sql.append(" where code like ?  ");
			if (organCode.endsWith("0000000000")){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2)+"%");
			}else if(organCode.endsWith("00000000")){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0,4)+"%");
			}else {
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6)+"%");
			}
		}
		if ("0".equals(cqmIndex.getIfLoadOnce())) {
			sql.append(") row_ where rownum<=?) where rownum_>?");
			typeList.add(Types.INTEGER);
			argsList.add(cqmIndex.getEnd());
			typeList.add(Types.INTEGER);
			argsList.add(cqmIndex.getStart());
		}
		List<Map<String, String>> list = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		if(types.length>0){
			list = executeQuery(sql.toString(),types,args);
		}else{
			list = executeQuery(sql.toString());
		}
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map<String, String> map = list.get(i);
			ReportRow reportRow = new ReportRow();
			reportRow.setCode(map.get("CODE"));
			reportRow.setName(map.get("NAME"));
			ds.addRecord(reportRow);
		}
		return ds;
	}
	
	public DataSet getReportData(String organCode,CqmUseCol cqmUseCol, CqmUseView userUseView,
			CqmIndex cqmIndex, List cqmUseSearchList) {
		StringBuffer querySql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if ("D".equals(cqmUseCol.getColType())) {
			querySql.append("select ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append("||'");
			querySql.append(cqmUseCol.getColId());
			querySql.append("'||");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" P,count(*) V from (");
			querySql.append(cqmUseCol.getViewLogic());
			if(cqmUseCol.getViewLogic().contains( "where")){
			}else{
				querySql.append(" where 1=1 ");
			}
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(userUseView!=null&&userUseView.getPrivilegeCode()!= null){
				if("1".equals(userUseView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}			
			querySql.append(") where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (");
			if ("0".equals(cqmIndex.getIfLoadOnce())) {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (select row_.*,rownum rownum_ from ( select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from ( ");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
				}
				querySql.append(") row_ where rownum<=?) where rownum_>?");
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getEnd());
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getStart());
			} else {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
				}
			}
			querySql.append(")");
			// 增加查询条件
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(",");
			querySql.append(cqmUseCol.getViewCode());
			
			
			querySql.append(" union select ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append("||'");
			querySql.append(cqmUseCol.getColId());
			querySql.append("CODE' P,count(*) V from (");
			querySql.append(cqmUseCol.getViewLogic());
			if(cqmUseCol.getViewLogic().contains( "where")){
			}else{
				querySql.append(" where 1=1 ");
			}
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(userUseView!=null&&userUseView.getPrivilegeCode()!= null){
				if("1".equals(userUseView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}			
			querySql.append(") where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (");
			if ("0".equals(cqmIndex.getIfLoadOnce())) {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (select row_.*,rownum rownum_ from ( select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from ( ");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
				}
				querySql.append(") row_ where rownum<=?) where rownum_>?");
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getEnd());
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getStart());
			} else {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
				}
			}
			querySql.append(")");
			// 增加查询条件
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getViewCode());
		}
		if ("S".equals(cqmUseCol.getColType())) {
			querySql.append("select ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append("||'");
			querySql.append(cqmUseCol.getColId());
			querySql.append("' P,nvl(sum(");
			querySql.append(cqmUseCol.getColCode());
			querySql.append("),0) V from (");
			querySql.append(cqmUseCol.getViewLogic());
			if(cqmUseCol.getViewLogic().contains( "where")){
			}else{
				querySql.append(" where 1=1 ");
			}
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(userUseView!=null&&userUseView.getPrivilegeCode()!= null){
				if("1".equals(userUseView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}
			querySql.append(" ) where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (");
			if ("0".equals(cqmIndex.getIfLoadOnce())) {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (select row_.*,rownum rownum_ from ( select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from ( ");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
				}
				querySql.append(") row_ where rownum<=?) where rownum_>?");
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getEnd());
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getStart());
			} else {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
				}
			}
			querySql.append(")");
			// 增加查询条件
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getViewCode());
		}
		List<Map> list = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		list = executeQuery(querySql.toString(),types, args);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			ReportData reportData = new ReportData();
			reportData.setPoint((String) map.get("P"));
			reportData.setValue((BigDecimal) map.get("V"));
			ds.addRecord(reportData);
		}
		return ds;
	}


	/**
	 * 查询报表合计数据
	 * @param logic
	 * @return
	 */
	public DataSet getReportSum(String organCode,CqmUseCol cqmUseCol,CqmUseView userUseView,
			CqmIndex cqmIndex, List cqmUseSearchList) {
		StringBuffer querySql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if ("D".equals(cqmUseCol.getColType())) {
			querySql.append("select '");
			querySql.append(cqmUseCol.getColId());
			querySql.append("'||");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" P,count(*) V from (");
			querySql.append(cqmUseCol.getViewLogic());
			if(cqmUseCol.getViewLogic().contains( "where")){
			}else{
				querySql.append(" where 1=1 ");
			}
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(userUseView!=null&&userUseView.getPrivilegeCode()!= null){
				if("1".equals(userUseView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}	
			querySql.append(") where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (select ");
			querySql.append(cqmIndex.getIndexCode());
			querySql.append(" from (");
			querySql.append(cqmIndex.getIndexLogic());
			querySql.append(")");
			if(cqmIndex.getIndexLogic().contains("dic_city")){
				querySql.append(" where 1=1 and ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" like ?  ");
				if (organCode.endsWith("0000000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				}else if(organCode.endsWith("00000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,4)+"%");
				}else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
			querySql.append(")");
			// 增加查询条件
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getColCode());
			
			querySql.append(" union select '");
			querySql.append(cqmUseCol.getColId());
			querySql.append("CODE' P,count(*) V from (");
			querySql.append(cqmUseCol.getViewLogic());
			if(cqmUseCol.getViewLogic().contains( "where")){
			}else{
				querySql.append(" where 1=1 ");
			}
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(userUseView!=null&&userUseView.getPrivilegeCode()!= null){
				if("1".equals(userUseView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}	
			querySql.append(") where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (select ");
			querySql.append(cqmIndex.getIndexCode());
			querySql.append(" from (");
			querySql.append(cqmIndex.getIndexLogic());
			querySql.append(")");
			if(cqmIndex.getIndexLogic().contains("dic_city")){
				querySql.append(" where 1=1 and ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" like ?  ");
				if (organCode.endsWith("0000000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				}else if(organCode.endsWith("00000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,4)+"%");
				}else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
			querySql.append(")");
			// 增加查询条件
		}
		if ("S".equals(cqmUseCol.getColType())) {
			querySql.append("select '");
			querySql.append(cqmUseCol.getColId());
			querySql.append("' P,nvl(sum(");
			querySql.append(cqmUseCol.getColCode());
			querySql.append("),0) V from (");
			querySql.append(cqmUseCol.getViewLogic());
			if(cqmUseCol.getViewLogic().contains( "where")){
			}else{
				querySql.append(" where 1=1 ");
			}
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(userUseView!=null&&userUseView.getPrivilegeCode()!= null){
				if("1".equals(userUseView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}	
			querySql.append(") where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (select ");
			querySql.append(cqmIndex.getIndexCode());
			querySql.append(" from (");
			querySql.append(cqmIndex.getIndexLogic());
			querySql.append(")");
			if(cqmIndex.getIndexLogic().contains("dic_city")){
				querySql.append(" where 1=1 and ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" like ?  ");
				if (organCode.endsWith("0000000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				}else if(organCode.endsWith("00000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,4)+"%");
				}else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
			querySql.append(")");
			// 增加查询条件
		}
		List<Map> list = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		list = executeQuery(querySql.toString(),types,args);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			ReportData reportData = new ReportData();
			reportData.setPoint((String) map.get("P"));
			reportData.setValue((BigDecimal) map.get("V"));
			ds.addRecord(reportData);
		}
		return ds;
	}
	
	// 拼装查询条件
	private void getSearchSql(StringBuffer querySql, List cqmUseSearchList, CqmUseCol cqmUseCol) {
		// 增加查询条件
		for (int i = 0; i < cqmUseSearchList.size(); i++) {
			CqmUseSearch cqmUseSearch = (CqmUseSearch) ((Record) cqmUseSearchList.get(i)).toBean(CqmUseSearch.class);
			if (cqmUseSearch.getViewId().equals(cqmUseCol.getViewId())) {
				// 如果是精确查询
				if ("J".equals(cqmUseSearch.getSearchOper())) {
					if("DA".equals(cqmUseSearch.getColType())){
						String colValue = cqmUseSearch.getStartValue();
						int length = colValue.length(); 
						querySql.append( " and substr("+cqmUseSearch.getColCode()+",0," +length+" ) ");
						querySql.append("='");
						querySql.append(cqmUseSearch.getStartValue());
						querySql.append("'");
					}else{
						querySql.append(" and ");
						querySql.append(cqmUseSearch.getColCode());
						querySql.append("='");
						querySql.append(cqmUseSearch.getStartValue());
						querySql.append("'");
					}
				}
				// 如果是范围查询
				if ("F".equals(cqmUseSearch.getSearchOper())) {
					if (cqmUseSearch.getStartValue() != null && !"".equals(cqmUseSearch.getStartValue())) {
						querySql.append(" and ");
						querySql.append(cqmUseSearch.getColCode());
						querySql.append(">='");
						querySql.append(cqmUseSearch.getStartValue());
						querySql.append("'");
					}
					if (cqmUseSearch.getEndValue() != null && !"".equals(cqmUseSearch.getEndValue())) {
						querySql.append(" and ");
						querySql.append(cqmUseSearch.getColCode());
						querySql.append("<='");
						querySql.append(cqmUseSearch.getEndValue());
						querySql.append("'");
					}
				}
			}
		}
	}

	public DataSet queryReport(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typesList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT R.REPORT_TITLE,R.REPORT_NAME,R.CREATE_ORGAN,R.IF_LAYERED,");
		sql.append("R.MODULE_ID,R.IF_SUM,R.CREATE_TIME,R.REPORT_ID,R.CREATE_PEOPLE,");
		sql.append("R.PAGE_NUM,R.ROW_INDEX_ID FROM CQM_REPORT R,CQM_MODULE M");
		sql.append(" WHERE 1 = 1 AND M.MODULE_ID = R.MODULE_ID");
		RoleView[] roles = (RoleView[]) pset.getParameter("roles");
		if(roles.length>0){
			sql.append("  AND M.MODULE_ROLE IN (");
			for (int i = 0 ;i<roles.length;i++) {
				if(i!=0){
					sql.append(",");
				}
				sql.append("?");
				typesList.add(Types.VARCHAR);
				argsList.add(roles[i].getRoleId());
			}
			sql.append(")");
		}
		int[] types = new int[typesList.size()];
		for(int i = 0;i<types.length;i++ ){
			types[i] = typesList.get(i);
		}
		Object[] args = argsList.toArray();
		return this.executeDataset(sql.toString(),types,args,true);
	}

	public DataSet getReportLayeredRow(String organCode,boolean ifUnder) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typesList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if(ifUnder){
			if (organCode.endsWith("0000000000")){
				sql.append(" select id code,name  from dic_city where leve = '1' or id = '370000000000' order by id ");
			}else if(organCode.endsWith("00000000")){
				sql.append(" select id code,name  from dic_city where (leve = '2' and id like ?) or id = ? order by id ");
				typesList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0,4)+"%");
				typesList.add(Types.VARCHAR);
				argsList.add(organCode);
			}else if(organCode.endsWith("000000")) {
				sql.append(" select id code,name  from dic_city where (leve = '3' and id like ? and is_self ='0') or id = ? order by id ");
				typesList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0,6)+"%");
				typesList.add(Types.VARCHAR);
				argsList.add(organCode);
			}else{
				sql.append(" select id code,name  from dic_city where id = ? ");
				typesList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
		}else{
			sql.append(" select id code,name  from dic_city where id = ? ");
			typesList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if(typesList.size()>0){
			int[] types = new int[typesList.size()];
			for(int i = 0; i<typesList.size();i++){
				types[i] = typesList.get(i);
			}
			Object[] args = argsList.toArray();
			return this.executeDataset(sql.toString(),types,args,true);
		}else{
			return this.executeDataset(sql.toString(),true) ;
		}
	}
	public DataSet getReportLayeredData(String organCode,CqmUseCol cqmUseCol, CqmUseView userUseView, List cqmUseSearchList) {
		StringBuffer querySql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		int n_yxws = 2;
		int n_yxws_xj = 4;
		if (organCode.endsWith("0000000000")){
			n_yxws = 2;
			n_yxws_xj = 4;
		}else if(organCode.endsWith("00000000")){
			n_yxws = 4;
			n_yxws_xj = 6;
		}else if(organCode.endsWith("000000")){
			n_yxws = 6;
			n_yxws_xj = 9;
		}else{
			n_yxws = 9;
			n_yxws_xj = 12;
		}
		if ("D".equals(cqmUseCol.getColType())) {
			if("1".equals(userUseView.getIfUndering())){
				querySql.append("select P,V,XZQH from ( select  rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1,"+n_yxws_xj);
				querySql.append("), 12, 0) ||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append("'||");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" P ,count(*) V,rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1,"+n_yxws_xj);
				querySql.append("), 12, 0) XZQH from (");
				querySql.append(cqmUseCol.getViewLogic());
				querySql.append(" ) where 1=1  and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(" group by ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(",rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1,"+n_yxws_xj );
				querySql.append("), 12, 0) union select rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1,"+n_yxws_xj);
				querySql.append("), 12, 0) ||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append("CODE' P ,count(*) V,rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1,"+n_yxws_xj);
				querySql.append("), 12, 0) XZQH from (");
				querySql.append(cqmUseCol.getViewLogic());
				querySql.append(" ) where 1=1   and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(" group by rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1,"+n_yxws_xj );
				querySql.append("), 12, 0) )where XZQH in (select id from dic_city where ups = '");
				querySql.append(organCode);
				querySql.append("' and is_self ='0') union select '");
				querySql.append(organCode);
				querySql.append("'||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append("'||");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" P ,count(*) V,'");
				querySql.append(organCode); 
				querySql.append("' XZQH from (");
				querySql.append(cqmUseCol.getViewLogic());
				querySql.append(" ) where 1=1  and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(" and ");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(" like '");
				querySql.append(organCode.substring(0,n_yxws )+"%");
				querySql.append("' group by ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" union  select '");
				querySql.append(organCode);
				querySql.append("'||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append("CODE' P ,count(*) V,'");
				querySql.append(organCode); 
				querySql.append("' XZQH from (");
				querySql.append(cqmUseCol.getViewLogic());
				querySql.append(" ) where 1=1  and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(" and ");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(" like '");
				querySql.append(organCode.substring(0,n_yxws )+"%");
				querySql.append("'");
			}else{
				querySql.append("select ");
				querySql.append(cqmUseCol.getViewCode());
				querySql.append("||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append("'||");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" P,count(*) V from (");
				querySql.append(cqmUseCol.getViewLogic());
				if(cqmUseCol.getViewLogic().contains( "where")){
				}else{
					querySql.append(" where 1=1 ");
				}
				querySql.append(" and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(") where ");
				querySql.append(cqmUseCol.getViewCode());
				querySql.append(" in (");
				if (organCode.endsWith("0000000000")){
					querySql.append(" select id from dic_city where leve = '1' or id = '370000000000' ");
				}else if(organCode.endsWith("00000000")){
					querySql.append(" select id from dic_city where (leve = '2' and id like ?) or id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,4)+"%");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}else if(organCode.endsWith("000000")) {
					querySql.append(" select id from dic_city where (leve = '3' and id like ? and is_self ='0') or id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,6)+"%");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}else{
					querySql.append(" select id from dic_city where id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
				querySql.append(")");
				// 增加查询条件
				
				querySql.append(" group by ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(",");
				querySql.append(cqmUseCol.getViewCode());
				
				querySql.append(" union select ");
				querySql.append(cqmUseCol.getViewCode());
				querySql.append("||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append("CODE'");
				querySql.append(" P,count(*) V from (");
				querySql.append(cqmUseCol.getViewLogic());
				if(cqmUseCol.getViewLogic().contains( "where")){
				}else{
					querySql.append(" where 1=1 ");
				}
				querySql.append(" and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(") where ");
				querySql.append(cqmUseCol.getViewCode());
				querySql.append(" in (");
				if (organCode.endsWith("0000000000")){
					querySql.append(" select id from dic_city where leve = '1' or id = '370000000000' ");
				}else if(organCode.endsWith("00000000")){
					querySql.append(" select id from dic_city where (leve = '2' and id like ?) or id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,4)+"%");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}else if(organCode.endsWith("000000")) {
					querySql.append(" select id from dic_city where (leve = '3' and id like ? and is_self ='0') or id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,6)+"%");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}else{
					querySql.append(" select id from dic_city where id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
				querySql.append(")");
				// 增加查询条件
				querySql.append(" group by ");
				querySql.append(cqmUseCol.getViewCode());
			}
		}
		if ("S".equals(cqmUseCol.getColType())) {
			if(userUseView!=null&&userUseView.getPrivilegeCode()!= null&&userUseView.getIfUndering()!=null){
				if("1".equals(userUseView.getIfUndering())){
					
					querySql.append("select P,V ,XZQH from (");
					//开始
					querySql.append("select rpad(substr(");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(",1,"+n_yxws_xj );
					querySql.append("), 12, 0)||'");
					querySql.append(cqmUseCol.getColId());
					querySql.append("' P,nvl(sum(");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("),0) V , rpad(substr(");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(",1,"+n_yxws_xj );
					querySql.append("), 12, 0) XZQH from (");
					querySql.append(cqmUseCol.getViewLogic());
					querySql.append(" ) where 1=1 and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(" is not null ");
					getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
					querySql.append(" group by rpad(substr(");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(",1,"+n_yxws_xj );
					querySql.append("), 12, 0))where XZQH in (select id from dic_city where ups = '");
					querySql.append(organCode);
					querySql.append("' and is_self ='0') union select '");
					querySql.append(organCode );
					querySql.append(cqmUseCol.getColId());
					querySql.append("' P,nvl(sum(");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("),0) V,'");
					querySql.append(organCode);
					querySql.append("' XZQH from (");
					querySql.append(cqmUseCol.getViewLogic());
					querySql.append(") where 1=1 ");
					//条件
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(" is not null ");
					getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append(" like '");
					querySql.append(organCode.substring(0,n_yxws )+"%");
					querySql.append("'");
				}else{
					querySql.append("select ");
					querySql.append(cqmUseCol.getViewCode());
					querySql.append("||'");
					querySql.append(cqmUseCol.getColId());
					querySql.append("' P,nvl(sum(");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("),0) V from (");
					querySql.append(cqmUseCol.getViewLogic());
					if(cqmUseCol.getViewLogic().contains( "where")){
					}else{
						querySql.append(" where 1=1 ");
					}
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(" is not null ");
					getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
					querySql.append(" and ");
					querySql.append(userUseView.getPrivilegeCode());
					querySql.append( " in ( select id from dic_city where ups = ? and is_self !='1' or id = ? )");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
					querySql.append(" ) where ");
					querySql.append(cqmUseCol.getViewCode());
					querySql.append(" in (");
					if (organCode.endsWith("0000000000")){
						querySql.append(" select id from dic_city where leve = '1' or id = '370000000000' ");
					}else if(organCode.endsWith("00000000")){
						querySql.append(" select id from dic_city where (leve = '2' and id like ?) or id = ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
						typeList.add(Types.VARCHAR);
						argsList.add(organCode);
					}else if(organCode.endsWith("000000")) {
						querySql.append(" select id from dic_city where (leve = '3' and id like ? and is_self ='0') or id = ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,6)+"%");
						typeList.add(Types.VARCHAR);
						argsList.add(organCode);
					}else{
						querySql.append(" select id from dic_city where id = ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(organCode);
					}
					querySql.append(")");
					// 增加查询条件
					querySql.append(" group by ");
					querySql.append(cqmUseCol.getViewCode());
				}
			}
		}
		List<Map> list = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		list = executeQuery(querySql.toString(),types, args);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			ReportData reportData = new ReportData();
			reportData.setPoint((String) map.get("P"));
			reportData.setValue((BigDecimal) map.get("V"));
			ds.addRecord(reportData);
		}
		return ds;
	}

	public DataSet getReportData(String organCode, CqmUseCol cqmUseCol,CqmUseView useView,
			List sections,CqmIndex cqmIndex, List cqmUseSearchList) {
		StringBuffer querySql = new StringBuffer();
		Map section = null;
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		for(int i = 0;i<sections.size();i++){
			section = (Map) sections.get(i);
			if(i!=0){
				querySql.append(" union ");
			} 
			querySql.append(" select ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append("||'");
			querySql.append(cqmUseCol.getColId());
			querySql.append("'||'");
			querySql.append(section.get("SECTION_ID"));
			querySql.append("' P,count(*) V from ( select * from(");
			querySql.append(cqmUseCol.getViewLogic());
			querySql.append(" ) where 1=1 ");
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(useView!=null&&useView.getPrivilegeCode()!= null){
				if("1".equals(useView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(useView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(useView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}			
			if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)||("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
				if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)){
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("< ");
					querySql.append(section.get("SECTION_AFTER"));
				}
				if(("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(">= ");
					querySql.append(section.get("SECTION_BEFORE"));
				}
			}else{
				querySql.append(" and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(">= ");
				querySql.append(section.get("SECTION_BEFORE"));
				querySql.append(" and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append("< ");
				querySql.append(section.get("SECTION_AFTER"));
			}
			querySql.append(") where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (");
			if ("0".equals(cqmIndex.getIfLoadOnce())) {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (select row_.*,rownum rownum_ from ( select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from ( ");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
				}
				querySql.append(") row_ where rownum<=?) where rownum_>?)");
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getEnd());
				typeList.add(Types.INTEGER);
				argsList.add(cqmIndex.getStart());
			} else {
				querySql.append("select ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" from (");
				querySql.append(cqmIndex.getIndexLogic());
				querySql.append(")");
				if(cqmIndex.getIndexLogic().contains("dic_city")){
					querySql.append(" where 1=1 and ");
					querySql.append(cqmIndex.getIndexCode());
					querySql.append(" like ?  ");
					if (organCode.endsWith("0000000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2)+"%");
					}else if(organCode.endsWith("00000000")){
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0,4)+"%");
					}else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6)+"%");
					}
					querySql.append(")");
					
				}
			}
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getViewCode());
		}
		querySql.append(" union select ");
		querySql.append(cqmUseCol.getViewCode());
		querySql.append("||'");
		querySql.append(cqmUseCol.getColId());
		querySql.append("CODE' P,count(*) V from ( select * from(");
		querySql.append(cqmUseCol.getViewLogic());
		querySql.append(" ) where 1=1 ");
		querySql.append(" and ");
		querySql.append(cqmUseCol.getColCode());
		querySql.append(" is not null ");
		getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
		if(useView!=null&&useView.getPrivilegeCode()!= null){
			if("1".equals(useView.getIfUndering())){
				querySql.append(" and ");
				querySql.append(useView.getPrivilegeCode());
				querySql.append(" like ? ");
				if (organCode.endsWith("0000000000")) {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2) + "%");
				} else if (organCode.endsWith("00000000")) {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4) + "%");
				} else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6) + "%");
				}
			}else{
				querySql.append(" and ");
				querySql.append(useView.getPrivilegeCode());
				querySql.append(" = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
		}	
		querySql.append(") where ");
		querySql.append(cqmUseCol.getViewCode());
		querySql.append(" in (");
		if ("0".equals(cqmIndex.getIfLoadOnce())) {
			querySql.append("select ");
			querySql.append(cqmIndex.getIndexCode());
			querySql.append(" from (select row_.*,rownum rownum_ from ( select ");
			querySql.append(cqmIndex.getIndexCode());
			querySql.append(" from ( ");
			querySql.append(cqmIndex.getIndexLogic());
			querySql.append(")");
			if(cqmIndex.getIndexLogic().contains("dic_city")){
				querySql.append(" where 1=1 and ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" like ?  ");
				if (organCode.endsWith("0000000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				}else if(organCode.endsWith("00000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,4)+"%");
				}else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
			querySql.append(") row_ where rownum<=?) where rownum_>?)");
			typeList.add(Types.INTEGER);
			argsList.add(cqmIndex.getEnd());
			typeList.add(Types.INTEGER);
			argsList.add(cqmIndex.getStart());
		} else {
			querySql.append("select ");
			querySql.append(cqmIndex.getIndexCode());
			querySql.append(" from (");
			querySql.append(cqmIndex.getIndexLogic());
			querySql.append(")");
			if(cqmIndex.getIndexLogic().contains("dic_city")){
				querySql.append(" where 1=1 and ");
				querySql.append(cqmIndex.getIndexCode());
				querySql.append(" like ?  ");
				if (organCode.endsWith("0000000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				}else if(organCode.endsWith("00000000")){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0,4)+"%");
				}else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
				querySql.append(")");
			}
		}
		querySql.append(" group by ");
		querySql.append(cqmUseCol.getViewCode());
		List<Map> list = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		list = executeQuery(querySql.toString(),types, args);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			ReportData reportData = new ReportData();
			reportData.setPoint((String) map.get("P"));
			reportData.setValue((BigDecimal) map.get("V"));
			ds.addRecord(reportData);
		}
		return ds;
	}

	public DataSet getReportLayeredData(String organCode, CqmUseCol cqmUseCol,
			List sections, CqmUseView userUseView, List cqmUseSearchList) {
		StringBuffer querySql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		int n_yxws = 2;
		int n_yxws_xj = 4;
		if (organCode.endsWith("0000000000")){
			n_yxws = 2;
			n_yxws_xj = 4;
		}else if(organCode.endsWith("00000000")){
			n_yxws = 4;
			n_yxws_xj = 6;
		}else if(organCode.endsWith("000000")){
			n_yxws = 6;
			n_yxws_xj = 9;
		}else{
			n_yxws = 9;
			n_yxws_xj = 12;
		}
		Map section = null;
		if ("1".equals(userUseView.getIfUndering())) {
			querySql.append("select P,V,XZQH from (");
			for(int i = 0;i<sections.size();i++){
				if(i!=0){
					querySql.append(" union ");
				}
				section = (Map) sections.get(i);
				querySql.append(" select  rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1," + n_yxws_xj);
				querySql.append("), 12, 0) ||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append(section.get("SECTION_ID"));
				querySql.append("' P ,count(*) V,rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1," + n_yxws_xj);
				querySql.append("), 12, 0) XZQH from (");
				querySql.append(cqmUseCol.getViewLogic());
				querySql.append(" ) where 1=1  and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)||("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
					if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)){
						querySql.append(" and ");
						querySql.append(cqmUseCol.getColCode());
						querySql.append("< ");
						querySql.append(section.get("SECTION_AFTER"));
					}
					if(("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
						querySql.append(" and ");
						querySql.append(cqmUseCol.getColCode());
						querySql.append(">= ");
						querySql.append(section.get("SECTION_BEFORE"));
					}
				}else{
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(">= ");
					querySql.append(section.get("SECTION_BEFORE"));
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("< ");
					querySql.append(section.get("SECTION_AFTER"));
				}
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(" group by rpad(substr(");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(",1," + n_yxws_xj);
				querySql.append("), 12, 0)");
			}
			querySql.append(" union select rpad(substr(");
			querySql.append(userUseView.getPrivilegeCode());
			querySql.append(",1," + n_yxws_xj);
			querySql.append("), 12, 0)||'");
			querySql.append(cqmUseCol.getColId());
			querySql.append("CODE' P ,count(*) V,rpad(substr(");
			querySql.append(userUseView.getPrivilegeCode());
			querySql.append(",1," + n_yxws_xj);
			querySql.append("), 12, 0) XZQH from (");
			querySql.append(cqmUseCol.getViewLogic());
			querySql.append(" ) where 1=1  and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			querySql.append(" group by rpad(substr(");
			querySql.append(userUseView.getPrivilegeCode());
			querySql.append(",1," + n_yxws_xj);
			querySql.append("), 12, 0)");
			querySql.append(")where XZQH in (select id from dic_city where ups = '");
			querySql.append(organCode);
			querySql.append("' and is_self ='0')");
			//合计行
			querySql.append(" union select P,V,XZQH from (");
			for(int i = 0;i<sections.size();i++){
				if(i!=0){
					querySql.append(" union ");
				}
				section = (Map) sections.get(i);
				querySql.append(" select '");
				querySql.append(organCode);
				querySql.append(cqmUseCol.getColId());
				querySql.append(section.get("SECTION_ID"));
				querySql.append("' P ,count(*) V,'");
				querySql.append(organCode);
				querySql.append("' XZQH from (");
				querySql.append(cqmUseCol.getViewLogic());
				querySql.append(" ) where 1=1  and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)||("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
					if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)){
						querySql.append(" and ");
						querySql.append(cqmUseCol.getColCode());
						querySql.append("< ");
						querySql.append(section.get("SECTION_AFTER"));
					}
					if(("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
						querySql.append(" and ");
						querySql.append(cqmUseCol.getColCode());
						querySql.append(">= ");
						querySql.append(section.get("SECTION_BEFORE"));
					}
				}else{
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(">= ");
					querySql.append(section.get("SECTION_BEFORE"));
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("< ");
					querySql.append(section.get("SECTION_AFTER"));
				}
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(" and ");
				querySql.append(userUseView.getPrivilegeCode());
				querySql.append(" like '");
				querySql.append(organCode.subSequence(0, n_yxws)+"%'");
			}
			querySql.append(" union select '");
			querySql.append(organCode);
			querySql.append(cqmUseCol.getColId());
			querySql.append("CODE' P ,count(*) V,'");
			querySql.append(organCode);
			querySql.append("' XZQH from (");
			querySql.append(cqmUseCol.getViewLogic());
			querySql.append(" ) where 1=1  and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			querySql.append(" and ");
			querySql.append(userUseView.getPrivilegeCode());
			querySql.append(" like '");
			querySql.append(organCode.subSequence(0, n_yxws)+"%' )");
			
		}else{
			for(int i = 0;i<sections.size();i++){
				if(i!=0){
					querySql.append(" union ");
				}
				section = (Map) sections.get(i);
				querySql.append("select ");
				querySql.append(cqmUseCol.getViewCode());
				querySql.append("||'");
				querySql.append(cqmUseCol.getColId());
				querySql.append(section.get("SECTION_ID"));
				querySql.append("' P,count(*) V from (");
				querySql.append(cqmUseCol.getViewLogic());
				if (cqmUseCol.getViewLogic().contains("where")) {
				} else {
					querySql.append(" where 1=1 ");
				}
				querySql.append(" and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(" is not null ");
				if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)||("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
					if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)){
						querySql.append(" and ");
						querySql.append(cqmUseCol.getColCode());
						querySql.append("< ");
						querySql.append(section.get("SECTION_AFTER"));
					}
					if(("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
						querySql.append(" and ");
						querySql.append(cqmUseCol.getColCode());
						querySql.append(">= ");
						querySql.append(section.get("SECTION_BEFORE"));
					}
				}else{
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(">= ");
					querySql.append(section.get("SECTION_BEFORE"));
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("< ");
					querySql.append(section.get("SECTION_AFTER"));
				}
				getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
				querySql.append(") where ");
				querySql.append(cqmUseCol.getViewCode());
				querySql.append(" in (");
				if (organCode.endsWith("0000000000")) {
					querySql
							.append(" select id from dic_city where leve = '1' or id = '370000000000' ");
				} else if (organCode.endsWith("00000000")) {
					querySql
							.append(" select id from dic_city where (leve = '2' and id like ?) or id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4) + "%");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				} else if (organCode.endsWith("000000")) {
					querySql.append(" select id from dic_city where (leve = '3' and id like ? and is_self ='0') or id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6) + "%");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				} else {
					querySql.append(" select id from dic_city where id = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
				querySql.append(")");
			}
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getViewCode());

			querySql.append(" union select ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append("||'");
			querySql.append(cqmUseCol.getColId());
			querySql.append("CODE'");
			querySql.append(" P,count(*) V from (");
			querySql.append(cqmUseCol.getViewLogic());
			if (cqmUseCol.getViewLogic().contains("where")) {
			} else {
				querySql.append(" where 1=1 ");
			}
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			querySql.append(") where ");
			querySql.append(cqmUseCol.getViewCode());
			querySql.append(" in (");
			if (organCode.endsWith("0000000000")) {
				querySql
						.append(" select id from dic_city where leve = '1' or id = '370000000000' ");
			} else if (organCode.endsWith("00000000")) {
				querySql
						.append(" select id from dic_city where (leve = '2' and id like ?) or id = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4) + "%");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			} else if (organCode.endsWith("000000")) {
				querySql
						.append(" select id from dic_city where (leve = '3' and id like ? and is_self ='0') or id = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6) + "%");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			} else {
				querySql.append(" select id from dic_city where id = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
			querySql.append(")");
			// 增加查询条件
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getViewCode());
		}
		List<Map> list = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		list = executeQuery(querySql.toString(),types, args);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			ReportData reportData = new ReportData();
			reportData.setPoint((String) map.get("P"));
			reportData.setValue((BigDecimal) map.get("V"));
			ds.addRecord(reportData);
		}
		return ds;
	}

	public DataSet getReportSum(String organCode, CqmUseCol cqmUseCol,
			CqmUseView useView, List sections, CqmIndex cqmIndex,
			List cqmUseSearchList) {
		StringBuffer querySql = new StringBuffer();
		Map section = null;
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		for(int i = 0;i<sections.size();i++){
			section = (Map) sections.get(i);
			if(i!=0){
				querySql.append(" union ");
			} 
			querySql.append(" select '");
			querySql.append(cqmUseCol.getColId());
			querySql.append(section.get("SECTION_ID"));
			querySql.append("' P,count(*) V from ( select * from(");
			querySql.append(cqmUseCol.getViewLogic());
			querySql.append(" ) where 1=1 ");
			querySql.append(" and ");
			querySql.append(cqmUseCol.getColCode());
			querySql.append(" is not null ");
			getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
			if(useView!=null&&useView.getPrivilegeCode()!= null){
				if("1".equals(useView.getIfUndering())){
					querySql.append(" and ");
					querySql.append(useView.getPrivilegeCode());
					querySql.append(" like ? ");
					if (organCode.endsWith("0000000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 2) + "%");
					} else if (organCode.endsWith("00000000")) {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 4) + "%");
					} else {
						typeList.add(Types.VARCHAR);
						argsList.add(organCode.substring(0, 6) + "%");
					}
				}else{
					querySql.append(" and ");
					querySql.append(useView.getPrivilegeCode());
					querySql.append(" = ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(organCode);
				}
			}	
			if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)||("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
				if(("".equals(section.get("SECTION_BEFORE"))||section.get("SECTION_BEFORE")==null)){
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append("< ");
					querySql.append(section.get("SECTION_AFTER"));
				}
				if(("".equals(section.get("SECTION_AFTER"))||section.get("SECTION_AFTER")==null)){
					querySql.append(" and ");
					querySql.append(cqmUseCol.getColCode());
					querySql.append(">= ");
					querySql.append(section.get("SECTION_BEFORE"));
				}
			}else{
				querySql.append(" and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append(">= ");
				querySql.append(section.get("SECTION_BEFORE"));
				querySql.append(" and ");
				querySql.append(cqmUseCol.getColCode());
				querySql.append("< ");
				querySql.append(section.get("SECTION_AFTER"));
			}
			querySql.append(") ");
			querySql.append(" group by ");
			querySql.append(cqmUseCol.getViewCode());
		}
		querySql.append(" union select '");
		querySql.append(cqmUseCol.getColId());
		querySql.append("CODE' P,count(*) V from ( select * from(");
		querySql.append(cqmUseCol.getViewLogic());
		querySql.append(" ) where 1=1 ");
		querySql.append(" and ");
		querySql.append(cqmUseCol.getColCode());
		querySql.append(" is not null ");
		getSearchSql(querySql, cqmUseSearchList, cqmUseCol);
		if(useView!=null&&useView.getPrivilegeCode()!= null){
			querySql.append(" and ");
			querySql.append(useView.getPrivilegeCode());
			querySql.append(" like ? ");
			if (organCode.endsWith("0000000000")) {
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2) + "%");
			} else if (organCode.endsWith("00000000")) {
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4) + "%");
			} else {
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6) + "%");
			}
		}
		querySql.append(")");
		querySql.append(" group by ");
		querySql.append(cqmUseCol.getViewCode());
		List<Map> list = null;
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		list = executeQuery(querySql.toString(),types, args);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			ReportData reportData = new ReportData();
			reportData.setPoint((String) map.get("P"));
			reportData.setValue((BigDecimal) map.get("V"));
			ds.addRecord(reportData);
		}
		return ds;
	}

}