package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.base.dao.IBptPhysicalExaminationDao;
import com.inspur.cams.bpt.base.data.BptPhysicalExamination;

/**
 * @title:BptPhysicalExaminationDao
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 public class BptPhysicalExaminationDao extends EntityDao<BptPhysicalExamination> implements IBptPhysicalExaminationDao{
 	public BptPhysicalExaminationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
  	@Override
	public Class<BptPhysicalExamination> getEntityClass() {
		return BptPhysicalExamination.class;
	}
}
