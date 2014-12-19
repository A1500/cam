package com.inspur.sdmz.jzfa.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.sdmz.jzfa.dao.IComPlanOrganDao;
import com.inspur.sdmz.jzfa.data.ComPlanOrgan;

/**
 * @title:ComPlanOrganDao
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
 public class ComPlanOrganDao extends EntityDao<ComPlanOrgan> implements IComPlanOrganDao{

 	public ComPlanOrganDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return ComPlanOrgan.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from ComPlanOrgan");
	}
   
   public void deleteById(String id){
	   StringBuffer sql=new StringBuffer();
	   sql.append("delete from COM_PLAN_ORGAN WHERE PLAN_ID='").append(id).append("'");
	   executeUpdate(sql.toString());
   }
}
