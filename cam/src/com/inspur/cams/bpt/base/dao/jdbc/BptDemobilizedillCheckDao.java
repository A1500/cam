package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptDemobilizedillCheckDao;
import com.inspur.cams.bpt.base.data.BptDemobilizedillnessCheck;

/**
 * @title:BptPhysicalExaminationDao
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 public class BptDemobilizedillCheckDao extends EntityDao<BptDemobilizedillnessCheck> implements IBptDemobilizedillCheckDao{
 	public BptDemobilizedillCheckDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
  	@Override
	public Class<BptDemobilizedillnessCheck> getEntityClass() {
		return BptDemobilizedillnessCheck.class;
	}
  	
}
