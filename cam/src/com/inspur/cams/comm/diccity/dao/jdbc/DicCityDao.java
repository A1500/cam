package com.inspur.cams.comm.diccity.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.diccity.dao.IDicCityDao;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * 行政区划dao
 * @author wangbaocai
 * @date 2011-6-23
 */
public class DicCityDao extends EntityDao<DicCity> implements IDicCityDao {
	
	// 查询下级行政区划sql
	public static String DIC_CITY_UPS_QUERY = "SELECT * FROM DIC_CITY WHERE UPS=? ORDER　BY ID ";
	// 查询OrganInfoById
	public static String GET_ORGAN_INFO_BYID = "SELECT * FROM DIC_CITY WHERE ID=? ORDER　BY ID ";
	// 查询下级，不包括本级，按照行政区划排序
	public static String DIC_CITY_UPS_WITHOUT_SELF_QUERY = "SELECT * FROM DIC_CITY WHERE UPS=? AND IS_SELF='0' ORDER BY ID";

  	@Override
	public Class<DicCity> getEntityClass() {
		return DicCity.class;
	}

	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnderling(String ups) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {ups};
		List list = null;
		if("rootId".equals(ups) || ups.endsWith("0000000000")|| ups.endsWith("00000000"))
			list = executeQuery(DIC_CITY_UPS_QUERY, types, objs);
		else
			list = executeQuery(GET_ORGAN_INFO_BYID, types, objs);
			
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			DicCity view = new DicCity();
			view.setId((String) map.get("ID"));
			view.setName((String) map.get("NAME"));
			view.setLeve((String) map.get("LEVE"));
			view.setUps((String) map.get("UPS"));
			view.setFlag((String) map.get("FLAG"));
			ds.addRecord(view);
		}
		return ds;
	}
	
	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnder(String ups) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {ups};
		List list = null;
		if("rootId".equals(ups) || ups.endsWith("0000000000")|| ups.endsWith("00000000")|| ups.endsWith("000000"))
			list = executeQuery(DIC_CITY_UPS_WITHOUT_SELF_QUERY, types, objs);
		else
			list = executeQuery(GET_ORGAN_INFO_BYID, types, objs);
			
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			DicCity view = new DicCity();
			view.setId((String) map.get("ID"));
			view.setName((String) map.get("NAME"));
			view.setLeve((String) map.get("LEVE"));
			view.setUps((String) map.get("UPS"));
			view.setFlag((String) map.get("FLAG"));
			ds.addRecord(view);
		}
		return ds;
	}

	/**
	 * 查询下级行政区划，不包含本级
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnderlingWithoutSelf(String ups) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {ups};
		List list = executeQuery(DIC_CITY_UPS_WITHOUT_SELF_QUERY, types, objs);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			DicCity view = new DicCity();
			view.setId((String) map.get("ID"));
			view.setName((String) map.get("NAME"));
			view.setLeve((String) map.get("LEVE"));
			view.setUps((String) map.get("UPS"));
			view.setFlag((String) map.get("FLAG"));
			view.setIsSelf((String) map.get("IS_SELF"));
			ds.addRecord(view);
		}
		return ds;
	}
	
	/**
	 * 行政区划自动补全
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryAutoComplete(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String queryCode = (String) pset.getParameter("queryCode");
		String pageCount = (String) pset.getParameter("pageCount");
		StringBuffer sql = new StringBuffer(
				"select d.* from (select id,name,leve,ups,flag,full_name from dic_city where 1=1");

		if (organCode != null && !"".equals(organCode)) {
			if ("0000000000".equals(organCode.substring(2))) { // 省局
				sql.append(" and substr(id,1,2)=?");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2));
			} else if ("00000000".equals(organCode.substring(4))) { // 市局
				sql.append(" and substr(id,1,4)=?");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4));
			} else if ("000000".equals(organCode.substring(6))) { // 县局
				sql.append(" and substr(id,1,6)=?");
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6));
			}
		}
		
		sql.append(" ) d where 1=1"); 

		if (queryCode != null && !"".equals(queryCode)) {
			sql.append(" and (d.id like ? or d.full_name like ?)");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + queryCode + "%");
			typeList.add(Types.VARCHAR);
			argsList.add("%" + queryCode + "%");
		}
		
		sql.append(" order by d.id");
			
		StringBuffer sql_page = new StringBuffer("select * from (select row_.*,rownum rn from (");
		sql_page.append(sql);
		sql_page.append(") row_ where rownum >=0 ) where rn<="+pageCount);

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql_page.toString(), types, args, true);

		} else {
			ds = this.executeDataset(sql_page.toString(), true);
		}
		
		return ds;

	}
	
	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public String getOrganNameById(String id) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {id};
		List list = executeQuery(GET_ORGAN_INFO_BYID, types, objs);
		String name="";
		if(list.size()>0){
			HashMap map = (HashMap) list.get(0);
		    name=(String) map.get("NAME");
		}
		return name;
	}
	
	public DataSet queryCity(ParameterSet pset) {
		String ups = (String) pset.getParameter("ups");
		String queryName = (String)pset.getParameter("queryName");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(
				"select * from dic_city c left join com_ext_user u on u.area_code=c.id where u.user_id is null and c.is_self = '0' ");
		
		if (ups != null && !"".equals(ups)) {
			sql.append(" and c.ups=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(ups);
		}
		if (queryName != null && !"".equals(queryName)) {
			sql.append(" and c.name like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(queryName);
		}
		sql.append(" order by c.id ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;

	}

	
}
