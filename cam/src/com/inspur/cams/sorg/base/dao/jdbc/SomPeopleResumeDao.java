package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.base.dao.ISomPeopleResumeDao;
import com.inspur.cams.sorg.base.data.SomPeopleResume;

/**
 * @title:SomPeopleResumeDao
 * @description:
 * @author:
 * @since:2011-10-31
 * @version:1.0
 */
public class SomPeopleResumeDao extends EntityDao<SomPeopleResume> implements
		ISomPeopleResumeDao {
	public static String DELETE_RESUME = "DELETE FROM SOM_PEOPLE_RESUME D ";
	public static String QUERY_RESUME_NO_PAGE = "SELECT * FROM SOM_PEOPLE_RESUME T WHERE 1=1";
	
	public SomPeopleResumeDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomPeopleResume.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomPeopleResume");
	}

	public void deleteResume(String taskCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_RESUME);
		if (taskCode != null && !"".equals(taskCode)) {
			sql.append(" WHERE D.TASK_CODE= ?");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { taskCode };
			executeUpdate(sql.toString(), types, args);
		}
	}

	public void deleteResumeByDutyId(String dutyId) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_RESUME);
		if (dutyId != null && !"".equals(dutyId)) {
			sql.append(" WHERE D.DUTY_ID= ?");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { dutyId };
			executeUpdate(sql.toString(), types, args);
		}
	}

	public DataSet executeQuery(ParameterSet pset) {
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String dutyId = (String) pset.getParameter("DUTY_ID");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(QUERY_RESUME_NO_PAGE);
		DataSet ds = new DataSet();
		if(taskCode!=null && !("".equals(taskCode))){
			sql.append(" AND T.TASK_CODE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(taskCode);
		}
		if(dutyId!=null && !("".equals(dutyId))){
			sql.append(" AND T.DUTY_ID=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(dutyId);
		}
		sql.append(" order by start_date DESC");
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			List<Map<String,String>> list = this.executeQuery(sql.toString(),types,args);
			for (int i = 0; i < list.size(); i++) {
				SomPeopleResume bean = new SomPeopleResume();
				bean.setId(list.get(i).get("ID"));
				bean.setTaskCode(list.get(i).get("TASK_CODE"));
				bean.setDutyId(list.get(i).get("DUTY_ID"));
				bean.setPeopleId(list.get(i).get("PEOPLE_ID"));
				bean.setStartDate(list.get(i).get("START_DATE"));
				bean.setEndDate(list.get(i).get("END_DATE"));
				bean.setWorkOrgan(list.get(i).get("WORK_ORGAN"));
				bean.setDuty(list.get(i).get("DUTY"));
				ds.addRecord(bean);
			}
		}
		return ds;
	}
}
