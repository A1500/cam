package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.dao.ISomLiqpeopleDao;
import com.inspur.cams.sorg.base.data.SomLiqpeople;

/**
 * 社会组织清算组织人员dao实现类
 * 
 * @author Muqi
 * @date 2011年5月17日18:55:20
 */
public class SomLiqpeopleDao extends EntityDao<SomLiqpeople> implements
		ISomLiqpeopleDao {
	private static String deleteBySorgIdSql = "DELETE FROM SOM_LIQPEOPLE WHERE SORG_ID = ?";
	private static String QUERY_LIQPEOPLE = "SELECT * FROM SOM_LIQPEOPLE WHERE 1=1 ";
	@Override
	protected Class<SomLiqpeople> getEntityClass() {
		return SomLiqpeople.class;
	}

	/**
	 * 根据sorgId，删除社会组织清算组织人员
	 * 
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { sorgId };
		executeUpdate(deleteBySorgIdSql, types, args);
	}

	public DataSet queryNoPage(ParameterSet pset) {
		String sorgId = (String) pset.getParameter("SORG_ID@=");
		DataSet ds = new DataSet();
		if(sorgId != null && !("".equals(sorgId))){
			StringBuffer sql = new StringBuffer(QUERY_LIQPEOPLE);
			sql.append(" AND SORG_ID= ? ");
			List<Map<String,Object>> list = this.executeQuery(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{sorgId});
			for (int i = 0; i < list.size(); i++) {
				SomLiqpeople bean = new SomLiqpeople();
				bean.setId((String)list.get(i).get("ID"));
				bean.setIfChief((String)list.get(i).get("IF_CHIEF"));
				bean.setLiqDuties((String)list.get(i).get("LIQ_DUTIES"));
				bean.setName((String)list.get(i).get("NAME"));
				bean.setSorgId((String)list.get(i).get("SORG_ID"));
				bean.setWorkDuties((String)list.get(i).get("WORK_DUTIES"));
				bean.setWorkName((String)list.get(i).get("WORK_NAME"));
				ds.addRecord(bean);
			}
		}
		return ds;
	}
}
