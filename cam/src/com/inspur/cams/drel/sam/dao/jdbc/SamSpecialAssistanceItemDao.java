package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamSpecialAssistanceItemDao;
import com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem;

/**
 * @title:SamSpecialAssistanceItemDao
 * @description:
 * @author:
 * @since:2012-05-17
 * @version:1.0
*/
 public class SamSpecialAssistanceItemDao extends EntityDao<SamSpecialAssistanceItem> implements ISamSpecialAssistanceItemDao{

 	public SamSpecialAssistanceItemDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamSpecialAssistanceItem.class;
	}
   
}
