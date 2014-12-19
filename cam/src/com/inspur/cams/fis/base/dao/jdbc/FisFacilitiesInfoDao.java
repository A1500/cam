package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.fis.base.dao.IFisFacilitiesInfoDao;
import com.inspur.cams.fis.base.data.FisFacilitiesInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisFacilitiesInfoDao
 * @Description: TODO 殡葬业务设施表dao实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisFacilitiesInfoDao extends EntityDao<FisFacilitiesInfo> implements IFisFacilitiesInfoDao {

	public FisFacilitiesInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisFacilitiesInfo.class;
	}

	/**
	 * @Title: queryForsFacilitiesInfo
	 * @Description: TODO(告别厅信息查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author wangziming
	 * @date 2011-12-15
	 */
	public DataSet queryForsFacilitiesInfo(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		DataSet ds = new DataSet();

		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();

		String FareWellCode = (String) pset.getParameter("FareWellCode");
		String FareWellName = (String) pset.getParameter("FareWellName");
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		String inUse = (String) pset.getParameter("inUse");

		sql.append("SELECT F.*,R.IN_USE,R.RESOURCE_ID FROM FIS_FACILITIES_INFO F ");
		sql.append(" LEFT JOIN FIS_RESOURCE_INFO R ON F.FACILITIES_ID = R.FAE_ID ");
		sql.append(" WHERE F.RESOURCE_TYPE = '05' ");
		if (StringUtils.isNotEmpty(FareWellCode)) {
			sql.append(" AND F.FACILITIES_CODE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(FareWellCode);
		}
		if (StringUtils.isNotEmpty(FareWellName)) {
			sql.append(" AND F.FACILITIES_NAME = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(FareWellName);
		}
		if (StringUtils.isNotEmpty(startDate)) {
			sql.append(" AND F.USE_DATE >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(startDate);
		}
		if (StringUtils.isNotEmpty(endDate)) {
			sql.append(" AND F.USE_DATE <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(endDate);
		}
		if (StringUtils.isNotEmpty(inUse)) {
			sql.append(" AND R.IN_USE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(inUse);
		}
		sql.append(" ORDER BY F.USE_DATE DESC ");

		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(), getDsStart(pset), getDsLimit(pset), true);
		}
		return ds;
	}

	/**
	 * 
	 * @Title: queryForFacilitiesService
	 * @Description: TODO(告别厅使用记录查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author wangziming
	 * @date 2011-12-15
	 */
	public DataSet queryForFacilitiesService(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> ObjectList = new ArrayList<String>();

		String resourceId = (String) pset.getParameter("resourceId");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String hostName = (String) pset.getParameter("hostName");

		DataSet ds = new DataSet();

		StringBuffer sql = new StringBuffer();

		sql
				.append(" SELECT S.APPLY_ID,S.START_TIME,S.END_TIME,S.USE_RESOURCE_ID AS RESOUCE_ID,R.RESOURCE_NAME AS RESOURCE_NAME,S.HOST_PEOPLE AS PEOPLE_ID,I.NAME AS PEOPLE_NAME, A.DEAD_ID,A.CUSTOM_ID,D.NAME AS DEAD_NAME,D.SEX AS DEAD_SEX,D.AGE AS DEAD_AGE,P.NAME AS CUSTOM_NAME,P.MOBIL_PHONE AS CUSTOM_PHONE ");
		sql.append(" FROM FIS_SERVICE_FAREWELL S ");
		sql.append(" LEFT JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID ");
		sql.append(" LEFT JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID ");
		sql.append(" JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID ");
		sql.append(" LEFT JOIN FIS_PEOPLE_INFO I ON S.HOST_PEOPLE = I.PEOPLE_ID ");
		sql.append(" LEFT JOIN FIS_RESOURCE_INFO R ON S.USE_RESOURCE_ID = R.RESOURCE_ID ");
		sql.append(" WHERE S.STATUS != '3' ");
		sql.append("   AND S.STATUS != '0' ");
		if (StringUtils.isNotEmpty(hostName)) {
			sql.append("   AND R.RESOURCE_NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(hostName);
		}
		if (StringUtils.isNotEmpty(resourceId)) {
			sql.append("   AND S.USE_RESOURCE_ID = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(resourceId);
		}
		if (StringUtils.isNotEmpty(startTime)) {
			sql.append(" AND ((S.START_TIME >= ? AND S.END_TIME IS NULL)");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
		}
		if (StringUtils.isNotEmpty(startTime) && StringUtils.isNotEmpty(endTime)) {
			sql.append(" OR (S.START_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" AND S.END_TIME < ?)) ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}

		sql.append(" ORDER BY S.START_TIME DESC,S.USE_RESOURCE_ID,  S.APPLY_ID ");

		if (typeList.size() != 0 && ObjectList.size() != 0) {
			int[] Types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				Types[i] = typeList.get(i);
			}
			Object[] args = ObjectList.toArray(new Object[ObjectList.size()]);
			ds = this.executeDataset(sql.toString(), Types, args, getDsStart(pset), getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(), getDsStart(pset), getDsLimit(pset), true);
		}
		return ds;
	}

	// excel分页信息
	private int getDsStart(ParameterSet pset) {
		String excelType = (String) pset.getParameter("excelType");
		if (null == excelType || "0,1".indexOf(excelType) == -1) {
			return pset.getPageStart();
		}
		int start = 0;
		if ("0".equals(excelType)) { // 导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if (startExcel != null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}

	private int getDsLimit(ParameterSet pset) {
		String excelType = (String) pset.getParameter("excelType");
		if (null == excelType || "0,1".indexOf(excelType) == -1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit > 1000 ? 1000 : limit;
	}

	public DataSet queryForExport(ParameterSet pSet) {
		String qStartTime = (String) pSet.get("qStartTime");
		String qEndTime = (String) pSet.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_FACILITIES_INFO O ");
		if (StringUtils.isNotEmpty(qStartTime)) {
			sqlBuffer.append(" where O.CREATE_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qStartTime);
		}
		if (StringUtils.isNotEmpty(qEndTime)) {
			sqlBuffer.append(" and O.CREATE_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qEndTime);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sqlBuffer.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sqlBuffer.toString(), true);
		}
		return ds;
	}
}
