package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmLevelEvalutionInfoDao;
import com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo;

/**
 * @title:MrmLevelEvalutionInfoDao
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 public class MrmLevelEvalutionInfoDao extends EntityDao<MrmLevelEvalutionInfo> implements IMrmLevelEvalutionInfoDao{

 	public MrmLevelEvalutionInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmLevelEvalutionInfo.class;
	}
   
}
