package com.inspur.cams.sorg.check.checkpublicbenefit.dao;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.checkpublicbenefit.data.SomCheckPublicBenefit;

/**
 * @title:SomCheckPublicBenefitDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public class SomCheckPublicBenefitDao extends EntityDao<SomCheckPublicBenefit> implements ISomCheckPublicBenefitDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_PUBLIC_BENEFIT WHERE TASK_CODE = ?";
 	public SomCheckPublicBenefitDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckPublicBenefit.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckPublicBenefit");
	}
   public void deleteByTaskCode(String taskCode){
		executeUpdate(DELETE_BY_TASKCODE, new int[]{Types.VARCHAR}, new Object[]{taskCode});
	}
}
