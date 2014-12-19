package com.inspur.cams.prs.prssoldiersarmy.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import java.sql.Types;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.prs.util.PrsSQL;

/**
 * @title:PrsSoldiersArmyDao
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
*/
 public class PrsSoldiersArmyDao extends EntityDao<PrsSoldiersArmy> implements IPrsSoldiersArmyDao{

 	public PrsSoldiersArmyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return PrsSoldiersArmy.class;
	}

	public DataSet queryBySoldierId(ParameterSet pset) {
		String soldierId = (String) pset.getParameter("SOLDIERS_ID");
		return this.executeDataset(PrsSQL.SELECT_ARMY_BY_SOLDIER_ID, new int[]{Types.VARCHAR}, new Object[]{soldierId}, true);
	}
}
