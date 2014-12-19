package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.dao.ISomHeldPeopleDao;
import com.inspur.cams.sorg.base.data.SomHeldPeople;

/**
 * 社会组织发起人（自然人）dao实现类
 * @author shgtch
 * @date 2011-8-15
 */
public class SomHeldPeopleDao extends EntityDao<SomHeldPeople> implements
		ISomHeldPeopleDao {
	
	private static String deleteBySorgIdSql = "DELETE FROM SOM_HELD_PEOPLE WHERE SORG_ID = ?";
	private static String QUERY_HELD_PEOPLE = "SELECT * FROM SOM_HELD_PEOPLE WHERE 1=1";
	@Override
	public Class<SomHeldPeople> getEntityClass() {
		return SomHeldPeople.class;
	}

	/**
	 * 通过社会组织内码删除所有发起人（自然人）
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { sorgId };
		executeUpdate(deleteBySorgIdSql, types, args);
	}

	public DataSet queryHeldPeople(ParameterSet pset) {
		String sorgId = (String) pset.getParameter("SORG_ID@=");
		String taskCode = (String) pset.getParameter("TASK_CODE@=");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(QUERY_HELD_PEOPLE);
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
				SomHeldPeople bean = new SomHeldPeople();
				bean.setId((String) list.get(i).get("ID"));
				bean.setTaskCode((String) list.get(i).get("TASK_CODE"));
				bean.setSorgId((String) list.get(i).get("SORG_ID"));
				bean.setIfChief((String) list.get(i).get("IF_CHIEF"));
				bean.setName((String) list.get(i).get("NAME"));
				bean.setSex((String) list.get(i).get("SEX"));
				bean.setBirthday((String) list.get(i).get("BIRTHDAY"));
				bean.setIdCard((String) list.get(i).get("ID_CARD"));
				bean.setPolitics((String) list.get(i).get("POLITICS"));
				bean.setWorkName((String) list.get(i).get("WORK_NAME"));
				bean.setWorkDuties((String) list.get(i).get("WORK_DUTIES"));
				bean.setPopulace((String) list.get(i).get("POPULACE"));
				bean.setPhone((String) list.get(i).get("PHONE"));
				bean.setMorgName((String) list.get(i).get("MORG_NAME"));
				bean.setMorgArea((String) list.get(i).get("MORG_AREA"));
				bean.setCreatePeople((String) list.get(i).get("CREATE_PEOPLE"));
				bean.setCreateTime((String) list.get(i).get("CREATE_TIME"));
				bean.setPersonUnit((String) list.get(i).get("PERSON_UNIT"));
				ds.addRecord(bean);
			}
		}
		return ds;
	}

}
