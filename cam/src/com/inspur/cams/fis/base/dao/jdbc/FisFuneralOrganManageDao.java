package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Field;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.data.ParameterSet;


import com.inspur.cams.fis.base.dao.IFisFuneralOrganManageDao;
import com.inspur.cams.fis.base.data.FisFuneralOrganManage;
import com.inspur.cams.fis.util.ProceduresUtil;
import com.inspur.cams.fis.util.ProceduresUtil.Proc;

/**
 * @title:FisFuneralOrganManageDao
 * @description:
 * @author:
 * @since:2012-04-03
 * @version:1.0
 */
public class FisFuneralOrganManageDao extends EntityDao<FisFuneralOrganManage>
		implements IFisFuneralOrganManageDao {

	public FisFuneralOrganManageDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisFuneralOrganManage.class;
	}

	/**
	 * 根据行政区划过滤查询结果
	 */
	public DataSet queryInfoByArea(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		String area = (String) pset.getParameter("areaCode@like");
		String organCode = (String) pset.getParameter("organCode");
		String unitId = (String) pset.getParameter("unitId");
		String unitName = (String) pset.getParameter("unitName");
		StringBuffer sql = new StringBuffer();
		sql.append("select * from FIS_FUNERAL_ORGAN_MANAGE where 1=1 ");
		if(area!=null && !("".equals(area))){
			sql.append(" and area_code like ?");
			typeList.add(Types.VARCHAR);
			objsList.add(area);
		}
		if(organCode!=null && !("".equals(organCode))){
			sql.append(" and organ_code = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(organCode);
		}
		if(unitId!=null && !("".equals(unitId))){
			sql.append(" and unit_id = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(unitId);
		}
		if(unitName!=null && !("".equals(unitName))){
			sql.append(" and unit_name = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(unitName);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		DataSet ds = new DataSet();
		if(typeList.size()>0 && objsList.size()>0){
			ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}
	public void deleteStruAll() {
		executeUpdate("delete from FisFuneralOrganManage");
	}

	public Boolean queryUserIfExist(String organCode) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		typeList.add(Types.VARCHAR);
		objsList.add(organCode);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		StringBuffer sql1 = new StringBuffer("");
		sql1.append("select t.organ_code from pub_organ t where t.organ_code = ?");
		DataSet ds1 = this.executeDataset(sql1.toString(), types, args, true);
		if (ds1.getCount()>0) {
			return true;
		}
		StringBuffer sql2 = new StringBuffer("");
		sql2.append("select t.user_id from pub_users t where t.user_id = ?");
		DataSet ds2 = this.executeDataset(sql2.toString(), types, args, true);
		if (ds2.getCount()>0) {
			return true;
		}
		StringBuffer sql3 = new StringBuffer("");
		sql3.append("select t.organ_code from fis_funeral_organ_manage t where t.organ_code = ?");
		DataSet ds3 = this.executeDataset(sql3.toString(), types, args, true);
		if (ds2.getCount()>0) {
			return true;
		}
		return false;
	}
	 /**
	* @Title: queryOrganByUnitId
	* @Description: 殡仪馆树的查询
	* @return DataSet  
	* @throws
	* @author jiangzhaobao
	 */
	public DataSet queryOrganByUnitId(ParameterSet pset){
		String UNIT_ID = (String) pset.getParameter("unitId");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * FROM FIS_FUNERAL_ORGAN_MANAGE WHERE 1=1 ");
		if (StringUtils.isNotEmpty(UNIT_ID) && !(UNIT_ID.substring(2).equals("0000"))) {
			if(UNIT_ID.substring(4).equals("00")) {
				sql.append(" AND SUBSTR(UNIT_ID,3,4) = ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(UNIT_ID.substring(0, 4));
			}else {
				sql.append(" AND SUBSTR(UNIT_ID,3,6) = ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(UNIT_ID);
			}
		}
		
		sql.append(" ORDER BY UNIT_ID");
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
		/**
		FieldSet fs = new FieldSet();
		if (ds.getCount()>0) {
			Iterator<String> it = ds.getRecord(0).keys();
			while(it.hasNext()){
				String key = it.next();
				key=key.toLowerCase();
				String[] arr=key.split("_");
				if(arr.length!=0){
					key=arr[0];
					for(int i=1;i<arr.length;i++){
						String str=arr[i].substring(0, 1).toUpperCase()+arr[i].substring(1);
						key=key+str;
					}
				}
				Field field = new Field();
				field.setName(key);
				fs.add(field);
			}
		}
		ds.setFieldSet(fs);
		*/
		return ds;
	}

	/**
	 * @Description: 馆基本信息统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganSum(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_ORGAN_BASE");
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
	 * @Description: 馆建设情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganBuildSum(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_ORGAN_BUILD");
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
	 * @Description: 馆设备情况统计
	 * @author xuexzh
	 */
	public DataSet queryFuneralOrganEquSum(ParameterSet pset) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "FIS_QUERY_FUNERAL_ORGAN_EQU");
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
