package com.inspur.sdmz.jzzs.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.sdmz.jzzs.dao.IYgjzJzzsConfDao;
import com.inspur.sdmz.jzzs.data.YgjzJzzsConf;

/**
 * @title:YgjzJzzsConfDao
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
 public class YgjzJzzsConfDao extends EntityDao<YgjzJzzsConf> implements IYgjzJzzsConfDao{

 	public YgjzJzzsConfDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return YgjzJzzsConf.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from YgjzJzzsConf");
	}
   
}
