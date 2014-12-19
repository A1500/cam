package com.inspur.cams.fis.change.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.base.data.FisCemeInfo;
import com.inspur.cams.fis.change.dao.IFisCemeChangeDao;

public class FisCemeChangeDao extends EntityDao<FisCemeInfo> implements
		IFisCemeChangeDao {

	@SuppressWarnings("unchecked")
	@Override
	protected Class<FisCemeInfo> getEntityClass() {
		return FisCemeInfo.class;
	}

	public FisCemeChangeDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	public void deleteStruAll() {
		executeUpdate("delete from FisCemeInfo");
	}

	public DataSet queryFisCemeList(ParameterSet pset) {
		String name = (String) pset.getParameter("name");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql
				.append(" select p.RECORD_ID,p.ORGAN_STATE,p.ORGAN_ID,p.NAME,p.ORGAN_CODE,p.PROP,p.ORGANIZER,p.PROPERTIES,p.LEGAL_PEOPLE,p.CHECK_YEAR,p.CHECK_RESULT,p.CUR_ORGAN_CODE from v_fis_ceme_infoandapplyinfo p ");
		sql.append(" where 1=1 and p.PROP = '2' ");
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" and p.name like ?  ");
			argsList.add(name);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args, true);
		return ds;
	}

}
