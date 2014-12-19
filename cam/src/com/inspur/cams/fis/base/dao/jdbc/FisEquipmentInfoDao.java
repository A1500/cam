package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.fis.base.dao.IFisEquipmentInfoDao;
import com.inspur.cams.fis.base.data.FisEquipmentInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisEquipmentInfoDao
 * @Description: TODO 殡葬业务设备表dao实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisEquipmentInfoDao extends EntityDao<FisEquipmentInfo> implements IFisEquipmentInfoDao {

	public FisEquipmentInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisEquipmentInfo.class;
	}

	// 查询统计模块中，殡仪车辆、火化设备、冷藏柜等List页面信息查询公用方法
	public DataSet queryForEquipmentCount(ParameterSet pset) {
		// 设备编号
		String carCode = (String) pset.getParameter("equipmentCode");
		// 设备名称
		String carName = (String) pset.getParameter("equipmentName");
		// 设备厂商
		String manufacturers = (String) pset.getParameter("manufacturers");
		// 规格型号
		String format = (String) pset.getParameter("format");
		// 起始日期
		String startDate = (String) pset.getParameter("startDate");
		// 终止日期
		String endDate = (String) pset.getParameter("endDate");
		// 是否使用
		String inUse = (String) pset.getParameter("inUse");
		// 资源分类编号
		String resourceType = (String) pset.getParameter("resourceType");
		// 父资源内码
		String parentResource = (String) pset.getParameter("parentResource");

		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		sql.append("SELECT I.EQUIPMENT_CODE,I.EQUIPMENT_NAME,I.MANUFACTURER,I.EQUIPMENT_FORMAT, ");
		sql.append(" I.PURCHASE_DATE,I.PHONE,I.FILE_CODE,I.PURCHASE_MONEY,I.EQUIPMENT_ID  ");
		if (StringUtils.isNotEmpty(parentResource) && "01,02,03,04,05,06,07,08,09,10,11,12".indexOf(parentResource) > -1) {
			sql.append("FROM FIS_EQUIPMENT_INFO I ");
			sql.append(" WHERE 1=1 ");
		} else {
			sql.append(",R.IN_USE,R.RESOURCE_ID ");
			sql.append("FROM FIS_EQUIPMENT_INFO I,FIS_RESOURCE_INFO R ");
			sql.append(" WHERE I.EQUIPMENT_ID=R.FAE_ID");
			if (StringUtils.isNotEmpty(parentResource)) {
				sql.append(" AND R.PARENT_RESOURCE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(parentResource);
			}
			if (StringUtils.isNotEmpty(inUse)) {
				sql.append(" AND R.IN_USE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(inUse);
			}
		}
		// 如果分类编号不为空
		if (StringUtils.isNotEmpty(resourceType)) {
			sql.append(" AND I.RESOURCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(resourceType);
		}

		if (StringUtils.isNotEmpty(carCode)) {
			sql.append(" AND I.EQUIPMENT_CODE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(carCode);
		}
		if (StringUtils.isNotEmpty(carName)) {
			sql.append(" AND I.EQUIPMENT_NAME=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(carName);
		}
		if (StringUtils.isNotEmpty(manufacturers)) {
			sql.append(" AND I.MANUFACTURER=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(manufacturers);
		}
		if (StringUtils.isNotEmpty(format)) {
			sql.append(" AND I.EQUIPMENT_FORMAT=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(format);
		}
		if (StringUtils.isNotEmpty(startDate) && StringUtils.isNotEmpty(endDate)) {
			sql.append(" AND I.PURCHASE_DATE>=? AND I.PURCHASE_DATE<? ");
			typeList.add(Types.VARCHAR);
			objsList.add(startDate);
			typeList.add(Types.VARCHAR);
			objsList.add(endDate);
		}

		sql.append("  ORDER BY I.PURCHASE_DATE DESC");
		DataSet ds = new DataSet();
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
	 * @Title: queryForRefrigerated
	 * @Description: TODO(冷藏柜信息查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author wangziming
	 * @date 2011-12-14
	 */
	public DataSet queryForRefrigerated(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		DataSet ds = new DataSet();

		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();

		String RefCode = (String) pset.getParameter("RefCode");
		String RefName = (String) pset.getParameter("RefName");
		String manufacturers = (String) pset.getParameter("manufacturers");
		String format = (String) pset.getParameter("format");
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		String inUse = (String) pset.getParameter("inUse");

		sql.append(" SELECT R.RESOURCE_ID, ");
		sql.append("  E.EQUIPMENT_CODE, ");
		sql.append("  E.EQUIPMENT_ID, ");
		sql.append("  E.EQUIPMENT_NAME, ");
		sql.append("  E.MANUFACTURER, ");
		sql.append("  E.EQUIPMENT_FORMAT, ");
		sql.append("  E.PURCHASE_DATE, ");
		sql.append("  E.PHONE, ");
		sql.append("  E.FILE_CODE, ");
		sql.append("  E.PURCHASE_MONEY, ");
		sql.append("  R.IN_USE ");
		sql.append(" FROM FIS_EQUIPMENT_INFO E  ");
		sql.append("  LEFT JOIN FIS_RESOURCE_INFO R ON E.EQUIPMENT_ID = R.FAE_ID  ");
		sql.append("  WHERE E.RESOURCE_TYPE = '02'  ");
		if (StringUtils.isNotEmpty(RefCode)) {
			sql.append(" AND E.EQUIPMENT_CODE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(RefCode);
		}
		if (StringUtils.isNotEmpty(RefName)) {
			sql.append(" AND E.EQUIPMENT_NAME = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(RefName);
		}
		if (StringUtils.isNotEmpty(manufacturers)) {
			sql.append(" AND E.MANUFACTURER = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(manufacturers);
		}
		if (StringUtils.isNotEmpty(format)) {
			sql.append(" AND E.EQUIPMENT_FORMAT = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(format);
		}
		if (StringUtils.isNotEmpty(startDate)) {
			sql.append(" AND E.PURCHASE_DATE >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(startDate);
		}
		if (StringUtils.isNotEmpty(endDate)) {
			sql.append(" AND E.PURCHASE_DATE <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(endDate);
		}
		if (StringUtils.isNotEmpty(inUse)) {
			sql.append(" AND R.IN_USE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(inUse);
		}
		sql.append(" ORDER BY E.PURCHASE_DATE DESC ");

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
	 * @Title: queryForEmplacingService
	 * @Description: TODO(寄存设备和墓穴使用记录查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author luguosui
	 * @date 2011-12-14
	 */
	public DataSet queryForEmplacingService(ParameterSet pset) {

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> ObjectList = new ArrayList<String>();

		String resourceId = (String) pset.getParameter("resourceId");
		String applyType = (String) pset.getParameter("applyType");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String saveName = (String) pset.getParameter("saveName");

		DataSet ds = new DataSet();

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT S.APPLY_ID, ");
		sql.append(" 	S.START_TIME, ");
		sql.append(" 	S.END_TIME, ");
		sql.append(" 	S.Emplacing_PLACE AS RESOUCE_ID, ");
		sql.append(" 	R.RESOURCE_NAME AS RESOURCE_NAME, ");
		sql.append("	S.Emplacing_PEOPLE AS PEOPLE_ID, ");
		sql.append(" 	I.NAME AS PEOPLE_NAME, ");
		sql.append(" 	A.DEAD_ID, ");
		sql.append(" 	A.CUSTOM_ID, ");
		sql.append(" 	D.NAME AS DEAD_NAME, ");
		sql.append("    D.SEX AS DEAD_SEX, ");
		sql.append("    D.AGE AS DEAD_AGE, ");
		sql.append("    P.NAME AS CUSTOM_NAME, ");
		sql.append("    P.MOBIL_PHONE AS CUSTOM_PHONE ");
		sql.append(" 	FROM FIS_SERVICE_Current_emplacing S ");
		sql.append(" 	LEFT JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID ");
		sql.append(" 	LEFT JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID ");
		sql.append(" LEFT	JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID ");
		sql.append(" 	LEFT JOIN FIS_PEOPLE_INFO I ON S.Emplacing_PEOPLE = I.PEOPLE_ID ");
		sql.append(" 	LEFT JOIN FIS_RESOURCE_INFO R ON S.emplacing_PLACE = R.RESOURCE_ID ");
		sql.append(" 	WHERE 1= 1 ");
		// sql.append(" WHERE S.STATUS != '3' ");
		// sql.append(" AND S.STATUS != '0' ");
		if (StringUtils.isNotEmpty(applyType)) {
			sql.append("   AND A.APPLY_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(applyType);
		}
		if (StringUtils.isNotEmpty(saveName)) {
			sql.append("   AND R.RESOURCE_NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(saveName);
		}
		if (StringUtils.isNotEmpty(resourceId)) {
			sql.append("   AND S.emplacing_PLACE = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(resourceId);
		}
		if (StringUtils.isNotEmpty(startTime)) {
			sql.append(" AND ((S.START_TIME >= ? AND S.END_TIME IS NULL) OR ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
		}
		if (StringUtils.isNotEmpty(startTime) && StringUtils.isNotEmpty(endTime)) {
			sql.append(" (S.START_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" AND S.END_TIME <= ?)) ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}
		sql.append(" ORDER BY S.START_TIME ,S.emplacing_PLACE, S.APPLY_ID ");
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

	/**
	 * 
	 * @Title: queryForRefrigeratedService
	 * @Description: TODO(冷藏柜使用记录查询)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author wangziming
	 * @date 2011-12-14
	 */
	public DataSet queryForRefrigeratedService(ParameterSet pset) {

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> ObjectList = new ArrayList<String>();

		String resourceId = (String) pset.getParameter("resourceId");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String saveName = (String) pset.getParameter("saveName");

		DataSet ds = new DataSet();

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT S.APPLY_ID, ");
		sql.append(" 	S.START_TIME, ");
		sql.append(" 	S.END_TIME, ");
		sql.append(" 	S.SAVE_PLACE AS RESOUCE_ID, ");
		sql.append(" 	R.RESOURCE_NAME AS RESOURCE_NAME, ");
		sql.append("	S.STORAGE_PEOPLE AS PEOPLE_ID, ");
		sql.append(" 	I.NAME AS PEOPLE_NAME, ");
		sql.append(" 	A.DEAD_ID, ");
		sql.append(" 	A.CUSTOM_ID, ");
		sql.append(" 	D.NAME AS DEAD_NAME, ");
		sql.append("    D.SEX AS DEAD_SEX, ");
		sql.append("    D.AGE AS DEAD_AGE, ");
		sql.append("    P.NAME AS CUSTOM_NAME, ");
		sql.append("    P.MOBIL_PHONE AS CUSTOM_PHONE ");
		sql.append(" 	FROM FIS_SERVICE_STORAGE S ");
		sql.append(" 	LEFT JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID ");
		sql.append(" 	LEFT JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID ");
		sql.append(" 	JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID ");
		sql.append(" 	LEFT JOIN FIS_PEOPLE_INFO I ON S.STORAGE_PEOPLE = I.PEOPLE_ID ");
		sql.append(" 	LEFT JOIN FIS_RESOURCE_INFO R ON S.SAVE_PLACE = R.RESOURCE_ID ");
		sql.append(" 	WHERE S.STATUS != '3' ");
		sql.append("    AND S.STATUS != '0' ");
		if (StringUtils.isNotEmpty(saveName)) {
			sql.append("   AND R.RESOURCE_NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(saveName);
		}
		if (StringUtils.isNotEmpty(resourceId)) {
			sql.append("   AND S.SAVE_PLACE = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(resourceId);
		}
		if (StringUtils.isNotEmpty(startTime)) {
			sql.append(" AND ((S.START_TIME >= ? AND S.END_TIME IS NULL) OR ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
		}
		if (StringUtils.isNotEmpty(startTime) && StringUtils.isNotEmpty(endTime)) {
			sql.append(" (S.START_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" AND S.END_TIME < ?)) ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}
		sql.append(" ORDER BY S.SAVE_PLACE, S.START_TIME, S.APPLY_ID ");
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
		sqlBuffer.append(" SELECT * FROM FIS_EQUIPMENT_INFO O ");
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