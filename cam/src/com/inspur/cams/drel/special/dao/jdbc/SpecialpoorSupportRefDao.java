package com.inspur.cams.drel.special.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.drel.special.dao.ISpecialpoorSupportRefDao;
import com.inspur.cams.drel.special.data.SpecialpoorSupportRef;

/**
 * 帮扶关系表dao
 * 
 * @author
 * @date 2013-08-12
 */
public class SpecialpoorSupportRefDao extends EntityDao<SpecialpoorSupportRef>
		implements ISpecialpoorSupportRefDao {

	@Override
	public Class<SpecialpoorSupportRef> getEntityClass() {
		return SpecialpoorSupportRef.class;
	}

	/**
	 * 查询帮扶单位与帮扶村的关系数据
	 * 
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSupportRef(ParameterSet pset) {
//		String helpVillageCode = (String)pset.getParameter("helpVillageCode");
//		String helpVillageName = (String)pset.getParameter("helpVillageName");
		String supportUnitCode = (String)pset.getParameter("supportUnitCode");
		String supportUnitName = (String)pset.getParameter("supportUnitName");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT SU.*,AAA.HELP_VILLAGE_NAME FROM SPECIALPOOR_SUPPORT_UNIT SU LEFT JOIN");
		sql.append(" (SELECT SUPPORT_UNIT_CODE,SUPPORT_UNIT_NAME, LISTAGG(HELP_VILLAGE_NAME, ',') WITHIN GROUP (ORDER BY HELP_VILLAGE_NAME) AS HELP_VILLAGE_NAME FROM");
		sql.append(" (SELECT R.RECORD_ID,U.SUPPORT_UNIT_CODE,U.SUPPORT_UNIT_NAME,R.HELP_VILLAGE_CODE,V.HELP_VILLAGE_NAME,V.HELP_VILLAGE_FLAG");
		sql.append(" FROM SPECIALPOOR_SUPPORT_REF R JOIN SPECIALPOOR_HELP_VILLAGE V ON R.HELP_VILLAGE_CODE = V.HELP_VILLAGE_CODE");
		sql.append(" JOIN SPECIALPOOR_SUPPORT_UNIT U ON R.SUPPORT_UNIT_CODE = U.SUPPORT_UNIT_CODE");
		sql.append(" ) AA GROUP BY SUPPORT_UNIT_CODE,SUPPORT_UNIT_NAME");
		sql.append(" ) AAA ON SU.SUPPORT_UNIT_CODE=AAA.SUPPORT_UNIT_CODE WHERE 1=1");
		if (StringUtils.isNotEmpty(supportUnitCode)) {
			sql.append(" AND SU.SUPPORT_UNIT_CODE LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			objList.add(supportUnitCode);
		}
		if (StringUtils.isNotEmpty(supportUnitName)) {
			sql.append(" AND SU.SUPPORT_UNIT_NAME LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			objList.add(supportUnitName);
		}
		sql.append(" ORDER BY SU.SUPPORT_UNIT_CODE");
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

	/**
	 * 查询帮扶单位指定的帮扶村数据
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorHelpVillage(ParameterSet pset) {
		String supportUnitCode = (String)pset.getParameter("supportUnitCode");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT R.RECORD_ID,U.SUPPORT_UNIT_CODE,U.SUPPORT_UNIT_NAME,R.HELP_VILLAGE_CODE,V.HELP_VILLAGE_NAME,V.HELP_VILLAGE_FLAG");
		sql.append(" FROM SPECIALPOOR_SUPPORT_REF R ");
		sql.append(" JOIN SPECIALPOOR_HELP_VILLAGE V ON R.HELP_VILLAGE_CODE=V.HELP_VILLAGE_CODE");
		sql.append(" JOIN SPECIALPOOR_SUPPORT_UNIT U ON R.SUPPORT_UNIT_CODE=U.SUPPORT_UNIT_CODE WHERE 1=1");
		if (StringUtils.isNotEmpty(supportUnitCode)) {
			sql.append(" AND U.SUPPORT_UNIT_CODE LIKE ?||'%'");
			typeList.add(Types.VARCHAR);
			objList.add(supportUnitCode);
		}
		sql.append(" ORDER BY U.SUPPORT_UNIT_CODE,R.RECORD_ID");
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
}