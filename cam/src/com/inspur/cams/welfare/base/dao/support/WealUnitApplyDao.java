package com.inspur.cams.welfare.base.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.dao.IWealUnitApplyDao;
import com.inspur.cams.welfare.base.data.*;

/**
 * @title:WealUnitApplyDao
 * @description:
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitApplyDao extends EntityDao<WealUnitApply> implements
		IWealUnitApplyDao {
	public WealUnitApplyDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return WealUnitApply.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from WealUnitApply");
	}

	public DataSet queryQualificationList(ParameterSet pset) {
		String companyName = (String) pset.getParameter("companyName");
		String dataSource = (String) pset.getParameter("dataSource");
		String applyStauts = (String) pset.getParameter("applyStauts");
		String applyType = (String) pset.getParameter("applyType");
		String applyYear = (String) pset.getParameter("applyYear");
		String serialNum = (String) pset.getParameter("serialNum");
		String morgArea = (String) pset.getParameter("morgArea");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql
				.append(" select p.TASK_CODE,p.COMPANY_NAME,p.MORG_AREA,p.SERIAL_NUM,p.APPLY_STAUTS,p.DATA_SOURCE,p.REG_DATE,p.APPLY_YEAR from v_unit_applyandinfo p ");
		sql.append("   where 1=1  ");
		if (StringUtils.isNotEmpty(companyName)) {
			sql.append(" and p.COMPANY_NAME LIKE ?  ");
			argsList.add(companyName);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(morgArea)) {
			sql.append(" and p.MORG_AREA LIKE ?  ");
			argsList.add(morgArea);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(dataSource)) {
			sql.append(" and p.DATA_SOURCE=?  ");
			argsList.add(dataSource);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyStauts)) {
			sql.append(" and p.APPLY_STAUTS=?  ");
			argsList.add(applyStauts);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyYear)) {
			sql.append(" and p.APPLY_YEAR=?  ");
			argsList.add(applyYear);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(serialNum)) {
			sql.append(" and p.SERIAL_NUM=?  ");
			argsList.add(serialNum);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyType)) {
			sql.append(" and p.APPLY_TYPE=?  ");
			argsList.add(applyType);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args, pset
				.getPageStart(), pset.getPageLimit(), true);
		return ds;
	}

	public DataSet queryQualificationPrintList(ParameterSet pset) {
		String companyName = (String) pset.getParameter("companyName");
		String dataSource = (String) pset.getParameter("dataSource");
		String applyStauts = (String) pset.getParameter("applyStauts");
		String applyType = (String) pset.getParameter("applyType");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql
				.append(" select p.TASK_CODE,p.COMPANY_NAME,p.APPLY_STAUTS,p.DATA_SOURCE,p.REG_DATE,p.CITY_CHIEF_BASE_OPINION from v_unit_applyandinfo p ");
		sql.append("   where   p.APPLY_STAUTS in('4','5') ");
		if (StringUtils.isNotEmpty(companyName)) {
			sql.append(" and p.COMPANY_NAME=?  ");
			argsList.add(companyName);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(dataSource)) {
			sql.append(" and p.DATA_SOURCE=?  ");
			argsList.add(dataSource);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyStauts)) {
			sql.append(" and p.APPLY_STAUTS=?  ");
			argsList.add(applyStauts);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyType)) {
			sql.append(" and p.APPLY_TYPE=?  ");
			argsList.add(applyType);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args, pset
				.getPageStart(), pset.getPageLimit(), true);
		return ds;
	}

	public DataSet queryCheck(ParameterSet pset) {
		String unitId = (String) pset.getParameter("unitId");
		String applyStauts = (String) pset.getParameter("applyStauts");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql
				.append(" select p.TASK_CODE,p.UNIT_ID,p.COUNTY_CHARGE_BASE_OPINION,p.COUNTY_CHARGE_TIME,p.COUNTY_CHIEF_BASE_OPINION,p.COUNTY_CHIEF_TIME,p.CITY_CHARGE_BASE_OPINION,p.CITY_CHARGE_TIME,p.CITY_CHIEF_BASE_OPINION,p.CITY_CHIEF_TIME,p.APPLY_YEAR from v_unit_check p ");
		sql.append("   where  1 = 1 and p.APPLY_TYPE = '2' ");
		if (StringUtils.isNotEmpty(unitId)) {
			sql.append(" and p.UNIT_ID = ? ");
			argsList.add(unitId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyStauts)) {
			sql.append(" and p.APPLY_STAUTS in ('4','5') ");
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args, pset
				.getPageStart(), pset.getPageLimit(), true);
		return ds;
	}
}
