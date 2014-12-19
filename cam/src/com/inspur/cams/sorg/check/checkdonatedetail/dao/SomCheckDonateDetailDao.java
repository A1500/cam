package com.inspur.cams.sorg.check.checkdonatedetail.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkdonatedetail.data.SomCheckDonateDetail;


/**
 * @title:SomCheckDonateDetailDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 public class SomCheckDonateDetailDao extends EntityDao<SomCheckDonateDetail> implements ISomCheckDonateDetailDao{

 	public SomCheckDonateDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckDonateDetail.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckDonateDetail");
	}
   
}
