package com.inspur.cams.drel.special.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.drel.special.data.SpecialpoorFamily;

/**
 * @title:SpecialpoorFamilyDao
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
 */
public class SpecialpoorFamilyDao extends EntityDao<SpecialpoorFamily>
		implements ISpecialpoorFamilyDao {

	public SpecialpoorFamilyDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SpecialpoorFamily.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SpecialpoorFamily");
	}

	/**
	 * @Description: 特殊困难户分致贫原因统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByType(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "BP_DREL_SPECIAL_TYPE_QUERY");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "in_area_code");
		map.put("NumberOfResultSet", 1);
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qOrganCode = (String) pset.getParameter("qOrganCode");// 户口所在地
		map.put("parameterValue_1", qOrganCode);

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
	 * @Description: 特殊困难户分地区统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByArea(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "BP_DREL_SPECIAL_AREA_QUERY");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "in_area_code");
		map.put("NumberOfResultSet", 1);
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qOrganCode = (String) pset.getParameter("qOrganCode");// 户口所在地
		map.put("parameterValue_1", qOrganCode);

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
	 * 删除一条家庭信息
	 */
	public void deleteFamily(String familyId) {
		StringBuffer s = new StringBuffer("DELETE FROM SPECIALPOOR_FAMILY T WHERE T.FAMILY_ID = ? ");
		
		this.executeUpdate(s.toString(), new int[]{Types.VARCHAR}, new Object[]{familyId});
	}
	/**
	 * 根据帮包村代码获取帮扶单位
	 */
	public String getSupportName(String helpVillageCode) {
		StringBuffer querySql = new StringBuffer("select  u.support_unit_name from specialpoor_support_ref t left join specialpoor_support_unit u on t.support_unit_code = u.support_unit_code where   t.help_village_code =  ? ");
		DataSet ds = executeDataset(querySql.toString(), new int[]{Types.VARCHAR}, new Object[]{helpVillageCode}, true);
		if(ds.getCount() > 0 ){
			return (String)ds.getRecord(0).get("SUPPORT_UNIT_NAME");
		}else{
			return "";
		}
	}
	/**
	 * @Description: 特殊困难户省直单位统计
	 * @author yll
	 */
	public DataSet queryBySupport(ParameterSet pset) {
		StringBuffer querySql = new StringBuffer("select u.support_unit_code support_unit_code,u.support_unit_name support_unit_name,b.family_sum family_sum , b.people_num  people_num from specialpoor_support_unit u  left join ( ");
		querySql.append("select support_unit_code , nvl(sum(m.family_sum),0) family_sum , nvl(sum(m.people_num),0) people_num ");
		querySql.append("from specialpoor_support_ref r ");
		querySql.append(" left join (select t.help_village_code, ");
		querySql.append("                   count(*) family_sum, ");
		querySql.append("                   sum(t.people_num) people_num ");
		querySql.append("              from specialpoor_family t ");
		querySql.append("              group by t.help_village_code) m on r.help_village_code = ");
		querySql.append("                                                 m.help_village_code  group by r.support_unit_code ");
		querySql.append(" ) b   on b.support_unit_code = u.support_unit_code order by u.support_unit_type_code  ");
		DataSet ds = executeDataset(querySql.toString(), true);
		return ds;
	}
}
