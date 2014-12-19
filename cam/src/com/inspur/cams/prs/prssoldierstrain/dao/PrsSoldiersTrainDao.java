package com.inspur.cams.prs.prssoldierstrain.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;

import com.inspur.cams.prs.util.PrsSQL;

/**
 * @title:PrsSoldiersTrainDao
 * @description:
 * @author:
 * @since:2011-08-19
 * @version:1.0
*/
 public class PrsSoldiersTrainDao extends EntityDao<PrsSoldiersTrain> implements IPrsSoldiersTrainDao{

 	public PrsSoldiersTrainDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return PrsSoldiersTrain.class;
	}
  	public DataSet queryBySoldierId(String soldierId ){
  		return this.executeDataset(PrsSQL.SELECT_PRS_SOLDIERS_TRAIN_BY_SOLDIERS_ID,new int []{Types.VARCHAR}, new Object[]{soldierId}, true);
  	}
  	
}
