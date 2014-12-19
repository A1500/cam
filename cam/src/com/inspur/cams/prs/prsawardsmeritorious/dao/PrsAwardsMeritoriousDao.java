package com.inspur.cams.prs.prsawardsmeritorious.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.prs.util.PrsSQL;

/**
 * @title:PrsAwardsMeritoriousDao
 * @description:
 * @author:
 * @since:2011-08-23
 * @version:1.0
*/
 public class PrsAwardsMeritoriousDao extends EntityDao<PrsAwardsMeritorious> implements IPrsAwardsMeritoriousDao{

 	public PrsAwardsMeritoriousDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return PrsAwardsMeritorious.class;
	}

	public DataSet getAwardsList(ParameterSet pset) {
		String solderId = (String) pset.getParameter("SOLDIERS_ID");
		return this.executeDataset(PrsSQL.SELECT_AWARDS_MERITORIOUS_BY_SOLDIER_ID, new int[]{Types.VARCHAR}, new Object[]{solderId}, true);
	}
}
