package com.inspur.cams.dis.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.dis.base.dao.IDisYearCostSheetDao;
import com.inspur.cams.dis.base.data.DisYearCostSheet;
/**
 * @title:DisYearCostSheetDao
 * @description:
 * @author:
 * @since:2012-10-09
 * @version:1.0
*/
 public class DisYearCostSheetDao extends EntityDao<DisYearCostSheet> implements IDisYearCostSheetDao{

 	public DisYearCostSheetDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return DisYearCostSheet.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from DisYearCostSheet");
	}
   
}
