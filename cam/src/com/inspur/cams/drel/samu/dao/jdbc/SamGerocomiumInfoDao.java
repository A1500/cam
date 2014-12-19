package com.inspur.cams.drel.samu.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.samu.dao.ISamGerocomiumInfoDao;
import com.inspur.cams.drel.samu.data.SamGerocomiumInfo;
import com.inspur.comm.util.BspUtil;

/**
 * 敬老院基础信息dao
 * 
 * @author
 * @date 2012-09-26
 */
public class SamGerocomiumInfoDao extends EntityDao<SamGerocomiumInfo> implements ISamGerocomiumInfoDao {

	@Override
	public Class<SamGerocomiumInfo> getEntityClass() {
		return SamGerocomiumInfo.class;
	}

	public void deleteAll(String gerocomiumId) {
		StringBuffer sqlBed = new StringBuffer();
		StringBuffer sqlRoom = new StringBuffer();
		StringBuffer sqlWorker = new StringBuffer();
		StringBuffer sqlGerocomium = new StringBuffer();
		// 删除床位信息
		sqlBed.append("delete from SAM_BED_INFO WHERE ROOM_ID IN(");
		sqlBed.append("SELECT ROOM_ID FROM SAM_ROOM_INFO WHERE gerocomium_id='");
		sqlBed.append(gerocomiumId + "')");
		// 删除房间信息
		sqlRoom.append("delete from SAM_ROOM_INFO WHERE gerocomium_id='");
		sqlRoom.append(gerocomiumId + "'");
		// 删除员工信息
		sqlWorker.append("delete from SAM_WORKER_INFO WHERE gerocomium_id='");
		sqlWorker.append(gerocomiumId + "'");
		// 删除敬老院信息
		sqlGerocomium.append("delete from SAM_GEROCOMIUM_INFO WHERE gerocomium_id='");
		sqlGerocomium.append(gerocomiumId + "'");
		executeUpdate(sqlBed.toString());
		executeUpdate(sqlRoom.toString());
		executeUpdate(sqlWorker.toString());
		executeUpdate(sqlGerocomium.toString());
	}

	public void updateOldYear(String recordId) {
		StringBuffer sql = new StringBuffer();
		String ifCurrent = "0";
		sql.append("update SAM_GEROCOMIUM_INFO set if_current='");
		sql.append(ifCurrent + "'");
		sql.append(" where record_id='");
		sql.append(recordId + "'");
		executeUpdate(sql.toString());
	}

	public DataSet queryGero(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		String areaLevelId = (String) pset.getParameter("areaLevelId");
		sql.append(" select * ");
		sql.append(" from SAM_GEROCOMIUM_INFO  ");
		sql.append(" where 1=1 and if_current='1' ");
		if (StringUtils.isNotEmpty(areaLevelId)) {
			String organCode = BspUtil.getOrganCode();
			if(organCode.endsWith("000") && !organCode.endsWith("000000")){
				sql.append(" AND substr(AREA_LEVEL_ID,1,9) LIKE ? ");
			}else{
				sql.append(" AND substr(AREA_LEVEL_ID,1,6) LIKE ? ");
			}
			typeList.add(Types.VARCHAR);
			argsList.add(areaLevelId);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args, true);
		return ds;
	}

	/*
	 * 统计五保入院人数 taoran
	 */
	public DataSet count2(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String queryYear = (String) pset.getParameter("queryYear");
		String areaLevelId = (String) pset.getParameter("areaLevelId");
		sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		sql.append("select ");
		int index = 12;
		if (StringUtils.isNotEmpty(areaLevelId)) {
			// if (areaLevelId.indexOf("000") < 9 && areaLevelId.indexOf("000")
			// > 0) {
			// index = areaLevelId.indexOf("000") + 3;
			// }
			if (areaLevelId.endsWith("0000000000")) {// 省370000000000
				index = 4;
			} else if (areaLevelId.endsWith("00000000")) {// 市370100000000
				index = 6;
			} else if (areaLevelId.endsWith("000000")) {// 县370104000000
				index = 9;
			}
		}
		sql.append(" rpad(substr(s.AREA_LEVEL_ID,0," + index + "),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,0," + index + "),12,'0') ) AREA_LEVEL_NAME,");

		sql.append("  count(*) AS IN_NUM_SUM");
		sql.append(" FROM SAM_GEROCOMIUM_INFO s,SAM_GERO_KEPT_PERSON p");
		sql.append(" WHERE s.GEROCOMIUM_ID = p.GEROCOMIUM_ID  AND s.YEAR=? AND p.IS_STATUS = '1'");
		typeList.add(Types.VARCHAR);
		argsList.add(queryYear);
		sql.append("group by rpad(substr(s.AREA_LEVEL_ID,0,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(s.AREA_LEVEL_ID,0," + index + "),12,'0') )");
		sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
		sql.append("  where d.id = rpad(substr(d.id, 0, " + index + "), 12, 0) ");
		if (StringUtils.isNotEmpty(areaLevelId)) {
			if (areaLevelId.endsWith("000")) {
				sql.append(" and d.ups=?  ");
			} else {
				sql.append(" and d.id=?  ");
			}
			typeList.add(Types.VARCHAR);
			argsList.add(areaLevelId);
		}
		sql.append(" order by d.id ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}

		return ds;

	}

	/*
	 * 统计五保未入院人数 taoran
	 */
	public DataSet count1(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String queryYear = (String) pset.getParameter("queryYear");
		String areaLevelId = (String) pset.getParameter("areaLevelId");
		sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		sql.append("select ");
		int index = 12;
		if (StringUtils.isNotEmpty(areaLevelId)) {
			// if (areaLevelId.indexOf("000") < 9 && areaLevelId.indexOf("000")
			// > 0) {
			// index = areaLevelId.indexOf("000") + 3;
			// }
			if (areaLevelId.endsWith("0000000000")) {// 省370000000000
				index = 4;
			} else if (areaLevelId.endsWith("00000000")) {// 市370100000000
				index = 6;
			} else if (areaLevelId.endsWith("000000")) {// 县370104000000
				index = 9;
			}
		}
		sql.append(" rpad(substr(F.DOMICILE_CODE,0," + index + "),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(F.DOMICILE_CODE,0," + index + "),12,'0') ) AREA_LEVEL_NAME,");
		sql.append("  count(*) AS UN_NUM_SUM ");
		sql.append(" FROM BASEINFO_PEOPLE_ARCHIVE P,SAM_PEOPLE_DISABILITY_ARCHIVE D,SAM_PEOPLE_EXTEND_ARCHIVE X,SAM_FAMILY_TREATMENT F");
		sql.append(" WHERE P.PEOPLE_ARCHIVE_ID = D.PEOPLE_ARCHIVE_ID AND P.PEOPLE_ARCHIVE_ID = X.PEOPLE_ARCHIVE_ID AND F.APPLY_ID = P.APPLY_ID ");
		// sql.append("AND F.DOMICILE_CODE=?");
		// typeList.add(Types.VARCHAR);
		// argsList.add(areaLevelId);
		sql.append("AND F.END_DATE >=?");
		typeList.add(Types.VARCHAR);
		argsList.add(queryYear);
		sql.append("group by rpad(substr(F.DOMICILE_CODE,0,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(F.DOMICILE_CODE,0," + index + "),12,'0') )");
		sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
		sql.append("  where d.id = rpad(substr(d.id, 0, " + index + "), 12, 0) ");
		if (StringUtils.isNotEmpty(areaLevelId)) {
			if (areaLevelId.endsWith("000")) {
				sql.append(" and d.ups=?  ");
			} else {
				sql.append(" and d.id=?  ");
			}
			typeList.add(Types.VARCHAR);
			argsList.add(areaLevelId);
		}
		sql.append(" order by d.id ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}

		return ds;

	}

	/**
	 * @Title: reportGeroInfo
	 * @Description: TODO(敬老院基本情况统计查询方法)
	 * @param pset
	 * @return DataSet
	 * @throws
	 * @author sunlei
	 */
	public DataSet reportGeroInfo(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String queryYear = (String) pset.getParameter("queryYear");
		String areaLevelId = (String) pset.getParameter("areaLevelId");
		sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		sql.append("select ");
		int index = 12;
		if (StringUtils.isNotEmpty(areaLevelId)) {
			if (areaLevelId.endsWith("0000000000")) {// 省370000000000
				index = 4;
			} else if (areaLevelId.endsWith("00000000")) {// 市370100000000
				index = 6;
			} else if (areaLevelId.endsWith("000000")) {// 县370104000000
				index = 9;
			}
		}
		sql.append(" rpad(substr(AREA_LEVEL_ID,0," + index + "),12,'0') AREA_LEVEL_CODE ,GET_CITYNAME(rpad(substr(AREA_LEVEL_ID,0," + index + "),12,'0') ) AREA_LEVEL_NAME,");
		sql.append("  count(S.GEROCOMIUM_ID) AS NUM_SUM, ");
		sql.append("  sum(case when s.GEROCOMIUM_LEVEL = '0' then 1 else 0 end) AS LEVEL_ONE , ");
		sql.append("  sum(case when s.GEROCOMIUM_LEVEL = '1' then 1 else 0 end) AS LEVEL_TWO , ");
		sql.append("  sum(case when s.GEROCOMIUM_LEVEL = '2' then 1 else 0 end) AS LEVEL_THREE , ");
		sql.append("  sum(case when s.GEROCOMIUM_LEVEL = '3' then 1 else 0 end) AS LEVEL_FOUR , ");
		sql.append("  sum( nvl(s.TOTAL_AREA, 0) )                               AS TOTAL_AREA_SUM, ");
		sql.append("  sum( nvl(s.BUILD_AREA, 0) )                               AS BUILD_AREA_SUM, ");
		sql.append("  sum( nvl(s.OUTDOOR_AREA, 0) )                             AS OUTDOOR_AREA_SUM, ");
		sql.append("  sum( nvl(s.INDOOR_AREA, 0) )                              AS INDOOR_AREA_SUM, ");
		sql.append("  sum(case when s.HEATING_WAY = '0' then 1 else 0 end)      AS HEATING_JZ , ");
		sql.append("  sum(case when s.HEATING_WAY = '1' then 1 else 0 end)      AS HEATING_RM , ");
		sql.append("  sum(case when s.HEATING_WAY = '2' then 1 else 0 end)      AS HEATING_RQ , ");
		sql.append("  sum(case when s.HEATING_WAY = '3' then 1 else 0 end)      AS HEATING_KT , ");
		sql.append("  sum( nvl(s.TOTAL_BED_NUM, 0) )                            AS BED_SUM, ");
		sql.append("  sum( nvl(s.TOTAL_BED_NUM, 0) )                            AS BED_SUM_INUSE, ");
		sql.append("  sum( nvl(s.FIXED_ASSETS, 0) )                             AS FIXED_ASSETS_SUM, ");
		sql.append("  sum( nvl(s.MANAGEMENT_FUNDS, 0) )                         AS MANAGEMENT_FUNDS_SUM, ");
		sql.append("  sum( nvl(s.YEAR_SIDELINE_INCOME, 0) )                     AS YEAR_SIDELINE_SUM, ");
		sql.append("  sum( nvl(s.SUPPORT_STANDARD, 0) )                         AS SUPPORT_STANDARD_SUM, ");
		sql.append("  sum( nvl(s.VEGETABLES_AREA, 0) )                          AS VEGETABLES_AREA_SUM, ");
		sql.append("  sum( nvl(s.VEGETABLES_YIELD, 0) )                         AS VEGETABLES_YIELD_SUM ");
		sql.append("  from SAM_GEROCOMIUM_INFO s");
		sql.append(" WHERE 1=1");

		sql.append("  AND s.YEAR=? ");
		typeList.add(Types.VARCHAR);
		argsList.add(queryYear);

		sql.append("group by rpad(substr(AREA_LEVEL_ID,0,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(AREA_LEVEL_ID,0," + index + "),12,'0') )");
		sql.append("  ) al on  al.AREA_LEVEL_CODE=d.id ");
		sql.append("  where d.id = rpad(substr(d.id, 0, " + index + "), 12, 0) ");
		if (StringUtils.isNotEmpty(areaLevelId)) {
			if (areaLevelId.endsWith("000")) {
				sql.append(" and d.ups=?  ");
			} else {
				sql.append(" and d.id=?  ");
			}
			typeList.add(Types.VARCHAR);
			argsList.add(areaLevelId);
		}
		sql.append(" order by d.id ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}

		return ds;
	}

	private String getAreaCodeLikePrefix(String areaCode) {
		if (areaCode.endsWith("0000000000")) {// 省370000000000
			return areaCode.substring(0, 2);
		} else if (areaCode.endsWith("00000000")) {// 市370100000000
			return areaCode.substring(0, 4);
		} else if (areaCode.endsWith("000000")) {// 县370104000000
			return areaCode.substring(0, 6);
		} else if (areaCode.endsWith("000")) {// 乡370104003000
			return areaCode.substring(0, 9);
		}
		return areaCode;
	}
}