package com.inspur.cams.prs.prsTrainDic.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:DicPrsTrainFieldDao
 * @description:
 * @author:
 * @since:2012-09-21
 * @version:1.0
*/
 public class DicPrsTrainFieldDao extends EntityDao<DicPrsTrainField> implements IDicPrsTrainFieldDao{

 	public DicPrsTrainFieldDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<DicPrsTrainField> getEntityClass() {
		return DicPrsTrainField.class;
	}
   
}
