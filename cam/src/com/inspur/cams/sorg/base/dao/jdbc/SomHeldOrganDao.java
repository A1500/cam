package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.dao.ISomHeldOrganDao;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;

/**
 * 社会组织发起人（单位）dao实现类
 * @author shgtch
 * @date 2011-8-15
 */
public class SomHeldOrganDao extends EntityDao<SomHeldOrgan> implements
		ISomHeldOrganDao {
	
	private static String deleteBySorgIdSql = "DELETE FROM SOM_HELD_ORGAN WHERE SORG_ID = ?";
	private static String QUERY_HELD_ORGAN = "SELECT * FROM SOM_HELD_ORGAN WHERE 1=1";
	@Override
	public Class<SomHeldOrgan> getEntityClass() {
		return SomHeldOrgan.class;
	}

	/**
	 * 通过社会组织内码删除所有发起人（单位）
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { sorgId };
		executeUpdate(deleteBySorgIdSql, types, args);
	}

	public DataSet queryHeldOrgan(ParameterSet pset) {
		String sorgId = (String) pset.getParameter("SORG_ID@=");
		String taskCode = (String) pset.getParameter("TASK_CODE@=");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(QUERY_HELD_ORGAN);
		DataSet ds = new DataSet();
		if(sorgId != null && !("".equals(sorgId))){
			sql.append(" AND SORG_ID = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgId);
		}
		if(taskCode != null && !("".equals(taskCode))){
			sql.append(" AND TASK_CODE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(taskCode);
		}
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			List<Map<String,Object>> list = this.executeQuery(sql.toString(), types, args);
			for (int i = 0; i < list.size(); i++) {
				SomHeldOrgan bean = new SomHeldOrgan();
				bean.setId((String) list.get(i).get("ID"));
				bean.setTaskCode((String) list.get(i).get("TASK_CODE"));
				bean.setSorgId((String) list.get(i).get("SORG_ID"));
				bean.setName((String) list.get(i).get("NAME"));
				bean.setSituation((String) list.get(i).get("SITUATION"));
				bean.setHeldorganPeople((String) list.get(i).get("HELDORGAN_PEOPLE"));
				bean.setPhone((String) list.get(i).get("PHONE"));
				bean.setMorgName((String) list.get(i).get("MORG_NAME"));
				bean.setMorgArea((String) list.get(i).get("MORG_AREA"));
				bean.setCreatePeople((String) list.get(i).get("CREATE_PEOPLE"));
				bean.setCreateTime((String) list.get(i).get("CREATE_TIME"));
				ds.addRecord(bean);
			}
		}
		return ds;
	}

}
