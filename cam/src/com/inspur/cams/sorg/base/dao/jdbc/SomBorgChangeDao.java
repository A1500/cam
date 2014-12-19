package com.inspur.cams.sorg.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.dao.ISomBorgChangeDao;
import com.inspur.cams.sorg.base.data.SomBorgChange;

/**
 * @title:业务主管单位变更dao
 * @description:
 * @author:
 * @since:2013-03-05
 * @version:1.0
 */
public class SomBorgChangeDao extends EntityDao<SomBorgChange> implements
		ISomBorgChangeDao {

	@Override
	public Class<SomBorgChange> getEntityClass() {
		return SomBorgChange.class;
	}

	/**
	 * 查询数量
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int queryCount(ParameterSet pset) {
		String borgCode = (String) pset.get("borgCode");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();

		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		argsList.add(borgCode);
		argsList.add(borgCode);

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(1) CNT ");
		sql.append("  FROM SOM_BUSINESS_ORGAN_CHANGE T ");
		sql.append(" WHERE T.CHANGE_BEFORE_ID = ? ");
		sql.append("    OR T.CHANGE_AFTER_ID = ? ");
		List list = new ArrayList();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			list = executeQuery(sql.toString(), types, args);
		} else {
			list = executeQuery(sql.toString());
		}
		Map data = (Map) list.get(0);
		BigDecimal cc = (BigDecimal) data.get("CNT");
		return cc.intValue();
	}
	
	/**
	 * 业务主管单位变更历史
	 */
	public DataSet showChange(ParameterSet pset){
		DataSet resultDs = new DataSet();		
		String borgCode = (String) pset.get("borgCode");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		argsList.add(borgCode);
		argsList.add(borgCode);
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * ");
		sql.append("  FROM (SELECT T.* ");
		sql.append("          FROM (SELECT B.BORG_CODE, ");
		sql.append("                       C.CHANGE_BEFORE_ID, ");
		sql.append("                       C.CHANGE_BEFORE_NAME, ");
		sql.append("                       C.CHANGE_AFTER_ID, ");
		sql.append("                       C.CHANGE_AFTER_NAME, ");
		sql.append("                       C.CHANGE_TIME, ");
		sql.append("                       C.CHANGE_PERSON ");
		sql.append("                  FROM SOM_BUSINESS_ORGAN B, SOM_BUSINESS_ORGAN_CHANGE C ");
		sql.append("                 WHERE B.BORG_CODE = C.CHANGE_BEFORE_ID) T ");
		sql.append("         START WITH T.BORG_CODE LIKE ? ");
		sql.append("        CONNECT BY PRIOR CHANGE_AFTER_ID = T.BORG_CODE ");
		sql.append("        UNION ");
		sql.append("        SELECT T.* ");
		sql.append("          FROM (SELECT B.BORG_CODE, ");
		sql.append("                       C.CHANGE_BEFORE_ID, ");
		sql.append("                       C.CHANGE_BEFORE_NAME, ");
		sql.append("                       C.CHANGE_AFTER_ID, ");
		sql.append("                       C.CHANGE_AFTER_NAME, ");
		sql.append("                       C.CHANGE_TIME, ");
		sql.append("                       C.CHANGE_PERSON ");
		sql.append("                  FROM SOM_BUSINESS_ORGAN B, SOM_BUSINESS_ORGAN_CHANGE C ");
		sql.append("                 WHERE B.BORG_CODE = C.CHANGE_AFTER_ID) T ");
		sql.append("         START WITH T.BORG_CODE LIKE ? ");
		sql.append("        CONNECT BY PRIOR CHANGE_BEFORE_ID = T.BORG_CODE) T ");
		sql.append(" ORDER BY T.CHANGE_TIME ");
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			resultDs = this.executeDataset(sql.toString(), pset.getPageStart(),
					pset.getPageLimit(), true);
		}
		return resultDs;
	}
	
	/**
	 * 当前业务主管单位名称
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String nowBorgName(ParameterSet pset) {
		String borgCode = (String) pset.get("borgCode");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();

		typeList.add(Types.VARCHAR);
		argsList.add(borgCode);

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.* ");
		sql.append("  FROM (SELECT T.BORG_NAME ");
		sql.append("          FROM (SELECT B.BORG_CODE, ");
		sql.append("                       B.BORG_NAME, ");
		sql.append("                       C.CHANGE_BEFORE_ID, ");
		sql.append("                       C.CHANGE_AFTER_ID, ");
		sql.append("                       C.CHANGE_TIME ");
		sql.append("                  FROM SOM_BUSINESS_ORGAN B, SOM_BUSINESS_ORGAN_CHANGE C ");
		sql.append("                 WHERE B.BORG_CODE = C.CHANGE_BEFORE_ID(+)) T ");
		sql.append("         START WITH T.BORG_CODE = ? ");
		sql.append("        CONNECT BY PRIOR CHANGE_AFTER_ID = T.BORG_CODE ");
		sql.append("         ORDER BY T.CHANGE_TIME DESC) T ");
		sql.append(" WHERE ROWNUM = 1 ");

		List list = new ArrayList();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			list = executeQuery(sql.toString(), types, args);
		} else {
			list = executeQuery(sql.toString());
		}
		if(list.size()>0){
			Map data = (Map) list.get(0);
			return (String) data.get("BORG_NAME");
		}else{
			return "";
		}
	}
}
