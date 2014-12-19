package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.fis.base.dao.IFisPeopleInfoDao;
import com.inspur.cams.fis.base.data.FisPeopleInfo;
import com.inspur.cams.fis.util.ProceduresUtil;
import com.inspur.cams.fis.util.ProceduresUtil.Proc;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisPeopleInfoDao
 * @Description: TODO 殡葬业务工作人员信息表dao的实现
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisPeopleInfoDao extends EntityDao<FisPeopleInfo> implements IFisPeopleInfoDao {

	public FisPeopleInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisPeopleInfo.class;
	}

	// 查询服务所需资源，返回bean为大写表字段
	public DataSet queryForService(ParameterSet pset) {
		String serviceId = (String) pset.getParameter("serviceId");
		int[] type = new int[1];
		Object[] service = new Object[1];
		type[0] = Types.VARCHAR;
		service[0] = serviceId;
		List list = this.executeQuery("SELECT * FROM FIS_PEOPLE_INFO P, FIS_SERVICE_PEOPLE S WHERE P.PEOPLE_ID = S.PEOPLE_ID AND S.SERVICE_ID = ?", type, service);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			FisPeopleInfo fisPeopleInfo = new FisPeopleInfo();
			fisPeopleInfo.setRelationId((String) map.get("RELATION_ID"));
			fisPeopleInfo.setServiceId((String) map.get("SERVICE_ID"));
			fisPeopleInfo.setPeopleId((String) map.get("PEOPLE_ID"));
			fisPeopleInfo.setName((String) map.get("NAME"));
			fisPeopleInfo.setSex((String) map.get("SEX"));
			fisPeopleInfo.setPhone((String) map.get("PHONE"));
			ds.addRecord(fisPeopleInfo);
		}
		return ds;
	}

	/**
	 * 
	 * @Title: open
	 * @Description: TODO(工作人员信息--开启职务)
	 * @param 设定文件
	 * @return void 返回类型
	 * @author wangziming
	 * @date 2011-12-3
	 */
	public void open(String peopleId) {

	}

	/**
	 * 
	 * @Title: cencel
	 * @Description: TODO(工作人员信息--注销职务)
	 * @param 设定文件
	 * @return void 返回类型
	 * @author wangziming
	 * @date 2011-12-3
	 */
	public void cencel(String peopleId) {

	}

	/**
	 * 临时，后期需改 xuexzh
	 */
	public DataSet queryForPeopleRecords(ParameterSet pset) {
		DataSet ds = new DataSet();

		// 获取查询条件
		String qname = (String) pset.getParameter("name");
		String qsex = (String) pset.getParameter("sex");
		String qidCard = (String) pset.getParameter("idCard");
		String qpeopleId = (String) pset.getParameter("peopleId");
		String qworkType = (String) pset.getParameter("workType");

		String ifCancel = (String) pset.getParameter("ifCancel");
		String peopleType = (String) pset.getParameter("peopleType");
		String education = (String) pset.getParameter("education");
		String profession = (String) pset.getParameter("profession");
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		String createOrgan = (String) pset.getParameter("createOrgan");
		String createOrganName = (String) pset.getParameter("createOrganName");
		List<Integer> peoType = new ArrayList<Integer>();
		List<String> peoObject = new ArrayList<String>();

		StringBuffer peoSql = new StringBuffer(
				"SELECT P.PEOPLE_ID, P.NAME, P.SEX, P.ID_CARD,P.PHONE,P.WORK_DATE,P.IF_CANCEL,P.PEOPLE_TYPE,P.EDUCATION,P.PROFESSION,P.CREATE_ORGAN_NAME,P.POSITION,'' AS DUTY,'' AS DUTY_LEVEL FROM FIS_PEOPLE_INFO P WHERE 1=1 ");
		peoSql.append(" AND P.IN_USE=? ");
		peoType.add(Types.VARCHAR);
		peoObject.add("1");
		
		if (StringUtils.isNotEmpty(ifCancel)) {
			peoSql.append(" AND P.IF_CANCEL=? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(ifCancel);
		}
		if (StringUtils.isNotEmpty(qname)) {
			peoSql.append(" AND P.NAME = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qname);
		}
		if (StringUtils.isNotEmpty(qsex)) {
			peoSql.append(" AND P.SEX = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qsex);
		}
		if (StringUtils.isNotEmpty(peopleType)) {
			peoSql.append(" AND P.PEOPLE_TYPE = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(peopleType);
		}
		if (StringUtils.isNotEmpty(education)) {
			peoSql.append(" AND P.EDUCATION = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(education);
		}
		if (StringUtils.isNotEmpty(profession)) {
			peoSql.append(" AND P.PROFESSION = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(profession);
		}
		if (StringUtils.isNotEmpty(startDate)) {
			peoSql.append(" AND P.WORK_DATE >= ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(startDate);
		}
		if (StringUtils.isNotEmpty(endDate)) {
			peoSql.append(" AND P.WORK_DATE <= ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(endDate);
		}
		if (StringUtils.isNotEmpty(qidCard)) {
			peoSql.append(" AND P.ID_CARD = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qidCard);
		}
		if (StringUtils.isNotEmpty(createOrgan)) {
			peoSql.append(" AND P.CREATE_ORGAN like ? || '%' ");
			peoType.add(Types.VARCHAR);
			peoObject.add(createOrgan);
		}
		if (StringUtils.isNotEmpty(createOrganName)) {
			peoSql.append(" AND P.CREATE_ORGAN = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(createOrganName);
		}
		if (StringUtils.isNotEmpty(qpeopleId)) {
			peoSql.append(" AND D.PEOPLE_ID = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qpeopleId);
		}
		if (StringUtils.isNotEmpty(qworkType)) {
			peoSql.append(" AND P.PEOPLE_ID IN (SELECT D.PEOPLE_ID FROM FIS_DUTY_INFO D WHERE D.WORK_TYPE = ?) ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qworkType);
		}
		
		peoSql.append(" ORDER BY P.CREATE_ORGAN,P.PEOPLE_ID");
		if (peoType.size() != 0 && peoObject.size() != 0) {
			int[] peoTypes = new int[peoType.size()];
			for (int i = 0; i < peoType.size(); i++) {
				peoTypes[i] = peoType.get(i);
			}
			Object[] peoArgs = peoObject.toArray(new Object[peoObject.size()]);
			ds = this.executeDataset(peoSql.toString(), peoTypes, peoArgs, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(peoSql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}

		DataSet dutyDs = new DataSet();

		dutyDs = this
				.executeDataset(
						"SELECT PEOPLE_ID,J.CODE,J.NAME||'('||P.NAME||')'  AS NAME FROM FIS_DUTY_INFO D LEFT JOIN DIC_FIS_JOB J ON D.WORK_TYPE = J.CODE LEFT JOIN DIC_PROFESSION_LEVEL p ON d.PROFESSION_LEVEL = P.CODE ORDER BY PEOPLE_ID",
						true);

		StringBuffer dutyTemp = new StringBuffer();
		for (int i = 0; i < ds.getCount(); i++) {
			Record record = ds.getRecord(i);
			String peopleId = (String) record.get("PEOPLE_ID");
			record.set("DUTY", "");
			dutyTemp.delete(0, dutyTemp.length());
			for (int j = 0; j < dutyDs.getCount(); j++) {
				Record rec = dutyDs.getRecord(j);
				if (peopleId.equals((String) rec.get("PEOPLE_ID"))) {
					dutyTemp.append((String) rec.get("NAME")).append(",");
				}
			}
			if (dutyTemp.toString().endsWith(","))
				dutyTemp.deleteCharAt(dutyTemp.length() - 1);

			record.set("DUTY", dutyTemp.toString());
		}
		return ds;
	}

	/**
	 * 
	 * @Title: queryForPeopleService
	 * @Description: TODO(查询人员服务量方法)
	 * @param
	 * @return 设定文件
	 * @return DataSet 返回类型
	 * @author wangziming
	 * @date 2011-12-13
	 */
	public DataSet queryForPeopleService(ParameterSet pset) {

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> ObjectList = new ArrayList<String>();

		String peopleId = (String) pset.getParameter("peopleId");
		String startTime = (String) pset.getParameter("startTime");
		String endTime = (String) pset.getParameter("endTime");
		String peopleName = (String) pset.getParameter("peopleName");

		DataSet ds = new DataSet();

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT APPLY_ID, ");
		sql.append("  SERVICE,SERVICE_ORDER, PLACE, START_TIME, END_TIME,RESOUCE_ID, RESOURCE_NAME, PEOPLE_ID, ");
		sql.append(" PEOPLE_NAME, DEAD_ID,  CUSTOM_ID,  DEAD_NAME, CUSTOM_NAME  FROM ((SELECT S.APPLY_ID, ");
		sql.append(" '接运' AS SERVICE, '01' AS SERVICE_ORDER,  S.END_PLACE AS PLACE, S.START_TIME, S.END_TIME, ");
		sql.append(" S.CAR_ID AS RESOUCE_ID,  S.CAR_NO AS RESOURCE_NAME, SC.People_Id AS PEOPLE_ID, peo.name AS PEOPLE_NAME, ");
		sql.append(" A.DEAD_ID, A.CUSTOM_ID, D.NAME AS DEAD_NAME, P.NAME AS CUSTOM_NAME  FROM fis_service_carry SC ");
		sql.append(" left join FIS_SERVICE_DRIVE S on SC.RECORD_ID = s.record_id LEFT JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID ");
		sql.append(" LEFT JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID  JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID ");
		sql.append(" LEFT JoIn fis_people_info peo on SC.People_Id = peo.people_id WHERE S.STATUS != '3'  AND S.STATUS != '0' ");
		if (StringUtils.isNotEmpty(peopleName)) {
			sql.append(" AND peo.NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleName);
		}
		if (StringUtils.isNotEmpty(peopleId)) {
			sql.append(" AND sC.People_Id = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleId);
		}
		if (StringUtils.isNotEmpty(startTime) || StringUtils.isNotEmpty(endTime)) {
			sql.append(" AND ((S.START_TIME >= ? AND S.END_TIME IS NULL) OR ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" (S.START_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" AND S.END_TIME < ?)))");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}
		sql.append(" UNION ALL " + " (SELECT S.APPLY_ID, " + " '保存' AS SERVICE, " + " '02' AS SERVICE_ORDER, " + " '' AS PLACE, " + " S.START_TIME, " + " S.END_TIME, "
				+ " S.SAVE_PLACE AS RESOUCE_ID, " + " R.RESOURCE_NAME AS RESOURCE_NAME, " + " S.STORAGE_PEOPLE AS PEOPLE_ID, " + " I.NAME AS PEOPLE_NAME, " + " A.DEAD_ID, "
				+ " A.CUSTOM_ID, " + " D.NAME AS DEAD_NAME, " + " P.NAME AS CUSTOM_NAME " + " FROM FIS_SERVICE_STORAGE S "
				+ " LEFT JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID " + " LEFT JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID "
				+ " JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID " + " LEFT JOIN FIS_PEOPLE_INFO I ON S.STORAGE_PEOPLE = I.PEOPLE_ID "
				+ " LEFT JOIN FIS_RESOURCE_INFO R ON S.SAVE_PLACE = R.RESOURCE_ID " + " WHERE S.STATUS != '3' " + " AND S.STATUS != '0' ");
		if (StringUtils.isNotEmpty(peopleName)) {
			sql.append(" AND I.NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleName);
		}
		if (StringUtils.isNotEmpty(peopleId)) {
			sql.append(" AND S.STORAGE_PEOPLE = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleId);
		}
		if (StringUtils.isNotEmpty(startTime) || StringUtils.isNotEmpty(endTime)) {
			sql.append(" AND ((S.START_TIME >= ? AND S.END_TIME IS NULL) OR ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" (S.START_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" AND S.END_TIME < ?)))");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}
		sql.append(" UNION ALL ");
		sql.append(" (SELECT S.APPLY_ID, '整容' AS SERVICE, '03' AS SERVICE_ORDER, '' AS PLACE, S.COSMETIC_TIME AS START_TIME,'' AS END_TIME, ");
		sql.append(" '' AS RESOUCE_ID, '' AS RESOURCE_NAME, S.COSMETIC_DIVISION AS PEOPLE_ID, I.NAME AS PEOPLE_NAME, ");
		sql.append(" A.DEAD_ID, A.CUSTOM_ID, D.NAME AS DEAD_NAME, P.NAME AS CUSTOM_NAME FROM FIS_SERVICE_COSMETIC S   JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID ");
		sql.append("  JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID  JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID ");
		sql.append(" LEFT JOIN FIS_PEOPLE_INFO I ON S.COSMETIC_DIVISION = I.PEOPLE_ID  WHERE S.STATUS != '3'  AND S.STATUS != '0' ");
		if (StringUtils.isNotEmpty(peopleName)) {
			sql.append(" AND I.NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleName);
		}
		if (StringUtils.isNotEmpty(peopleId)) {
			sql.append(" AND S.COSMETIC_DIVISION = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleId);
		}
		if (StringUtils.isNotEmpty(startTime)) {
			sql.append(" AND S.COSMETIC_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
		}
		if (StringUtils.isNotEmpty(endTime)) {
			sql.append(" AND S.COSMETIC_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}
		sql.append(" UNION ALL ");
		sql.append(" (SELECT S.APPLY_ID,'告别' AS SERVICE, '04' AS SERVICE_ORDER, '' AS PLACE, S.START_TIME, S.END_TIME,  S.USE_RESOURCE_ID AS RESOUCE_ID, ");
		sql.append(" R.RESOURCE_NAME AS RESOURCE_NAME, S.HOST_PEOPLE AS PEOPLE_ID, I.NAME AS PEOPLE_NAME, A.DEAD_ID,A.CUSTOM_ID, D.NAME AS DEAD_NAME, ");
		sql.append(" P.NAME AS CUSTOM_NAME  FROM FIS_SERVICE_FAREWELL S  LEFT JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID ");
		sql.append(" LEFT JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID ");
		sql.append(" LEFT JOIN FIS_PEOPLE_INFO I ON S.HOST_PEOPLE = I.PEOPLE_ID  LEFT JOIN FIS_RESOURCE_INFO R ON S.USE_RESOURCE_ID = R.RESOURCE_ID ");
		sql.append(" WHERE S.STATUS != '3'  AND S.STATUS != '0'  ");
		if (StringUtils.isNotEmpty(peopleName)) {
			sql.append(" AND I.NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleName);
		}
		if (StringUtils.isNotEmpty(peopleId)) {
			sql.append(" AND S.HOST_PEOPLE = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleId);
		}
		if (StringUtils.isNotEmpty(startTime) || StringUtils.isNotEmpty(endTime)) {
			sql.append(" AND ((S.START_TIME >= ? AND S.END_TIME IS NULL) OR ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" (S.START_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" AND S.END_TIME < ?)))");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}
		sql.append("  UNION ALL ");
		sql.append(" (SELECT S.APPLY_ID, '火化' AS SERVICE, '05' AS SERVICE_ORDER, '' AS PLACE, S.START_TIME, S.END_TIME, S.STOVE_ID AS RESOUCE_ID, ");
		sql.append("  R.RESOURCE_NAME AS RESOURCE_NAME,S.STOVE_PEOPLE AS PEOPLE_ID, I.NAME AS PEOPLE_NAME, A.DEAD_ID,A.CUSTOM_ID, D.NAME AS DEAD_NAME, ");
		sql.append(" P.NAME AS CUSTOM_NAME FROM FIS_SERVICE_CREMATION S  LEFT JOIN FIS_APPLY_INFO A ON S.APPLY_ID = A.APPLY_ID ");
		sql.append(" LEFT JOIN FIS_DEAD_INFO D ON A.DEAD_ID = D.DEAD_ID  JOIN FIS_PERSONAL_CUSTOM P ON A.CUSTOM_ID = P.CUSTOM_ID ");
		sql.append(" LEFT JOIN FIS_PEOPLE_INFO I ON S.STOVE_PEOPLE = I.PEOPLE_ID  LEFT JOIN FIS_RESOURCE_INFO R ON S.STOVE_ID = R.RESOURCE_ID ");
		sql.append(" WHERE S.STATUS != '3'  AND S.STATUS != '0' ");
		if (StringUtils.isNotEmpty(peopleName)) {
			sql.append(" AND I.NAME = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleName);
		}
		if (StringUtils.isNotEmpty(peopleId)) {
			sql.append(" AND S.STOVE_PEOPLE = ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(peopleId);
		}
		if (StringUtils.isNotEmpty(startTime) || StringUtils.isNotEmpty(endTime)) {
			sql.append(" AND ((S.START_TIME >= ? AND S.END_TIME IS NULL) OR ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" (S.START_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			ObjectList.add(startTime);
			sql.append(" AND S.END_TIME < ?))))) AA");
			typeList.add(Types.VARCHAR);
			ObjectList.add(endTime);
		}
		sql.append(" ORDER BY AA.SERVICE_ORDER, AA.START_TIME, AA.APPLY_ID ");

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

	/**
	 * @Description: TODO(查询人员服务量)
	 */
	public DataSet querySumForServer(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_SERVER_WORKLOAD");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_people_id");
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String startTime = (String) pset.getParameter("startTime");// 查询时间_起
		String endTime = (String) pset.getParameter("endTime");// 查询时间_止
		String peopleId = (String) pset.getParameter("peopleId");
		map.put("parameterValue_1", startTime);
		map.put("parameterValue_2", endTime);
		map.put("parameterValue_3", peopleId);
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		set = ProceduresUtil.fixDataSet(set);
		return set;
	}

	/**
	 * @Title: queryForExport
	 * @Description: TODO(数据上报导出数据方法)
	 * @param set
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryForExport(ParameterSet set) {
		String qStartTime = (String) set.get("qStartTime");
		String qEndTime = (String) set.get("qEndTime");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(" SELECT * FROM FIS_PEOPLE_INFO O ");
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

	/**
	 * @Description: 馆工作人员统计一
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeoSum(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_ORGAN_PEO");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qPopulace);
		
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}

	/**
	 * @Description: 馆工作人员统计二
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganPeo2Sum(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_ORGAN_PEO2");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qPopulace);
		
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}

	/**
	 * @Description: 馆技术人员统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganTePeoSum(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_ORGAN_T_PEO");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qPopulace);
		
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}
}
