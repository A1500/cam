package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;

import com.inspur.cams.bpt.base.dao.IDicBptCareerDao;
import com.inspur.cams.bpt.base.data.DicBptCareer;

/**
 * 行政区划dao
 * @author wangbaocai
 * @date 2011-6-23
 */
public class DicBptCareerDao extends EntityDao<DicBptCareer> implements IDicBptCareerDao {
	
	// 查询下级行政区划sql
	public static String DIC_CITY_UPS_QUERY = "SELECT * FROM DIC_BPT_CAREER WHERE UPS=?"; 

  	@Override
	public Class<DicBptCareer> getEntityClass() {
		return DicBptCareer.class;
	}

	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnderling(String ups) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {ups};
		List list = executeQuery(DIC_CITY_UPS_QUERY, types, objs);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			DicBptCareer view = new DicBptCareer();
			view.setCode((String) map.get("CODE"));
			view.setName((String) map.get("NAME"));
			view.setUps((String) map.get("UPS"));
			ds.addRecord(view);
		}
		return ds;
	}
	
}
