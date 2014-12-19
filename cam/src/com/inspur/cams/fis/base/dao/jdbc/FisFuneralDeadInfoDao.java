package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.bsp.util.StringUtil;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.fis.base.dao.IFisFuneralDeadInfoDao;
import com.inspur.cams.fis.base.data.FisFuneralDeadInfo;
import com.inspur.cams.fis.util.ProceduresUtil;
import com.inspur.cams.fis.util.ProceduresUtil.Proc;

/**
* @Package com.inspur.cams.fis.base.dao.jdbc.FisFuneralDeadInfoDao
* @Description: 数据上报，逝者信息实现
* @author jiangzhaobao 
* @date 2012-4-5
 */
 public class FisFuneralDeadInfoDao extends EntityDao<FisFuneralDeadInfo> implements IFisFuneralDeadInfoDao{

 	public FisFuneralDeadInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisFuneralDeadInfo.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from FisFuneralDeadInfo");
	}
   /**
	* @Title: queyDeadInfo
	* @Description: 数据上报，逝者信息查询
	* @return DataSet  
	* @throws
	* @author jiangzhaobao
	 */
	public DataSet queyDeadInfo(ParameterSet pset){
		String populace = (String) pset.getParameter("populace");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String organId = (String) pset.getParameter("organId");
		String qreferentialTypeName = (String) pset.getParameter("qreferentialTypeName");
		String ageBegin = (String) pset.getParameter("ageBegin");
		String ageEnd = (String) pset.getParameter("ageEnd");
		String deathCaseValue = (String) pset.getParameter("deathCaseValue");
		String SRecieveTime = (String) pset.getParameter("SRecieveTime");
		String ERecieveTime = (String) pset.getParameter("ERecieveTime");
		String SCremationTime = (String) pset.getParameter("SCremationTime");
		String ECremationTime = (String) pset.getParameter("ECremationTime");
		String fisAshesGo = (String) pset.getParameter("fisAshesGo");
		String deadId = (String) pset.getParameter("deadId");
		String organCode = (String) pset.getParameter("organCode");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT VCI.*,FFO.UNIT_NAME");
		sql.append(" FROM FIS_V_CREMATION_INFO VCI LEFT JOIN FIS_FUNERAL_ORGAN_MANAGE FFO ON VCI.CREATE_ORGAN=FFO.UNIT_ID");
		sql.append(" WHERE VCI.IF_FINISH=?  ");
		typeList.add(Types.VARCHAR);
		objsList.add("1");
		
		if (StringUtils.isNotEmpty(populace)) {
			String subPopulace = "";
			if (populace.substring(2, 12).equals("0000000000")) {
				subPopulace = populace.substring(0, 2);
			} else if (populace.substring(4, 12).equals("00000000")) {
				subPopulace = populace.substring(0, 4);
			} else if (populace.substring(6, 12).equals("000000")) {
				subPopulace = populace.substring(0, 6);
			} else if (populace.substring(9, 12).equals("000")) {
				subPopulace = populace.substring(0, 9);
			} else {
				subPopulace = populace;
			}
			sql.append(" and  VCI.POPULACE LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			objsList.add(subPopulace);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" AND VCI.NAME = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(name);
		}
		if (StringUtils.isNotEmpty(idCard)) {
			sql.append(" AND VCI.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(idCard);
		}
		if (StringUtils.isNotEmpty(organId)) {
			sql.append( " AND  (");
			   String[] ary = organId.split(",");
				for (int i = 0; i < ary.length; i++) {
					sql.append(" VCI.CREATE_ORGAN=? ");
					if(i!=ary.length-1){
						sql.append(" OR ");
					}
					typeList.add(Types.VARCHAR);
					objsList.add(ary[i]);
				}
				sql.append(" ) ");
		}
		
		if (StringUtils.isNotEmpty(organCode)) {
			sql.append(" AND VCI.CREATE_ORGAN like ?||'%' ");
			typeList.add(Types.VARCHAR);
			objsList.add(organCode);
		}
		
		//优惠类型
		if (StringUtils.isNotEmpty(qreferentialTypeName)) {
			sql.append(" AND VCI.PREFERENTIAL_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qreferentialTypeName);
		}
		if (StringUtils.isNotEmpty(ageBegin)) {
			sql.append(" AND  VCI.AGE>=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(ageBegin);
		}
		if (StringUtils.isNotEmpty(ageEnd)) {
			sql.append(" AND  VCI.AGE<=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(ageEnd);
		}
		if(StringUtils.isNotEmpty(deathCaseValue)){
			   sql.append( " AND  (");
			   String[] ary = deathCaseValue.split(",");
				for (int i = 0; i < ary.length; i++) {
					sql.append(" VCI.DEATH_CAUSE=? ");
					if(i!=ary.length-1){
						sql.append(" OR ");
					}
					typeList.add(Types.VARCHAR);
					objsList.add(ary[i]);
				}
				sql.append(" ) ");
		 }
		if (StringUtils.isNotEmpty(SRecieveTime)) {
			sql.append(" AND  VCI.RECEIVE_TIME>=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(SRecieveTime);
		}
		if (StringUtils.isNotEmpty(ERecieveTime)) {
			sql.append(" AND  VCI.RECEIVE_TIME<=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(ERecieveTime);
		}
		if (StringUtils.isNotEmpty(SCremationTime)) {
			sql.append(" AND  VCI.START_TIME>=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(SCremationTime);
		}
		if (StringUtils.isNotEmpty(ECremationTime)) {
			sql.append(" AND  VCI.START_TIME<=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(ECremationTime);
		}
		if (StringUtils.isNotEmpty(fisAshesGo)) {
			sql.append(" AND VCI.ASHES_GO = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(fisAshesGo);
		}
		if (StringUtils.isNotEmpty(deadId)) {
			sql.append(" AND VCI.DEAD_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(deadId);
		}
		
		sql.append(" ORDER BY VCI.CREATE_ORGAN ASC,VCI.POPULACE ASC,VCI.START_TIME ASC,VCI.DEAD_ID ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
	/**
	* @Title: queyDeadNumber
	* @Description: 数据上报，逝者信息统计
	* @return DataSet  
	* @throws
	* @author jiangzhaobao
	 */
	public DataSet queyDeadNumber(ParameterSet pset){
		String populace = (String) pset.getParameter("populace");
		String organId = (String) pset.getParameter("organId");
		String qreferentialTypeName = (String) pset.getParameter("qreferentialTypeName");
		String SCremationTime = (String) pset.getParameter("SCremationTime");
		String ECremationTime = (String) pset.getParameter("ECremationTime");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT ROWNUM,FFF.*  FROM( SELECT FDI.ORGAN_ID, FOM.UNIT_NAME,COUNT(FDI.DEAD_ID) AS SUM  FROM FIS_FUNERAL_DEAD_INFO FDI  ");
		sql.append("   JOIN FIS_FUNERAL_ORGAN_MANAGE FOM ON FDI.ORGAN_ID=FOM.UNIT_ID   ");
		sql.append("  WHERE 1=1   ");
		if (StringUtils.isNotEmpty(populace)) {
			String subPopulace = "";
			if (populace.substring(2, 12).equals("0000000000")) {
				subPopulace = populace.substring(0, 2);
			} else if (populace.substring(4, 12).equals("00000000")) {
				subPopulace = populace.substring(0, 4);
			} else if (populace.substring(6, 12).equals("000000")) {
				subPopulace = populace.substring(0, 6);
			} else if (populace.substring(9, 12).equals("000")) {
				subPopulace = populace.substring(0, 9);
			} else {
				subPopulace = populace;
			}
			sql.append(" and  FDI.POPULACE LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			objsList.add(subPopulace);
		}
		if (StringUtils.isNotEmpty(organId)) {
			sql.append(" AND FDI.ORGAN_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(organId);
		}
		//优惠类型
		if (StringUtils.isNotEmpty(qreferentialTypeName)) {
			sql.append(" AND FDI.PREFERENTIAL_TYPE_NAME = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qreferentialTypeName);
		}
		if (StringUtils.isNotEmpty(SCremationTime)) {
			sql.append(" AND  FDI.START_TIME>=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(SCremationTime);
		}
		if (StringUtils.isNotEmpty(ECremationTime)) {
			sql.append(" AND  FDI.START_TIME<=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(ECremationTime);
		}
		sql.append("  GROUP BY FOM.UNIT_NAME,FDI.ORGAN_ID ");
		sql.append("  ORDER BY FDI.ORGAN_ID ) FFF ");
		
		
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
	/**
	* @Title: queryByReductionDic
	* @Description: TODO(优惠类型字典)
	* @return DataSet  
	* @throws
	* @author jiangzhaobao
	 */
	public DataSet queryByReductionDic(ParameterSet pset){
		String sql="select  t.preferential_type_name from fis_funeral_dead_info t group by t.preferential_type_name having t.preferential_type_name is not null ";
		DataSet ds=this.executeDataset(sql, true);
		return ds;
	}
	
	/**
	 * 分所属地区统计逝者
	 * @param pset
	 * @return
	 */
	public DataSet queryDeadInfoSumByArea(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_CRE_AREA_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * 分所属地区统计逝者
	 * @param pset
	 * @return
	 */
	public DataSet queryDeadInfoSumByUnit(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_CRE_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 获取所在地区统计火化信息
	 * @author xuexzh
	 */
	public DataSet queyCremationDeadInfoByArea(ParameterSet pset) {
		String areaCode = (String) pset.getParameter("AREA_CODE");
		String unitId = (String) pset.getParameter("UNIT_ID");
		String startTime = (String) pset.getParameter("START_TIME");
		String endTime = (String) pset.getParameter("END_TIME");
		String flag = (String) pset.getParameter("FLAG");
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT SC.APPLY_ID,D.DEAD_ID,A.*,D.*,SC.*,R.REDUCATION_TYPE_NAME,O.UNIT_ID,O.UNIT_NAME,get_city_full_name(D.POPULACE) AS FULL_NAME");
		sql.append(" FROM FIS_SERVICE_CREMATION SC");
		sql.append(" LEFT JOIN FIS_APPLY_INFO A ON SC.APPLY_ID = A.APPLY_ID");
		sql.append(" LEFT JOIN FIS_DEAD_INFO D ON SC.DEAD_ID = D.DEAD_ID");
		sql.append(" LEFT JOIN FIS_FUNERAL_ORGAN_MANAGE O ON SC.CREATE_ORGAN = O.UNIT_ID");
		sql.append(" LEFT JOIN FIS_REDUCATION_TYPE R ON D.PREFERENTIAL_TYPE=R.REDUCATION_TYPE_ID");
		sql.append(" WHERE 1=1 ");

		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		sql.append(" AND A.APPLY_TYPE=?");
		typeList.add(Types.VARCHAR);
		objsList.add("B");

		sql.append(" AND A.IF_FINISH=?");
		typeList.add(Types.VARCHAR);
		objsList.add("1");

		sql.append(" AND SC.STATUS!=?");
		typeList.add(Types.VARCHAR);
		objsList.add("3");
		
		if(!StringUtil.isEmptyString(areaCode)) {
			sql.append(" AND D.POPULACE LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			objsList.add(areaCode);
		}
		
		if(!StringUtil.isEmptyString(flag)) {
			if (!"NUM".equals(flag)) {
				if("OT".equals(flag)) {
					sql.append(" AND D.PREFERENTIAL_TYPE is null ");
				}else {
					sql.append(" AND D.PREFERENTIAL_TYPE=? ");
					typeList.add(Types.VARCHAR);
					objsList.add(flag);
				}
			}
		}

		if(!StringUtil.isEmptyString(unitId)) {
			sql.append(" AND SC.CREATE_ORGAN = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(unitId);
		}
		
		if(!StringUtil.isEmptyString(startTime)) {
			sql.append(" AND SC.START_TIME >= ?");
			typeList.add(Types.VARCHAR);
			objsList.add(startTime);
		}
		
		if(!StringUtil.isEmptyString(endTime)) {
			sql.append(" AND SC.END_TIME <= ?");
			typeList.add(Types.VARCHAR);
			objsList.add(endTime);
		}
		
		sql.append(" ORDER BY D.POPULACE,SC.RECORD_ID");
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		//return executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),true);
		return executeDataset(sql.toString(),types,args,true);
	}
	
	public DataSet queryNumByAge(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_DEADER_NUM");
		map.put("parameterNum", 4);
		map.put("parameterName_1", "in_cremation_time_begin");
		map.put("parameterName_2", "in_cremation_time_end");
		map.put("parameterName_3", "in_apply_type");
		map.put("parameterName_4", "in_populace");
		
		map.put("NumberOfResultSet",1);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String cremationTimeBegin = (String) pset.getParameter("cremationTimeBegin");// 查询时间_起
		String cremationTimeEnd = (String) pset.getParameter("cremationTimeEnd");// 查询时间_止
		String applyType = (String) pset.getParameter("applyType");
		String populace = (String) pset.getParameter("populace");
		map.put("parameterValue_1", cremationTimeBegin);
		map.put("parameterValue_2", cremationTimeEnd);
		map.put("parameterValue_3", applyType);
		map.put("parameterValue_4", populace);
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
	 * @Description: 分所在地区统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByArea(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_DC_AREA_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 分馆统计死亡原因
	 * @author xuexzh
	 */
	public DataSet queryDeathCauseInfoSumByUnit(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_DC_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 分所在地区统计病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByArea(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_DD_AREA_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 分馆统计病故病种
	 * @author xuexzh
	 */
	public DataSet queryDeathDiseaseInfoSumByUnit(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_DD_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 分所在地区统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByArea(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_RED_AREA_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 分馆统计享受惠民政策
	 * @author xuexzh
	 */
	public DataSet queryDeathReduInfoSumByUnit(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_RED_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 分馆统计逝者服务情况
	 * @author xuexzh
	 */
	public DataSet queryDeathServicesInfoSumByUnit(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_SERVICE_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 分馆统计骨灰去向
	 * @author xuexzh
	 */
	public DataSet queryDeathAshesgoInfoSumByUnit(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_ASHESGO_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
	 * @Description: 殡仪馆火化量分地区统计数
	 * @author xuexzh
	 */
	public DataSet queryDeadInfoAreaSumByArea(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_AREA_NUM");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "in_start_time");
		map.put("parameterName_2", "in_end_time");
		map.put("parameterName_3", "in_area_code");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qStartDate = (String) pset.getParameter("qStartTime");// 查询时间_起
		String qEndDate = (String) pset.getParameter("qEndTime");// 查询时间_止
		String qPopulace = (String) pset.getParameter("qPopulace");// 查询时间_止
		map.put("parameterValue_1", qStartDate);
		map.put("parameterValue_2", qEndDate);
		map.put("parameterValue_3", qPopulace);
		
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
