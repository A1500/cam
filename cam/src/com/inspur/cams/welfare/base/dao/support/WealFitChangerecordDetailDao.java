package com.inspur.cams.welfare.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealFitChangerecordDetailDao;
import com.inspur.cams.welfare.base.data.WealFitChangerecordDetail;

/**
 * @title:WealFitChangerecordDetailDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealFitChangerecordDetailDao extends EntityDao<WealFitChangerecordDetail> implements IWealFitChangerecordDetailDao{

 	public WealFitChangerecordDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealFitChangerecordDetail.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealFitChangerecordDetail");
	}
   
}
