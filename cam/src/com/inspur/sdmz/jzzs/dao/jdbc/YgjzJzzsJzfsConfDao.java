package com.inspur.sdmz.jzzs.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.sdmz.jzzs.dao.IYgjzJzzsJzfsConfDao;
import com.inspur.sdmz.jzzs.data.YgjzJzzsJzfsConf;

/**
 * @title:YgjzJzzsJzfsConfDao
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
 public class YgjzJzzsJzfsConfDao extends EntityDao<YgjzJzzsJzfsConf> implements IYgjzJzzsJzfsConfDao{

 	public YgjzJzzsJzfsConfDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return YgjzJzzsJzfsConf.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from YgjzJzzsJzfsConf");
	}
   
}
